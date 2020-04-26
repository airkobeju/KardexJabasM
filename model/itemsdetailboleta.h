#ifndef ITEMSDETAILBOLETA_H
#define ITEMSDETAILBOLETA_H

#include <QObject>
#include <QVariant>
#include <QVector>
#include <QQmlListProperty>

#include "tipojaba.h"

class ItemsDetailBoleta : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(int cantidad READ cantidad WRITE setCantidad NOTIFY cantidadChanged)
    Q_PROPERTY(float peso READ peso WRITE setPeso NOTIFY pesoChanged)
    Q_PROPERTY(QQmlListProperty<TipoJaba> tipoJabas READ tipoJabas)
public:
    explicit ItemsDetailBoleta(QObject *parent = nullptr);

    ItemsDetailBoleta(const QString &_id, signed int cantidad, float peso);
    ItemsDetailBoleta(const QString &_id, signed int cantidad, float peso, const QList<TipoJaba *> &tipoJaba);

    QString _id() const;
    void set_id(const QString &_id);

    signed int cantidad() const;
    void setCantidad(signed int cantidad);

    float peso() const;
    void setPeso(float peso);

    QQmlListProperty<TipoJaba> tipoJabas();
    void appendTipoJaba(TipoJaba *const & tj);
    Q_INVOKABLE void appendTipoJaba(const QString &_id, signed int cantidad, const QVariantMap &tipoJaba);
    Q_INVOKABLE void appendTipoJaba(const QVariantMap &tipoJaba);
    int tipoJabaCount() const;
    TipoJaba *tipoJabaAt(int index) const;
    Q_INVOKABLE void clearTipoJabas();

    QList<TipoJaba *> tipoJabasList() const;
    void setTipoJabas(const QList<TipoJaba *> &tipoJabas);
    Q_INVOKABLE void removeTipoJabaAt(int);

    QVariantMap toJS() const;

signals:
    void _idChanged();
    void cantidadChanged();
    void pesoChanged();

private:
    static void appendTipoJaba(QQmlListProperty<TipoJaba> *lst, TipoJaba* tj);
    static int tipoJabaCount(QQmlListProperty<TipoJaba> *lst);
    static TipoJaba *tipoJabaAt(QQmlListProperty<TipoJaba> *lst, int index);
    static void clearTipoJabas(QQmlListProperty<TipoJaba> *lst);

    QString m__id;
    signed int m_cantidad;
    float m_peso;
    QList<TipoJaba *> m_tipoJabas;
};

#endif // ITEMSDETAILBOLETA_H
