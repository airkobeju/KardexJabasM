#include "itemgrupokardex.h"

ItemGrupoKardex::ItemGrupoKardex(QObject *parent) : QObject(parent)
{

}

long ItemGrupoKardex::cantidad() const
{
    return m_cantidad;
}

void ItemGrupoKardex::setCantidad(long cantidad)
{
    if(m_cantidad == cantidad)
        return;
    m_cantidad = cantidad;
    emit cantidadChanged();
}

TipoJabaMatriz *ItemGrupoKardex::tipoJaba() const
{
    return m_tipoJaba;
}

void ItemGrupoKardex::setTipoJaba(TipoJabaMatriz *tipoJaba)
{
    if(m_tipoJaba == tipoJaba)
        return;
    m_tipoJaba = tipoJaba;
    emit tipoJabaChanged();
}
