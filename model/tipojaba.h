#ifndef TIPOJABA_H
#define TIPOJABA_H

#include <QObject>

#include "tipojabamatriz.h"

class TipoJaba : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id)
    Q_PROPERTY(int cantidad READ cantidad WRITE setCantidad)
    Q_PROPERTY(TipoJabaMatriz* tipoJaba READ tipoJaba WRITE setTipoJaba)
public:
    explicit TipoJaba(QObject *parent = nullptr);
    TipoJaba(const QString &_id, int cantidad, TipoJabaMatriz *tjaba);

    QString _id() const;
    void set_id(const QString &_id);

    int cantidad() const;
    void setCantidad(int cantidad);

    TipoJabaMatriz *tipoJaba() const;
    void setTipoJaba(TipoJabaMatriz *tipoJaba);

signals:

private:
    QString m__id;
    int m_cantidad;
    TipoJabaMatriz *m_tipoJaba;

};

#endif // TIPOJABA_H
