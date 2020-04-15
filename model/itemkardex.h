#ifndef ITEMKARDEX_H
#define ITEMKARDEX_H

#include <QtGlobal>
#include <QObject>
#include <QQmlListProperty>

#include "proveedor.h"
#include "serieboleta.h"
#include "itemgrupokardex.h"
#include "tipojabamatriz.h"
#include <QMetaType>


struct ItemGrupo{
    QString key;
    int cantidad;

    ItemGrupo &operator=(const ItemGrupo &item){
        this->key = item.key;
        this->cantidad = item.cantidad;
        return *this;
    }
    bool operator==(const ItemGrupo &item){
        return (this->key == item.key && this->cantidad == item.cantidad);
    }
};
Q_DECLARE_METATYPE(ItemGrupo)

class ItemKardex : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString fecha READ fecha WRITE setFecha NOTIFY fechaChanged)
    Q_PROPERTY(Proveedor * proveedor READ proveedor WRITE setProveedor NOTIFY proveedorChanged)
    Q_PROPERTY(SerieBoleta * serie READ serie WRITE setSerie NOTIFY serieChanged)
    Q_PROPERTY(unsigned int numeracion READ numeracion WRITE setNumeracion NOTIFY numeracionChanged)
    Q_PROPERTY(QQmlListProperty<TipoJabaMatriz> grupos READ grupos)

public:
    explicit ItemKardex(QObject *parent = nullptr);

    QString fecha() const;
    void setFecha(const QString &fecha);

    SerieBoleta *serie() const;
    void setSerie(SerieBoleta *serie);

    unsigned int numeracion() const;
    void setNumeracion(unsigned int numeracion);

    Proveedor *proveedor() const;
    void setProveedor(Proveedor *proveedor);

    void appendGrupos(TipoJabaMatriz *const & itm);
    int gruposCount() const;
    TipoJabaMatriz *gruposAt(int index) const;
    void clearGrupos();
    QQmlListProperty<TipoJabaMatriz> grupos();

    void setGrupos(const QList<TipoJabaMatriz *> &grupos);
    QList<TipoJabaMatriz *> getGrupos() const;


    QList<ItemGrupo> getEntradas() const;
    void setEntradas(const QList<ItemGrupo> &entradas);
    void appendEntradas(const ItemGrupo &entrada);


    QList<ItemGrupo> getSalidas() const;
    void setSalidas(const QList<ItemGrupo> &salidas);
    void appendSalidas(const ItemGrupo &salida);

signals:
    void fechaChanged();
    void serieChanged();
    void numeracionChanged();
    void proveedorChanged();

private:
    static void appendGrupos(QQmlListProperty<TipoJabaMatriz> *lst, TipoJabaMatriz* itm);
    static int gruposCount(QQmlListProperty<TipoJabaMatriz> *lst);
    static TipoJabaMatriz *gruposAt(QQmlListProperty<TipoJabaMatriz> *lst, int index);
    static void clearGrupos(QQmlListProperty<TipoJabaMatriz> *lst);

    QString m_fecha;
    Proveedor *m_proveedor;
    SerieBoleta *m_serie;
    unsigned int m_numeracion;
    QList<TipoJabaMatriz *> m_grupos;

    QList<ItemGrupo> m_entradas;
    QList<ItemGrupo> m_salidas;
};

#endif // ITEMKARDEX_H
