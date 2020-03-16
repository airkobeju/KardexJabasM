#include "tipojabamatriz.h"
#include <QDebug>

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
    if(_id == m__id)
        return;
    m__id = _id;
    emit _idChanged();
}

QString TipoJabaMatriz::name() const
{
    return m_name;
}

void TipoJabaMatriz::setName(const QString &name)
{
    if(name == m_name)
        return;
    m_name = name;
    emit nameChanged();
}

QString TipoJabaMatriz::abreviacion() const
{
    return m_abreviacion;
}

void TipoJabaMatriz::setAbreviacion(const QString &abreviacion)
{
    if(abreviacion == m_abreviacion)
        return;
    m_abreviacion = abreviacion;
    emit abreviacionChanged();
}

TipoJabaMatriz &TipoJabaMatriz::operator=(const TipoJabaMatriz &tjm)
{
    m__id = tjm.m__id;
    m_name = tjm.m_name;
    m_abreviacion = tjm.m_abreviacion;
    return *this;
}

bool TipoJabaMatriz::operator==(const TipoJabaMatriz &tjm)
{
    return (tjm._id() == m__id && tjm.name() == m_name && tjm.abreviacion() == m_abreviacion);
}

void TipoJabaMatriz::printerJSObj(QVariantMap obj)
{
    qDebug()<< obj;
}