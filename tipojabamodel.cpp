#include "tipojabamodel.h"
#include <QDebug>

TipoJabaModel::TipoJabaModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int TipoJabaModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_tipoJabas.count();
}

QVariant TipoJabaModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role){
        case IdRole:
        return QVariant(m_tipoJabas.at(index.row())->_id());
    case CantidadRole:
        return QVariant(m_tipoJabas.at(index.row())->cantidad());
    case TipoJabaRole:
        return QVariant::fromValue( m_tipoJabas.at(index.row())->tipoJaba() );
    }

    return QVariant();
}

bool TipoJabaModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {

        switch (role){
            case IdRole:
             m_tipoJabas.at(index.row())->set_id( value.toString() );
            break;
        case CantidadRole:
            m_tipoJabas.at(index.row())->setCantidad( value.toInt() );
            break;
        case TipoJabaRole:
            m_tipoJabas.at(index.row())->setTipoJaba( value.value<TipoJabaMatriz *>() );
            break;
        }

        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags TipoJabaModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

void TipoJabaModel::appendTipoJaba(TipoJaba * const &tjaba)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_tipoJabas.append(tjaba);
    endInsertRows();
}

TipoJaba *TipoJabaModel::get(int index) const
{
    return m_tipoJabas.at(index);
}

void TipoJabaModel::remove(int index)
{
    beginResetModel();
    m_tipoJabas.removeAt(index);
    endResetModel();
}

void TipoJabaModel::clear()
{
    beginResetModel();
    m_tipoJabas.clear();
    endResetModel();
}

void TipoJabaModel::append(QString _id, int cantidad, QVariantMap tj )
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    QString id = tj.value("id", "").value<QString>();
    QString name = tj.value("name", "").value<QString>();
    QString abreviacion = tj.value("abreviacion", "").value<QString>();
    TipoJabaMatriz *j = new TipoJabaMatriz(id, name, abreviacion);
    m_tipoJabas.append(new TipoJaba(_id, cantidad, j));
    endInsertRows();
}

void TipoJabaModel::printObjects(QVariantMap obj)
{
    qDebug()<< "Objecto JS :\n"<<obj;
}

QVariantList TipoJabaModel::jsData()
{
    QVariantList lista;
    for(int i=0; i < m_tipoJabas.count(); i++){
        QVariantMap item;
        item.insert("id", m_tipoJabas.at(i)->_id());
        item.insert("cantidad", m_tipoJabas.at(i)->cantidad());
        QVariantMap sub_item;
        sub_item.insert("id", m_tipoJabas.at(i)->tipoJaba()->_id());
        sub_item.insert("name", m_tipoJabas.at(i)->tipoJaba()->name());
        sub_item.insert("abreviacion", m_tipoJabas.at(i)->tipoJaba()->abreviacion());
        item.insert("tipoJaba", sub_item);

        lista.append(item);
    }
    return lista;
}

QHash<int, QByteArray> TipoJabaModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[IdRole] = "_id";
    names[CantidadRole] = "cantidad";
    names[TipoJabaRole] = "tipoJaba";
    return names;
}
