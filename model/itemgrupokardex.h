#ifndef ITEMGRUPOKARDEX_H
#define ITEMGRUPOKARDEX_H

#include <QObject>
#include "tipojabamatriz.h"

class ItemGrupoKardex : public QObject
{
    Q_OBJECT

    Q_PROPERTY(long int cantidad READ cantidad WRITE setCantidad NOTIFY cantidadChanged)
    Q_PROPERTY(TipoJabaMatriz * tipoJaba READ tipoJaba WRITE setTipoJaba NOTIFY tipoJabaChanged)
public:
    explicit ItemGrupoKardex(QObject *parent = nullptr);

    long cantidad() const;
    void setCantidad(long cantidad);

    TipoJabaMatriz *tipoJaba() const;
    void setTipoJaba(TipoJabaMatriz *tipoJaba);

signals:
    void cantidadChanged();
    void tipoJabaChanged();

private:
    long int m_cantidad;
    TipoJabaMatriz *m_tipoJaba;

};

#endif // ITEMGRUPOKARDEX_H
