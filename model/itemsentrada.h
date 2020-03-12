#ifndef ITEMSENTRADA_H
#define ITEMSENTRADA_H

#include <QObject>
#include <QVector>
#include <QQmlListProperty>

#include "tipojaba.h"

class ItemsEntrada : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id)
    Q_PROPERTY(unsigned int cantidad READ cantidad WRITE setCantidad)
    Q_PROPERTY(float peso READ peso WRITE setPeso)
    Q_PROPERTY(QQmlListProperty<TipoJaba> tipoJabas READ tipoJabas)
public:
    explicit ItemsEntrada(QObject *parent = nullptr);
    ItemsEntrada(const QString &_id, unsigned int cantidad, float peso);
    ItemsEntrada(const QString &_id, unsigned int cantidad, float peso, const QVector<TipoJaba *> &tipoJaba);

    QString _id() const;
    void set_id(const QString &_id);

    unsigned int cantidad() const;
    void setCantidad(unsigned int cantidad);

    float peso() const;
    void setPeso(float peso);

    QQmlListProperty<TipoJaba> tipoJabas();
    void appendTipoJaba(TipoJaba *const & tj);
    int tipoJabaCount() const;
    TipoJaba *tipoJabaAt(int index) const;
    void clearTipoJabas();

signals:

private:
    static void appendTipoJaba(QQmlListProperty<TipoJaba> *lst, TipoJaba* tj);
    static int tipoJabaCount(QQmlListProperty<TipoJaba> *lst);
    static TipoJaba *tipoJabaAt(QQmlListProperty<TipoJaba> *lst, int index);
    static void clearTipoJabas(QQmlListProperty<TipoJaba> *lst);

    QString m__id;
    unsigned int m_cantidad;
    float m_peso;
    QVector<TipoJaba *> m_tipoJabas;
};

#endif // ITEMSENTRADA_H
