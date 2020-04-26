#include "boletamodel.h"
#include <QUrl>
#include <QDebug>

#include "model/serieboleta.h"
#include "model/tipooperacion.h"
#include "model/proveedor.h"
#include "model/tipojaba.h"
#include "model/tipojabamatriz.h"
#include "model/itemsdetailboleta.h"
#include "util.h"

BoletaModel::BoletaModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_boletaController = new GetController(this);
    connect(m_boletaController,SIGNAL(replyFinishedJsArr(QVariantList )), this, SLOT(replyFinishedJsArr(QVariantList )));
    m_boletaController->setUrl(QUrl( Util::serverHost + "/rest/boleta"));
}

int BoletaModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_boletas.count();
}

QVariant BoletaModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch(role){
    case IdRole:
        return QVariant(m_boletas.at(index.row())->_id());
    case SerieRole:
        return QVariant::fromValue(m_boletas.at(index.row())->serie());
    case NumeracionRole:
        return QVariant((unsigned long long)m_boletas.at(index.row())->numeracion());
    case FechaRole:
        return QVariant(m_boletas.at(index.row())->fecha());
    case ProveedorRole:
        return QVariant::fromValue(m_boletas.at(index.row())->proveedor());
    case NotaRole:
        return QVariant(m_boletas.at(index.row())->nota());
    case ItemsEntradaRole:
        return QVariant::fromValue(m_boletas.at(index.row())->itemsEntradasList());
    case ItemsSalidaRole:
        return QVariant::fromValue(m_boletas.at(index.row())->itemsSalidaList());
    case VentaRole:
        return QVariant(m_boletas.at(index.row())->venta());
    case CloseRole:
        return QVariant(m_boletas.at(index.row())->close());
    }

    return QVariant();
}

bool BoletaModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {

        switch(role){
        case IdRole:
            m_boletas.at(index.row())->set_id(value.toString());
            break;
        case SerieRole:
            m_boletas.at(index.row())->setSerie(value.value<SerieBoleta *>());
            break;
        case NumeracionRole:
            m_boletas.at(index.row())->setNumeracion(value.toLongLong());
            break;
        case FechaRole:
            m_boletas.at(index.row())->setFecha(value.toString());
            break;
        case ProveedorRole:
            m_boletas.at(index.row())->setProveedor(value.value<Proveedor *>());
            break;
        case NotaRole:
            m_boletas.at(index.row())->setNota(value.toString());
            break;
        case ItemsEntradaRole:
            m_boletas.at(index.row())->setItemsEntradas(value.value<QList<ItemsDetailBoleta *>>());
            break;
        case ItemsSalidaRole:
            m_boletas.at(index.row())->setItemsSalida(value.value<QList<ItemsDetailBoleta *>>());
            break;
        case VentaRole:
            m_boletas.at(index.row())->setVenta(value.toBool());
            break;
        case CloseRole:
            m_boletas.at(index.row())->setClose(value.toBool());
            break;
        }

        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags BoletaModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

QHash<int, QByteArray> BoletaModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[IdRole] = "id";
    names[SerieRole] = "serie";
    names[NumeracionRole] = "numeracion";
    names[FechaRole] = "fecha";
    names[ProveedorRole] = "proveedor";
    names[NotaRole] = "nota";
    names[ItemsEntradaRole] = "itemsEntrada";
    names[ItemsSalidaRole] = "itemsSalida";
    names[VentaRole] = "venta";
    names[CloseRole] = "close";
    return names;
}

void BoletaModel::loadData()
{
    m_boletaController->send();
}

QQmlListProperty<Boleta> BoletaModel::boletas()
{
    return {this, this,
                &BoletaModel::appendBoleta,
                &BoletaModel::boletasCount,
                &BoletaModel::boletaAt,
                &BoletaModel::clearBoletas};
}

void BoletaModel::appendBoleta(Boleta * const &b)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_boletas.append(b);
    endInsertRows();
}

int BoletaModel::boletasCount() const
{
    return m_boletas.count();
}

Boleta *BoletaModel::boletaAt(int index) const
{
    return m_boletas.at(index);
}

void BoletaModel::clearBoletas()
{
    m_boletas.clear();
}

void BoletaModel::replyFinishedJsArr(QVariantList arrResponse)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    for(int i=0; i < arrResponse.count(); i++){
        QVariantMap obj = arrResponse.at(i).value<QVariantMap>();

        Boleta *b = new Boleta();
        b->set_id(obj.value("id").toString());
            SerieBoleta *serie = new SerieBoleta();
            QVariantMap _serie = obj.value("serie").value<QVariantMap>();
            serie->set_id(_serie.value("id").toString());
            serie->setNota(_serie.value("nota").toString());
            serie->setValue(_serie.value("value").toString());
                QVariantMap _operacion = _serie.value("operacion").value<QVariantMap>();
                TipoOperacion *operacion = new TipoOperacion();
                operacion->set_id(_operacion.value("id").toString());
                operacion->setName(_operacion.value("name").toString());
                operacion->setDescription(_operacion.value("description").toString());
            serie->setOperacion(operacion);
        b->setSerie(serie);
        b->setNumeracion(obj.value("numeracion").toLongLong());
        b->setFecha(obj.value("fecha").toString());
            QVariantMap _proveedor = obj.value("proveedor").value<QVariantMap>();
            Proveedor *proveedor = new Proveedor();
            proveedor->set_id(_proveedor.value("id").toString());
            proveedor->setName(_proveedor.value("name").toString());
            proveedor->setFirstName(_proveedor.value("firstName").toString());
            proveedor->setLastName(_proveedor.value("lastName").toString());
                QVariantMap _prov_tipojaba = _proveedor.value("tipoJaba").value<QVariantMap>();
                TipoJabaMatriz *prov_tipojaba = new TipoJabaMatriz();
                prov_tipojaba->set_id(_prov_tipojaba.value("id").toString());
                prov_tipojaba->setName(_prov_tipojaba.value("name").toString());
                prov_tipojaba->setAbreviacion(_prov_tipojaba.value("abreviacion").toString());
                proveedor->setTipoJaba(prov_tipojaba);
        b->setProveedor(proveedor);
        b->setNota(obj.value("nota").toString());
            QVariantList _itemsentrada = obj.value("itemsEntrada").value<QVariantList>();
            for(int p=0; p < _itemsentrada.count(); p++){
                QVariantMap _item = _itemsentrada.at(p).value<QVariantMap>();
                ItemsDetailBoleta *item = new ItemsDetailBoleta();
                item->set_id(_item.value("id").toString());
                item->setCantidad(_item.value("cantidad").toInt());
                item->setPeso(_item.value("peso").toFloat());

                QVariantList _entradas_tipojaba = _item.value("tipoJaba").value<QVariantList>();
                for(int q=0; q < _entradas_tipojaba.count(); q++){
                    QVariantMap _tjaba = _entradas_tipojaba.at(q).value<QVariantMap>();
                    TipoJaba *tjaba = new TipoJaba();
                    tjaba->set_id(_tjaba.value("id").toString());
                    tjaba->setCantidad(_tjaba.value("cantidad").toInt());
                        QVariantMap _tb_tjaba = _tjaba.value("tipoJaba").value<QVariantMap>();
                        TipoJabaMatriz *tb_tjaba = new TipoJabaMatriz();
                        tb_tjaba->set_id(_tb_tjaba.value("id").toString());
                        tb_tjaba->setName(_tb_tjaba.value("name").toString());
                        tb_tjaba->setAbreviacion(_tb_tjaba.value("abreviacion").toString());
                    tjaba->setTipoJaba(tb_tjaba);
                    item->appendTipoJaba(tjaba);
                }
                b->appendItemsEntradas(item) ;
            }

        QList<ItemsDetailBoleta *> itemssalida;
        QVariantList _itemssalida = obj.value("itemsSalida").value<QVariantList>();
        for(int r=0; r < _itemssalida.count(); r++){
            QVariantMap _item = _itemssalida.at(r).value<QVariantMap>();
            ItemsDetailBoleta *item = new ItemsDetailBoleta();
            item->set_id(_item.value("id").toString());
            item->setCantidad(_item.value("cantidad").toInt());
            item->setPeso(_item.value("peso").toFloat());
            QList<TipoJaba *> salidas_tipojaba;
            QVariantList _salidas_tipojaba = _item.value("tipoJaba").value<QVariantList>();
            for(int s=0; s < _salidas_tipojaba.count(); s++){
                QVariantMap _tjaba = _salidas_tipojaba.at(s).value<QVariantMap>();
                TipoJaba *tjaba = new TipoJaba();
                tjaba->set_id(_tjaba.value("id").toString());
                tjaba->setCantidad(_tjaba.value("cantidad").toInt());
                    QVariantMap _tb_tjaba = _tjaba.value("tipoJaba").value<QVariantMap>();
                    TipoJabaMatriz *tb_tjaba = new TipoJabaMatriz();
                    tb_tjaba->set_id(_tb_tjaba.value("id").toString());
                    tb_tjaba->setName(_tb_tjaba.value("name").toString());
                    tb_tjaba->setAbreviacion(_tb_tjaba.value("abreviacion").toString());
                tjaba->setTipoJaba(tb_tjaba);
                salidas_tipojaba.append(tjaba);
                item->setTipoJabas(salidas_tipojaba);
            }
            itemssalida.append(item);
        }
        b->setItemsSalida(itemssalida);
        b->setVenta(obj.value("venta").toBool());
        b->setClose(obj.value("close").toBool());

        m_boletas.append(b);
    }
    endInsertRows();
    emit replyFinished(arrResponse);
    //qDebug()<<"Largo del arrray"<<arrResponse.count();
}

void BoletaModel::appendBoleta(QQmlListProperty<Boleta> *lst, Boleta *b)
{
    reinterpret_cast<BoletaModel *>(lst->object)->appendBoleta(b);
}

int BoletaModel::boletasCount(QQmlListProperty<Boleta> *lst)
{
    return reinterpret_cast<BoletaModel *>(lst->object)->boletasCount();
}

Boleta *BoletaModel::boletaAt(QQmlListProperty<Boleta> *lst, int index)
{
    return reinterpret_cast<BoletaModel *>(lst->object)->boletaAt(index);
}

void BoletaModel::clearBoletas(QQmlListProperty<Boleta> *lst)
{
    reinterpret_cast<BoletaModel *>(lst->object)->clearBoletas();
}
