#include "proveedor.h"

Proveedor::Proveedor(QObject *parent) :
    QObject(parent), m__id(""), m_name(""), m_firstName(""),
    m_lastName(""), m_tipoJaba(new TipoJabaMatriz())
{

}

Proveedor::Proveedor(const QString &_id, const QString &name, const QString &firstName,
                     const QString &lastName, TipoJabaMatriz *tipoJaba)
{
    this->set_id(_id);
    this->setName(name);
    this->setFirstName(firstName);
    this->setLastName(lastName);
    this->setTipoJaba(tipoJaba);
}

QString Proveedor::_id() const
{
    return m__id;
}

void Proveedor::set_id(const QString &_id)
{
    if(m__id == _id)
        return;
    m__id = _id;
    emit _idChanged();
}

QString Proveedor::name() const
{
    return m_name;
}

void Proveedor::setName(const QString &name)
{
    if(m_name == name)
        return;
    m_name = name;
    emit nameChanged();
}

QString Proveedor::firstName() const
{
    return m_firstName;
}

void Proveedor::setFirstName(const QString &firstName)
{
    if(m_firstName == firstName)
        return;
    m_firstName = firstName;
    emit firstNameChanged();
}

QString Proveedor::lastName() const
{
    return m_lastName;
}

void Proveedor::setLastName(const QString &lastName)
{
    if(m_lastName == lastName)
        return;
    m_lastName = lastName;
    emit lastNameChanged();
}

TipoJabaMatriz *Proveedor::tipoJaba() const
{
    return m_tipoJaba;
}

void Proveedor::setTipoJaba(TipoJabaMatriz *tipoJaba)
{
    if(m_tipoJaba == tipoJaba)
        return;
    m_tipoJaba = tipoJaba;
    emit tipoJabaChanged();
}

void Proveedor::setTipoJaba(QVariantMap tj)
{
    TipoJabaMatriz *tjaba = new TipoJabaMatriz();
    tjaba->set_id(tj.value("id").toString());
    tjaba->setName(tj.value("name").toString());
    tjaba->setAbreviacion(tj.value("abreviacion").toString());
    setTipoJaba(tjaba);
}

Proveedor &Proveedor::operator=(const Proveedor &p)
{
    m__id = p._id();
    m_name = p.name();
    m_firstName = p.firstName();
    m_lastName = p.lastName();
    m_tipoJaba = p.tipoJaba();
    return *this;
}

bool Proveedor::operator==(const Proveedor &p)
{
    return (
                p._id() == m__id &&
                p.name() == m_name &&
                p.firstName() == m_firstName && p.lastName() == m_lastName &&
                p.tipoJaba() == m_tipoJaba
                );
}

QVariantMap Proveedor::toJS() const
{
    if(this->_id() == "")
        return QVariantMap();
    QMap<QString, QVariant> obj;
    obj.insert("id", this->_id());
    obj.insert("name", this->name());
    obj.insert("firstName", this->firstName());
    obj.insert("lastName", this->lastName());
    obj.insert("tipoJaba", this->tipoJaba()->toJS());

    return QVariantMap(obj);
}
