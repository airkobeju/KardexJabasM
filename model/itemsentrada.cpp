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

ItemsEntrada::ItemsEntrada(const QString &_id, unsigned int cantidad, float peso, const QVector<TipoJaba *> &tipoJaba)
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
    m__id = _id;
}

unsigned int ItemsEntrada::cantidad() const
{
    return m_cantidad;
}

void ItemsEntrada::setCantidad(unsigned int cantidad)
{
    m_cantidad = cantidad;
}

float ItemsEntrada::peso() const
{
    return m_peso;
}

void ItemsEntrada::setPeso(float peso)
{
    m_peso = peso;
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
