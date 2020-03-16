#ifndef TIPOJABA_H
#define TIPOJABA_H

#include <QObject>
#include <QMetaType>
#include "tipojabamatriz.h"

class TipoJaba : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(unsigned int cantidad READ cantidad WRITE setCantidad NOTIFY cantidadChanged)
    Q_PROPERTY(TipoJabaMatriz* tipoJaba READ tipoJaba WRITE setTipoJaba NOTIFY tipoJabaChanged)
public:
    explicit TipoJaba(QObject *parent = nullptr);
    TipoJaba(const QString &_id, unsigned int cantidad, TipoJabaMatriz *tjaba);

    QString _id() const;
    void set_id(const QString &_id);

    unsigned int cantidad() const;
    void setCantidad(unsigned int cantidad);

    TipoJabaMatriz *tipoJaba() const;
    void setTipoJaba(TipoJabaMatriz *tipoJaba);

signals:
    void _idChanged();
    void cantidadChanged();
    void tipoJabaChanged();

private:
    QString m__id;
    unsigned int m_cantidad;
    TipoJabaMatriz *m_tipoJaba;

};

#endif // TIPOJABA_H
