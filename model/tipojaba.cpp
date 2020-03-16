#include "tipojaba.h"

TipoJaba::TipoJaba(QObject *parent) : QObject(parent), m__id(""),m_cantidad(0)
{

}

TipoJaba::TipoJaba(const QString &_id, unsigned int cantidad, TipoJabaMatriz *tjaba)
{
    m__id = _id;
    m_cantidad = cantidad;
    m_tipoJaba = tjaba;
}

QString TipoJaba::_id() const
{
    return m__id;
}

void TipoJaba::set_id(const QString &_id)
{
    if(_id == m__id)
        return;
    m__id = _id;
    emit _idChanged();
}

unsigned int TipoJaba::cantidad() const
{
    return m_cantidad;
}

void TipoJaba::setCantidad(unsigned int cantidad)
{
    if(cantidad == m_cantidad)
        return;
    m_cantidad = cantidad;
    emit cantidadChanged();
}

TipoJabaMatriz *TipoJaba::tipoJaba() const
{
    return m_tipoJaba;
}

void TipoJaba::setTipoJaba(TipoJabaMatriz *tipoJaba)
{
    if(tipoJaba == m_tipoJaba)
        return;
    m_tipoJaba = tipoJaba;
    emit tipoJabaChanged();
}
