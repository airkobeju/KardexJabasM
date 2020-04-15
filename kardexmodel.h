#ifndef KARDEXMODEL_H
#define KARDEXMODEL_H

#include <QAbstractTableModel>
#include <QQmlListProperty>
#include <QVariant>
#include "model/itemkardex.h"
#include "model/tipojabamatriz.h"
#include "http/getcontroller.h"

class KardexModel : public QAbstractTableModel
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<ItemKardex> items READ items)
public:
    explicit KardexModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void loadItems();

    void appendItems(ItemKardex *const & itm);
    int itemsCount() const;
    ItemKardex *itemsAt(int index) const;
    void clearItems();
    QQmlListProperty<ItemKardex> items();

    virtual QHash<int, QByteArray> roleNames() const override;
    virtual QVariant headerData(int section, Qt::Orientation orientation, int role) const override;

    QList<ItemKardex *> getItems() const;

signals:
    void loadKardexFinish();

public slots:
    void replyFinishedJsArr(QVariantList arrResponse);

private:
    static void appendItems(QQmlListProperty<ItemKardex> *lst, ItemKardex* itm);
    static int itemsCount(QQmlListProperty<ItemKardex> *lst);
    static ItemKardex *itemsAt(QQmlListProperty<ItemKardex> *lst, int index);
    static void clearItems(QQmlListProperty<ItemKardex> *lst);

    QList<ItemKardex *> m_items;
    GetController * m_controller;
    QList<TipoJabaMatriz *> m_grupos;
    bool load_boletas=false;
};

#endif // KARDEXMODEL_H
