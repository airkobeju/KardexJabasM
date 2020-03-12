#include "tipojabamatriz.h"

TipoJabaMatriz::TipoJabaMatriz(QObject *parent) : QObject(parent)
{

}

TipoJabaMatriz::TipoJabaMatriz(const QString &_id, const QString &name, const QString &abreviacion)
{
    m__id = _id;
    m_name = name;
    m_abreviacion = abreviacion;
}

QString TipoJabaMatriz::_id() const
{
    return m__id;
}

void TipoJabaMatriz::set_id(const QString &_id)
{
    m__id = _id;
}

QString TipoJabaMatriz::name() const
{
    return m_name;
}

void TipoJabaMatriz::setName(const QString &name)
{
    m_name = name;
}

QString TipoJabaMatriz::abreviacion() const
{
    return m_abreviacion;
}

void TipoJabaMatriz::setAbreviacion(const QString &abreviacion)
{
    m_abreviacion = abreviacion;
}

TipoJabaMatriz &TipoJabaMatriz::operator=(const TipoJabaMatriz &tjm)
{
    m__id = tjm.m__id;
    m_name = tjm.m_name;
    m_abreviacion = tjm.m_abreviacion;
    return *this;
}
