#ifndef SERIEBOLETA_H
#define SERIEBOLETA_H

#include <QObject>
#include <QVariant>
#include "tipooperacion.h"

class SerieBoleta : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(QString value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(QString nota READ nota WRITE setNota NOTIFY notaChanged)
    Q_PROPERTY(TipoOperacion * operacion READ operacion WRITE setOperacion NOTIFY operacionChanged)
public:
    explicit SerieBoleta(QObject *parent = nullptr);
    SerieBoleta(const QString &_id, const QString &value, const QString &nota, TipoOperacion *operacion);
    SerieBoleta(const QString &value, const QString &nota, TipoOperacion *operacion);

    QString _id() const;
    void set_id(const QString &_id);

    QString value() const;
    void setValue(const QString &value);

    QString nota() const;
    void setNota(const QString &nota);

    TipoOperacion *operacion() const;
    void setOperacion(TipoOperacion *operacion);
    void setOperacion(const QVariant &);

    SerieBoleta &operator=(const SerieBoleta &sb);
    bool operator==(const SerieBoleta &sb);

    friend QDataStream & operator << (QDataStream &out, const SerieBoleta &obj){
        out << obj.m__id << obj.m_value<< obj.m_nota;
        return out;
    };
    friend QDataStream & operator >> (QDataStream &in, SerieBoleta &obj){
        in >> obj.m__id >> obj.m_value >> obj.m_nota;
        return in;
    }

    QVariantMap toJS() const;

    Q_INVOKABLE void reset();

signals:
    void _idChanged();
    void valueChanged();
    void notaChanged();
    void operacionChanged();

private:
    QString m__id;
    QString m_value;
    QString m_nota;
    TipoOperacion *m_operacion;
};

#endif // SERIEBOLETA_H
