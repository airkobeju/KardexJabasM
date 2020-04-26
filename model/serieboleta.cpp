#include "serieboleta.h"
#include <QVariant>

SerieBoleta::SerieBoleta(QObject *parent) : QObject(parent)
{

}

SerieBoleta::SerieBoleta(const QString &_id, const QString &value, const QString &nota, TipoOperacion *operacion)
{
    m__id = _id;
    m_value = value;
    m_nota = nota;
    m_operacion = operacion;
}

SerieBoleta::SerieBoleta(const QString &value, const QString &nota, TipoOperacion *operacion)
{
    m__id = "";
    m_value = value;
    m_nota = nota;
    m_operacion = operacion;
}

QString SerieBoleta::_id() const
{
    return m__id;
}

void SerieBoleta::set_id(const QString &_id)
{
    if(m__id == _id)
        return;
    m__id = _id;
    emit _idChanged();
}

QString SerieBoleta::value() const
{
    return m_value;
}

void SerieBoleta::setValue(const QString &value)
{
    if(m_value == value)
        return;
    m_value = value;
    emit valueChanged();
}

QString SerieBoleta::nota() const
{
    return m_nota;
}

void SerieBoleta::setNota(const QString &nota)
{
    if(m_nota == nota)
        return;
    m_nota = nota;
    emit notaChanged();
}

TipoOperacion *SerieBoleta::operacion() const
{
    return m_operacion;
}

void SerieBoleta::setOperacion(TipoOperacion *value)
{
    if(m_operacion == value)
        return;
    m_operacion = value;
    emit operacionChanged();
}

void SerieBoleta::setOperacion(const QVariant &op)
{
    TipoOperacion *value = new TipoOperacion();
    QVariantMap obj = op.value<QVariantMap>();
    value->set_id(obj.value("id").toString());
    value->setName(obj.value("name").toString());
    value->setDescription(obj.value("description").toString());
    setOperacion(value);
}

SerieBoleta &SerieBoleta::operator=(const SerieBoleta &sb)
{
    m__id = sb._id();
    m_nota = sb.nota();
    m_value = sb.value();
    m_operacion = sb.operacion();
    return *this;
}

bool SerieBoleta::operator==(const SerieBoleta &sb)
{
    return (m__id == sb._id() && m_nota == sb.nota() && m_value == sb.value() && m_operacion == sb.operacion());
}

QVariantMap SerieBoleta::toJS() const
{
    QMap<QString, QVariant> obj;
    obj.insert("id", this->_id());
    obj.insert("value", this->value());
    obj.insert("nota", this->nota());
    obj.insert("operacion", this->operacion()->toJS());

    return QVariantMap(obj);
}

void SerieBoleta::reset()
{
    this->m__id = "";
    this->m_nota = "";
    this->m_value = "";
    this->m_operacion->reset();
}


