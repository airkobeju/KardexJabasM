#ifndef PROVEEDORMODEL_H
#define PROVEEDORMODEL_H

#include <QAbstractListModel>
#include <QQmlListProperty>
#include "model/proveedor.h"
#include "http/getcontroller.h"

class ProveedorModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Proveedor> proveedores READ proveedores)
public:
    enum Roles{
        IdRole=Qt::UserRole+1,
        NameRole=Qt::UserRole+2,
        FirstNameRole=Qt::UserRole+3,
        LastNameRole=Qt::UserRole+4,
        TipoJabaRole=Qt::UserRole+5
    };

    explicit ProveedorModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE int count(){
        return rowCount();
    }

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void load();
    Q_INVOKABLE Proveedor * const &at(int i) const;

    QQmlListProperty<Proveedor> proveedores();
    void appendProveedor(Proveedor *const & p);
    int proveedoresCount() const;
    Proveedor *proveedorAt(int index) const;
    void clearProveedores();

signals:
    void replyFinished(QVariantList arrResponse);

public slots:
    void replyFinishedJsArr(QVariantList arrResponse);

private:
    static void appendProveedor(QQmlListProperty<Proveedor> *lst, Proveedor* b);
    static int proveedoresCount(QQmlListProperty<Proveedor> *lst);
    static Proveedor *proveedorAt(QQmlListProperty<Proveedor> *lst, int index);
    static void clearProveedores(QQmlListProperty<Proveedor> *lst);

    QList<Proveedor *> m_proveedores;
    GetController *getController;

};

#endif // PROVEEDORMODEL_H
