#ifndef TIPOJABAMODEL_H
#define TIPOJABAMODEL_H

#include <QAbstractListModel>
#include <QVariant>
#include <QList>
#include <QMetaType>
#include "model/tipojaba.h"
#include "model/tipojabamatriz.h"

class TipoJabaModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum TipoJabaRoles {
        IdRole = Qt::UserRole + 1,
        CantidadRole= Qt::UserRole + 2,
        TipoJabaRole= Qt::UserRole + 3
    };
    explicit TipoJabaModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    void appendTipoJaba(TipoJaba *const &tjaba);

public slots:
    void clear();
    void append(QString _id, int cantidad, QVariantMap tj );
    void printObjects(QVariantMap obj);

    TipoJaba *get(int index)const;
    void remove(int index);
    int cantidadTotal();

signals:

private:
    QList<TipoJaba *> m_tipoJabas;


    // QAbstractItemModel interface
public:
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // TIPOJABAMODEL_H
