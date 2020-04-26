#include "kardexmodel.h"

#include "model/serieboleta.h"
#include "model/tipooperacion.h"
#include "model/proveedor.h"

#include "util.h"

#include <QMap>
#include <QDebug>

KardexModel::KardexModel(QObject *parent)
    : QAbstractTableModel(parent), load_boletas(false)
{
    m_controller = new GetController(this);
    connect(m_controller,SIGNAL(replyFinishedJsArr(QVariantList )), this, SLOT(replyFinishedJsArr(QVariantList )));
    m_controller->setUrl(QUrl( Util::serverHost + "/rest/tipojabamatriz"));
    m_controller->send();
}

int KardexModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_items.count();
}

int KardexModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return 4+(m_grupos.count()*2);
}

QVariant KardexModel::data(const QModelIndex &index, int role) const
{
    (void) role;
    const int row= index.row();
    const int col = index.column();

    QVariant result;
    if (!index.isValid())
        return QVariant();

    if (row >= m_items.count() || row < 0)
        return QVariant();

    ItemKardex *itm = m_items.at(row);
    if(col == 0){
        result = itm->fecha();
    }else if (col == 1) {
        result = QVariant::fromValue( itm->proveedor()->name());
    }else if (col == 2) {
        result = QVariant::fromValue( itm->serie()->value());
    }else if (col == 3) {
        result = QVariant(itm->numeracion());
    }else if (col > 3) {
        int lst_index = col - 4;
        if(m_grupos.count()>lst_index){
            int cnt = itm->getEntradas().at(lst_index).cantidad;
            if(cnt == 0)
                result = QVariant("");
            else
                result = QVariant(cnt);
        }else{
            int lst2_index = lst_index - m_grupos.count();
            int cnt = itm->getSalidas().at(lst2_index).cantidad;
            if(cnt == 0)
                result = QVariant("");
            else
                result = QVariant(cnt);
        }
    }

    return result;
}

void KardexModel::loadItems()
{
    clearItems();
    m_controller->setUrl(QUrl( Util::serverHost + "/rest/boleta"));
    m_controller->send();
}

int KardexModel::itemsCount() const
{
    return m_items.count();
}

ItemKardex *KardexModel::itemsAt(int index) const
{
    return m_items.at(index);
}

void KardexModel::clearItems()
{
    beginRemoveRows(QModelIndex(),0,rowCount()-1);
    m_items.clear();
    endRemoveRows();
}

QQmlListProperty<ItemKardex> KardexModel::items()
{
    return {this, this,
                &KardexModel::appendItems,
                &KardexModel::itemsCount,
                &KardexModel::itemsAt,
                &KardexModel::clearItems};
}

void KardexModel::appendItems(ItemKardex * const &itm)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items.append(itm);
    endInsertRows();
}

void KardexModel::replyFinishedJsArr(QVariantList arrResponse)
{
    if(!load_boletas){
        for (int i=0; i < arrResponse.count(); i++){
            QVariantMap obj = arrResponse.at(i).value<QVariantMap>();
            m_grupos.append(new TipoJabaMatriz(
                                obj.value("id").toString(),
                                obj.value("name").toString(),
                                obj.value("abreviacion").toString()
                                ) );
        }
        load_boletas = true;
    }else{
        beginInsertRows(QModelIndex(),rowCount(), arrResponse.count()-1);

        for(int p=0; p < arrResponse.count(); p++){
            ItemKardex * i_k = new ItemKardex();
            QVariantMap obj = arrResponse.at(p).value<QVariantMap>();
            i_k->setFecha(obj.value("fecha").toString());
            QVariantMap obj_proveedor = obj.value("proveedor").value<QVariantMap>();
            i_k->setProveedor(new Proveedor(
                                  obj_proveedor.value("id").toString(),
                                  obj_proveedor.value("name").toString(),
                                  obj_proveedor.value("firstName").toString(),
                                  obj_proveedor.value("lastName").toString(),
                                  nullptr
                                  ));
            QVariantMap obj_serie = obj.value("serie").value<QVariantMap>();
            i_k->setSerie(new SerieBoleta(
                              obj_serie.value("id").toString(),
                              obj_serie.value("value").toString(),
                              obj_serie.value("nota").toString(),
                              nullptr));
            i_k->setNumeracion(obj.value("numeracion").toUInt());

            QVariantList obj_entradas = obj.value("itemsEntrada").value<QVariantList>();
            for(int q=0; q < m_grupos.count(); q++){
                QString nTipoJaba = "e_" + m_grupos.at(q)->name().toLower();
                int cantidad = 0;
                for(int qq=0; qq < obj_entradas.count(); qq++){
                    QVariantMap obj_entrada = obj_entradas.at(qq).value<QVariantMap>();
                    QVariantList obj_entrada_tipoJaba = obj_entrada.value("tipoJaba").value<QVariantList>();
                    for(int qqq=0; qqq < obj_entrada_tipoJaba.count(); qqq++){
                        QVariantMap inner_tipoJaba = obj_entrada_tipoJaba.at(qqq).value<QVariantMap>();
                        if(nTipoJaba == "e_" + inner_tipoJaba.value("tipoJaba").value<QVariantMap>().value("name").toString().toLower() ){
                            cantidad += inner_tipoJaba.value("cantidad").toInt();
                        }
                    }
                }
                i_k->appendEntradas({m_grupos.at(q)->name(), cantidad});
            }

            QVariantList obj_salidas = obj.value("itemsSalida").value<QVariantList>();
            for(int r=0; r < m_grupos.count(); r++){
                QString nTipoJaba = "s_" + m_grupos.at(r)->name().toLower();
                int cantidad = 0;
                for(int rr=0; rr < obj_salidas.count(); rr++){
                    QVariantMap obj_salida = obj_salidas.at(rr).value<QVariantMap>();
                    QVariantList obj_salida_tipoJaba = obj_salida.value("tipoJaba").value<QVariantList>();
                    for(int rrr=0; rrr < obj_salida_tipoJaba.count(); rrr++){
                        QVariantMap inner_tipoJaba = obj_salida_tipoJaba.at(rrr).value<QVariantMap>();
                        if(nTipoJaba == "s_"+inner_tipoJaba.value("tipoJaba").value<QVariantMap>().value("name").toString().toLower() ){
                            cantidad += inner_tipoJaba.value("cantidad").toInt();
                        }
                    }
                }
                i_k->appendSalidas({m_grupos.at(r)->name(), cantidad});
            }
            m_items.append(i_k);
        }

        endInsertRows();
        emit loadKardexFinish();
        qDebug()<<"Items kardex cargados: "<<m_items.count();
    }
}

QHash<int, QByteArray> KardexModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles.insert(Qt::DisplayRole, "display");
//    roles.insert(0, "fecha");
//    roles.insert(1, "proveeedor");
//    roles.insert(2, "serie");
//    roles.insert(3, "numeracion");

//    //ejemplo para tipoJaba: Color -> e_color
//    for(int i=0; i < m_grupos.count(); i++){
//        roles.insert(4+i,("e_"+m_grupos.at(i)->name().toLower()).toUtf8());
//        roles.insert(4+m_grupos.count()+i,("s_"+m_grupos.at(i)->name().toLower()).toUtf8());
//    }

    return roles;
}

QList<ItemKardex *> KardexModel::getItems() const
{
    return m_items;
}

void KardexModel::appendItems(QQmlListProperty<ItemKardex> *lst, ItemKardex *itm)
{
    reinterpret_cast<KardexModel *>(lst->object)->appendItems(itm);
}

int KardexModel::itemsCount(QQmlListProperty<ItemKardex> *lst)
{
    return reinterpret_cast<KardexModel *>(lst->object)->itemsCount();
}

ItemKardex *KardexModel::itemsAt(QQmlListProperty<ItemKardex> *lst, int index)
{
    return reinterpret_cast<KardexModel *>(lst->object)->itemsAt(index);
}

void KardexModel::clearItems(QQmlListProperty<ItemKardex> *lst)
{
    reinterpret_cast<KardexModel *>(lst->object)->clearItems();
}

//QVariant KardexModel::headerData(int section, Qt::Orientation orientation, int role) const
//{
//    if (role != Qt::DisplayRole)
//        return QVariant();

//    if (orientation == Qt::Horizontal) {
//        if(section == 0){
//            return "fecha";
//        }else if (section == 1) {
//            return "proveedor";
//        }else if (section == 2) {
//            return "serie";
//        }else if (section == 3) {
//            return "numeracion";
//        }else if (section > 3) {
//            int lst_index = section - 4;
//            if(m_grupos.count()>lst_index){
//                return "e_"+m_grupos.at(lst_index)->name().toLower();
//            }else{
//                int lst2_index = lst_index - m_grupos.count();
//                return "s_"+m_grupos.at(lst2_index)->name().toLower();
//            }
//        }

//    }
//    return QVariant();
//}
