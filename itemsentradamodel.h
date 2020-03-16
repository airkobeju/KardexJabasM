#ifndef ITEMSENTRADAMODEL_H
#define ITEMSENTRADAMODEL_H

#include <QAbstractListModel>

#include "model/itemsentrada.h"

class ItemsEntradaModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ItemsEntradaRoles {
        IdRole = Qt::UserRole + 1,
        CantidadRole= Qt::UserRole + 2,
        PesoRole= Qt::UserRole + 3,
        TipoJabaRole= Qt::UserRole + 4
    };
    explicit ItemsEntradaModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    void appendItemsEntrada(ItemsEntrada *const &items);
    void appendAtTipoJaba(int index, TipoJaba *const &tjaba);

private:
    QList<ItemsEntrada *> m_items;

};

#endif // ITEMSENTRADAMODEL_H
