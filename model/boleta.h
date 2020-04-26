#ifndef BOLETA_H
#define BOLETA_H

#include <QObject>
#include <QQmlListProperty>
#include <QVariant>

#include "serieboleta.h"
#include "proveedor.h"
#include "itemsdetailboleta.h"
#include "itemkardex.h"

class Boleta : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(SerieBoleta * serie READ serie WRITE setSerie NOTIFY serieChanged)
    Q_PROPERTY(unsigned int numeracion READ numeracion WRITE setNumeracion NOTIFY numeracionChanged)
    Q_PROPERTY(QString fecha READ fecha WRITE setFecha NOTIFY fechaChanged)
    Q_PROPERTY(Proveedor * proveedor READ proveedor WRITE setProveedor NOTIFY proveedorChanged)
    Q_PROPERTY(QString nota READ nota WRITE setNota NOTIFY notaChanged)
    Q_PROPERTY(QQmlListProperty<ItemsDetailBoleta> itemsEntrada READ itemsEntrada)
    Q_PROPERTY(QQmlListProperty<ItemsDetailBoleta> itemsSalida READ itemsSalida NOTIFY itemsSalidaChanged)
    Q_PROPERTY(bool venta READ venta WRITE setVenta NOTIFY isVentaChanged)
    Q_PROPERTY(bool close READ close WRITE setClose NOTIFY isCloseChanged)
public:
    explicit Boleta(QObject *parent = nullptr);
    Boleta(
            const QString &_id,
            SerieBoleta *serie,
            long int numeracion,
            const QString &fecha,
            Proveedor *proveedor,
           const QString &nota,
            bool venta,
            bool close);

    QString _id() const;
    void set_id(const QString &_id);

    SerieBoleta *serie() const;
    void setSerie(SerieBoleta *serie);

    unsigned int numeracion() const;
    void setNumeracion(unsigned int numeracion);

    QString fecha() const;
    void setFecha(const QString &fecha);

    Proveedor *proveedor() const;
    void setProveedor(Proveedor *proveedor);

    QString nota() const;
    void setNota(const QString &nota);

    bool venta() const;
    void setVenta(bool venta);

    bool close() const;
    void setClose(bool close);

    QQmlListProperty<ItemsDetailBoleta> itemsEntrada();
    void appendItemsEntradas(ItemsDetailBoleta *const & tj);
    Q_INVOKABLE void appendItemsEntradas(QVariantMap const &tj);
    void appendItemsEntradas(const QString &_id, unsigned int cantidad,  float peso, const QVariantList &tipoJabas);
    int itemsEntradasCount() const;
    ItemsDetailBoleta *itemsEntradasAt(int index) const;
    void clearItemsEntradas();

    QList<ItemsDetailBoleta *> itemsEntradasList() const;
    void setItemsEntradas(const QList<ItemsDetailBoleta *> &entradas);

    QQmlListProperty<ItemsDetailBoleta> itemsSalida();
    void appendItemsSalida(ItemsDetailBoleta *const & s);
    int itemsSalidaCount() const;
    Q_INVOKABLE ItemsDetailBoleta*itemsSalidaAt(int index) const;
    Q_INVOKABLE void clearItemsSalida();

    QList<ItemsDetailBoleta *> itemsSalidaList() const;
    void setItemsSalida(const QList<ItemsDetailBoleta *> &salidas);

    Q_INVOKABLE QVariantMap toJS() const;

    Q_INVOKABLE int countCantidadEntrada() const;
    Q_INVOKABLE int countCantidadSalida() const;

    Q_INVOKABLE ItemKardex *toItemKardex() const;

    Q_INVOKABLE void resetAsCompra();

signals:
    void _idChanged();
    void serieChanged();
    void numeracionChanged();
    void fechaChanged();
    void proveedorChanged();
    void notaChanged();
    void isVentaChanged();
    void isCloseChanged();
    void itemsSalidaChanged();

private:
    static void appendItemsEntradas(QQmlListProperty<ItemsDetailBoleta> *lst, ItemsDetailBoleta* tj);
    static int itemsEntradasCount(QQmlListProperty<ItemsDetailBoleta> *lst);
    static ItemsDetailBoleta *itemsEntradasAt(QQmlListProperty<ItemsDetailBoleta> *lst, int index);
    static void clearItemsEntradas(QQmlListProperty<ItemsDetailBoleta> *lst);

    static void appendItemsSalida(QQmlListProperty<ItemsDetailBoleta> *sl, ItemsDetailBoleta* s);
    static int itemsSalidaCount(QQmlListProperty<ItemsDetailBoleta> *sl);
    static ItemsDetailBoleta *itemsSalidaAt(QQmlListProperty<ItemsDetailBoleta> *sl, int index);
    static void clearItemsSalida(QQmlListProperty<ItemsDetailBoleta> *sl);

    QString m__id;
    SerieBoleta *m_serie;
    unsigned int m_numeracion;
    QString m_fecha;
    Proveedor *m_proveedor;
    QString m_nota;
    QList <ItemsDetailBoleta *> m_itemsEntrada;
    QList<ItemsDetailBoleta *> m_itemsSalida;
    bool m_venta = false;
    bool m_close = false;

};

#endif // BOLETA_H
