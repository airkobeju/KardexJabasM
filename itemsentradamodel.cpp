#include "itemsentradamodel.h"

ItemsEntradaModel::ItemsEntradaModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int ItemsEntradaModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_items.count();
}

QVariant ItemsEntradaModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || m_items.isEmpty())
        return QVariant();

    switch (role){
        case IdRole:
        return QVariant(m_items.at(index.row())->_id());
    case CantidadRole:
        return QVariant(m_items.at(index.row())->cantidad());
    case PesoRole:
        return QVariant(m_items.at(index.row())->peso());
    case TipoJabaRole:
        return QVariant::fromValue( m_items.at(index.row())->tipoJabasList() );
    }

    return QVariant();
}

bool ItemsEntradaModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {

        switch (role){
            case IdRole:
             m_items.at(index.row())->set_id( value.toString() );
            break;
        case CantidadRole:
            m_items.at(index.row())->setCantidad( value.toInt() );
            break;
        case PesoRole:
            m_items.at(index.row())->setPeso( value.toFloat() );
            break;
        case TipoJabaRole:
            m_items.at(index.row())->clearTipoJabas();
            foreach (QVariant tj, value.toList()) {
                TipoJaba *j = tj.value<TipoJaba *>();
                m_items.at(index.row())->appendTipoJaba(j);
            }
            break;
        }

        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ItemsEntradaModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> ItemsEntradaModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[IdRole] = "_id";
    names[CantidadRole] = "cantidad";
    names[PesoRole] = "peso";
    names[TipoJabaRole] = "tipoJaba";
    return names;
}

void ItemsEntradaModel::appendItemsEntrada(ItemsEntrada *const &items)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items.append(items);
    endInsertRows();
}

void ItemsEntradaModel::appendAtTipoJaba(int index, TipoJaba *const &tjaba)
{
    m_items.at(index)->appendTipoJaba(tjaba);
}

