#ifndef PROVEEDOR_H
#define PROVEEDOR_H

#include <QObject>
#include <QVariant>
#include "tipojabamatriz.h"

class Proveedor : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged)
    Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged)
    Q_PROPERTY(TipoJabaMatriz * tipoJaba READ tipoJaba WRITE setTipoJaba NOTIFY tipoJabaChanged)
public:
    explicit Proveedor(QObject *parent = nullptr);
    Proveedor(const QString &_id, const QString &name, const QString &firstName,
              const QString &lastName, TipoJabaMatriz *tipoJaba);

    QString _id() const;
    void set_id(const QString &_id);

    QString name() const;
    void setName(const QString &name);

    QString firstName() const;
    void setFirstName(const QString &firstName);

    QString lastName() const;
    void setLastName(const QString &lastName);

    TipoJabaMatriz *tipoJaba() const;
    void setTipoJaba(TipoJabaMatriz *tipoJaba);
    void setTipoJaba(QVariantMap tj);

    Proveedor &operator=(const Proveedor &p);
    bool operator==(const Proveedor &p);

    QVariantMap toJS() const;

    Q_INVOKABLE void reset();

signals:
    void _idChanged();
    void nameChanged();
    void firstNameChanged();
    void lastNameChanged();
    void tipoJabaChanged();

private:
    QString m__id;
    QString m_name;
    QString m_firstName;
    QString m_lastName;
    TipoJabaMatriz *m_tipoJaba;

};

#endif // PROVEEDOR_H
