#include "itemsdetailboleta.h"

ItemsDetailBoleta::ItemsDetailBoleta(QObject *parent) :
    QObject(parent), m__id(""), m_cantidad(0),m_peso(0)
{

}

ItemsDetailBoleta::ItemsDetailBoleta(const QString &_id, signed int cantidad, float peso)
{
    m__id = _id;
    m_cantidad = cantidad;
    m_peso = peso;
}

ItemsDetailBoleta::ItemsDetailBoleta(const QString &_id, signed int cantidad, float peso, const QList<TipoJaba *> &tipoJaba)
{
    m__id = _id;
    m_cantidad = cantidad;
    m_peso = peso;
    m_tipoJabas = tipoJaba;
}

QString ItemsDetailBoleta::_id() const
{
    return m__id;
}

void ItemsDetailBoleta::set_id(const QString &_id)
{
    if(_id == m__id)
        return;
    m__id = _id;
    emit _idChanged();
}

signed int ItemsDetailBoleta::cantidad() const
{
    return m_cantidad;
}

void ItemsDetailBoleta::setCantidad(signed int cantidad)
{
    if(cantidad == m_cantidad)
        return;
    m_cantidad = cantidad;
    emit cantidadChanged();
}

float ItemsDetailBoleta::peso() const
{
    return m_peso;
}

void ItemsDetailBoleta::setPeso(float peso)
{
    if(peso == m_peso)
        return;
    m_peso = peso;
    emit pesoChanged();
}

QQmlListProperty<TipoJaba> ItemsDetailBoleta::tipoJabas()
{
    return {this, this,
        &ItemsDetailBoleta::appendTipoJaba,
        &ItemsDetailBoleta::tipoJabaCount,
        &ItemsDetailBoleta::tipoJabaAt,
        &ItemsDetailBoleta::clearTipoJabas};
}

void ItemsDetailBoleta::appendTipoJaba(TipoJaba * const &tj)
{
    //FIXME: atrapar error de numero desigual de jabas en los tipos
//    unsigned int c_cantidad = tj->cantidad();
//    foreach (const TipoJaba *tj, m_tipoJabas) {
//        c_cantidad += tj->cantidad();
//    }
//    if(c_cantidad != m_cantidad)
//        throw QString(msg_error_1);
    m_tipoJabas.append(tj);
}

void ItemsDetailBoleta::appendTipoJaba(const QString &_id, signed int cantidad, const QVariantMap &tipoJaba)
{
    TipoJaba *tj = new TipoJaba();
    tj->set_id(_id);
    tj->setCantidad(cantidad);
    tj->setTipoJaba(tipoJaba);
    appendTipoJaba(tj);
}

void ItemsDetailBoleta::appendTipoJaba(const QVariantMap &tipoJaba)
{
    appendTipoJaba(
                tipoJaba.value("id").toString(),
                tipoJaba.value("cantidad").toInt(),
                tipoJaba.value("tipoJaba").value<QVariantMap>()
                );
}

int ItemsDetailBoleta::tipoJabaCount() const
{
    return m_tipoJabas.count();
}

TipoJaba *ItemsDetailBoleta::tipoJabaAt(int index) const
{
    return m_tipoJabas.at(index);
}

void ItemsDetailBoleta::clearTipoJabas()
{
    m_tipoJabas.clear();
}

QList<TipoJaba *> ItemsDetailBoleta::tipoJabasList() const
{
    return m_tipoJabas;
}

void ItemsDetailBoleta::appendTipoJaba(QQmlListProperty<TipoJaba> *lst, TipoJaba *tj)
{
    reinterpret_cast<ItemsDetailBoleta *>(lst->object)->appendTipoJaba(tj);
}

int ItemsDetailBoleta::tipoJabaCount(QQmlListProperty<TipoJaba> *lst)
{
    return reinterpret_cast<ItemsDetailBoleta *>(lst->object)->tipoJabaCount();
}

TipoJaba *ItemsDetailBoleta::tipoJabaAt(QQmlListProperty<TipoJaba> *lst, int index)
{
    return reinterpret_cast<ItemsDetailBoleta *>(lst->object)->tipoJabaAt(index);
}

void ItemsDetailBoleta::clearTipoJabas(QQmlListProperty<TipoJaba> *lst)
{
    reinterpret_cast<ItemsDetailBoleta *>(lst->object)->clearTipoJabas();
}

void ItemsDetailBoleta::setTipoJabas(const QList<TipoJaba *> &tipoJabas)
{
    m_tipoJabas = tipoJabas;
}

void ItemsDetailBoleta::removeTipoJabaAt(int i)
{
    m_tipoJabas.removeAt(i);
}

QVariantMap ItemsDetailBoleta::toJS() const
{
    QMap<QString, QVariant> obj;
    obj.insert("id", this->_id());
    obj.insert("cantidad", this->cantidad());
    obj.insert("peso", this->peso());

    QVariantList obj_tj;
    for(int i=0; i < this->tipoJabaCount(); i++){
        obj_tj.insert(i, this->tipoJabasList().at(i)->toJS());
    }
    obj.insert("tipoJaba", obj_tj);

    return QVariantMap(obj);
}
