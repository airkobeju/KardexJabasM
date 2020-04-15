#include "itemkardex.h"

ItemKardex::ItemKardex(QObject *parent) : QObject(parent)
{

}

QString ItemKardex::fecha() const
{
    return m_fecha;
}

void ItemKardex::setFecha(const QString &fecha)
{
    if(m_fecha == fecha)
        return;
    m_fecha = fecha;
    emit fechaChanged();
}

SerieBoleta *ItemKardex::serie() const
{
    return m_serie;
}

void ItemKardex::setSerie(SerieBoleta *serie)
{
    if(m_serie == serie)
        return;
    m_serie = serie;
    emit serieChanged();
}

unsigned int ItemKardex::numeracion() const
{
    return m_numeracion;
}

void ItemKardex::setNumeracion(unsigned int numeracion)
{
    if(m_numeracion == numeracion)
        return;
    m_numeracion = numeracion;
    emit numeracionChanged();
}

Proveedor *ItemKardex::proveedor() const
{
    return m_proveedor;
}

void ItemKardex::setProveedor(Proveedor *proveedor)
{
    if(m_proveedor == proveedor)
        return;
    m_proveedor = proveedor;
    emit proveedorChanged();
}

void ItemKardex::appendGrupos(TipoJabaMatriz * const &itm)
{
    m_grupos.append(itm);
}

int ItemKardex::gruposCount() const
{
    return m_grupos.count();
}

TipoJabaMatriz *ItemKardex::gruposAt(int index) const
{
    return m_grupos.at(index);
}

void ItemKardex::clearGrupos()
{
    m_grupos.clear();
}

QQmlListProperty<TipoJabaMatriz> ItemKardex::grupos()
{
    return {this, this,
        &ItemKardex::appendGrupos,
        &ItemKardex::gruposCount,
        &ItemKardex::gruposAt,
                &ItemKardex::clearGrupos};
}

void ItemKardex::setGrupos(const QList<TipoJabaMatriz *> &grupos)
{
    m_grupos = grupos;
}

QList<TipoJabaMatriz *> ItemKardex::getGrupos() const
{
    return m_grupos;
}

void ItemKardex::appendGrupos(QQmlListProperty<TipoJabaMatriz> *lst, TipoJabaMatriz *itm)
{
    reinterpret_cast<ItemKardex *>(lst->object)->appendGrupos(itm);
}

int ItemKardex::gruposCount(QQmlListProperty<TipoJabaMatriz> *lst)
{
    return reinterpret_cast<ItemKardex *>(lst->object)->gruposCount();
}

TipoJabaMatriz *ItemKardex::gruposAt(QQmlListProperty<TipoJabaMatriz> *lst, int index)
{
    return reinterpret_cast<ItemKardex *>(lst->object)->gruposAt(index);
}

void ItemKardex::clearGrupos(QQmlListProperty<TipoJabaMatriz> *lst)
{
    reinterpret_cast<ItemKardex *>(lst->object)->clearGrupos();
}

QList<ItemGrupo> ItemKardex::getSalidas() const
{
    return m_salidas;
}


void ItemKardex::setSalidas(const QList<ItemGrupo> &salidas)
{
    m_salidas = salidas;
}

void ItemKardex::appendSalidas(const ItemGrupo &salida){
    m_salidas.append(salida);
}

QList<ItemGrupo> ItemKardex::getEntradas() const
{
    return m_entradas;
}



void ItemKardex::setEntradas(const QList<ItemGrupo> &entradas)
{
    m_entradas = entradas;
}

void ItemKardex::appendEntradas(const ItemGrupo &entrada){
    m_entradas.append(entrada);
}



