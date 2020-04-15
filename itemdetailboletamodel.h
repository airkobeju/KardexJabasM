#ifndef ITEMDETAILBOLETAMODEL_H
#define ITEMDETAILBOLETAMODEL_H

#include <QAbstractListModel>
#include "model/itemsdetailboleta.h"

class ItemDetailBoletaModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ItemsEntradaRoles {
        IdRole = Qt::UserRole + 1,
        CantidadRole= Qt::UserRole + 2,
        PesoRole= Qt::UserRole + 3,
        TipoJabaRole= Qt::UserRole + 4
    };
    explicit ItemDetailBoletaModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    void appendItemsEntrada(ItemsDetailBoleta *const &items);
    void appendAtTipoJaba(int index, TipoJaba *const &tjaba);

private:
    QList<ItemsDetailBoleta *> m_items;

};

#endif // ITEMDETAILBOLETAMODEL_H
