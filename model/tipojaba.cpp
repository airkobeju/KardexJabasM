#include "tipojaba.h"

TipoJaba::TipoJaba(QObject *parent) : QObject(parent)
{

}

TipoJaba::TipoJaba(const QString &_id, int cantidad, TipoJabaMatriz *tjaba)
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
    m__id = _id;
}

int TipoJaba::cantidad() const
{
    return m_cantidad;
}

void TipoJaba::setCantidad(int cantidad)
{
    m_cantidad = cantidad;
}

TipoJabaMatriz *TipoJaba::tipoJaba() const
{
    return m_tipoJaba;
}

void TipoJaba::setTipoJaba(TipoJabaMatriz *tipoJaba)
{
    m_tipoJaba = tipoJaba;
}
