#include "tipooperacion.h"

TipoOperacion::TipoOperacion(QObject *parent) : QObject(parent)
{

}

TipoOperacion::TipoOperacion(const QString &_id, const QString &name, const QString &description)
{
    m__id = _id;
    m_name = name;
    m_description = description;
}

QString TipoOperacion::_id() const
{
    return m__id;
}

void TipoOperacion::set_id(const QString &_id)
{
    if(m__id == _id)
        return;
    m__id = _id;
    emit _idChanged();
}

QString TipoOperacion::name() const
{
    return m_name;
}

void TipoOperacion::setName(const QString &name)
{
    if(m_name == name)
        return;
    m_name = name;
    emit nameChanged();
}

QString TipoOperacion::description() const
{
    return m_description;
}

void TipoOperacion::setDescription(const QString &description)
{
    if(m_description == description)
        return;
    m_description = description;
    emit descriptionChanged();
}

TipoOperacion &TipoOperacion::operator=(const TipoOperacion &to)
{
    m__id = to._id();
    m_name = to.name();
    m_description = to.description();
    return *this;
}

bool TipoOperacion::operator==(const TipoOperacion &to)
{
    return (m__id == to._id() && m_name == to.name() && m_description == to.description());
}

QVariantMap TipoOperacion::toJS() const
{
    QMap<QString, QVariant> obj_operacion;
    obj_operacion.insert("id", this->_id());
    obj_operacion.insert("name", this->name());
    obj_operacion.insert("description", this->description());

    return QVariantMap(obj_operacion);
}
