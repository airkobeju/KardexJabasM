#include "itemsentrada.h"

ItemsEntrada::ItemsEntrada(QObject *parent) : QObject(parent)
{

}

ItemsEntrada::ItemsEntrada(const QString &_id, unsigned int cantidad, float peso)
{
    m__id = _id;
    m_cantidad = cantidad;
    m_peso = peso;
}

ItemsEntrada::ItemsEntrada(const QString &_id, unsigned int cantidad, float peso, const QList<TipoJaba *> &tipoJaba)
{
    m__id = _id;
    m_cantidad = cantidad;
    m_peso = peso;
    m_tipoJabas = tipoJaba;
}

QString ItemsEntrada::_id() const
{
    return m__id;
}

void ItemsEntrada::set_id(const QString &_id)
{
    if(_id == m__id)
        return;
    m__id = _id;
    emit _idChanged();
}

unsigned int ItemsEntrada::cantidad() const
{
    return m_cantidad;
}

void ItemsEntrada::setCantidad(unsigned int cantidad)
{
    if(cantidad == m_cantidad)
        return;
    m_cantidad = cantidad;
    emit cantidadChanged();
}

float ItemsEntrada::peso() const
{
    return m_peso;
}

void ItemsEntrada::setPeso(float peso)
{
    if(peso == m_peso)
        return;
    m_peso = peso;
    emit pesoChanged();
}

QQmlListProperty<TipoJaba> ItemsEntrada::tipoJabas()
{
    return {this, this,
        &ItemsEntrada::appendTipoJaba,
        &ItemsEntrada::tipoJabaCount,
        &ItemsEntrada::tipoJabaAt,
        &ItemsEntrada::clearTipoJabas};
}

void ItemsEntrada::appendTipoJaba(TipoJaba * const &tj)
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

int ItemsEntrada::tipoJabaCount() const
{
    return m_tipoJabas.count();
}

TipoJaba *ItemsEntrada::tipoJabaAt(int index) const
{
    return m_tipoJabas.at(index);
}

void ItemsEntrada::clearTipoJabas()
{
    m_tipoJabas.clear();
}

QList<TipoJaba *> ItemsEntrada::tipoJabasList()
{
    return m_tipoJabas;
}

void ItemsEntrada::appendTipoJaba(QQmlListProperty<TipoJaba> *lst, TipoJaba *tj)
{
    reinterpret_cast<ItemsEntrada *>(lst->object)->appendTipoJaba(tj);
}

int ItemsEntrada::tipoJabaCount(QQmlListProperty<TipoJaba> *lst)
{
    return reinterpret_cast<ItemsEntrada *>(lst->object)->tipoJabaCount();
}

TipoJaba *ItemsEntrada::tipoJabaAt(QQmlListProperty<TipoJaba> *lst, int index)
{
    return reinterpret_cast<ItemsEntrada *>(lst->object)->tipoJabaAt(index);
}

void ItemsEntrada::clearTipoJabas(QQmlListProperty<TipoJaba> *lst)
{
    reinterpret_cast<ItemsEntrada *>(lst->object)->clearTipoJabas();
}

void ItemsEntrada::setTipoJabas(const QList<TipoJaba *> &tipoJabas)
{
    m_tipoJabas = tipoJabas;
}
