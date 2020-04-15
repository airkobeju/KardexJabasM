#include "proveedormodel.h"

ProveedorModel::ProveedorModel(QObject *parent)
    : QAbstractListModel(parent)
{
    getController = new GetController(this);
    connect(getController,SIGNAL(replyFinishedJsArr(QVariantList )), this, SLOT(replyFinishedJsArr(QVariantList )));
    getController->setUrl(QUrl("http://localhost:8095/rest/proveedor"));
}

int ProveedorModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_proveedores.count();
}

QVariant ProveedorModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    QVariant result;
    switch(role){
    case IdRole:
        result = QVariant(m_proveedores.at(index.row())->_id());
        break;
    case NameRole:
        result = QVariant(m_proveedores.at(index.row())->name());
        break;
    case FirstNameRole:
        result = QVariant(m_proveedores.at(index.row())->firstName());
        break;
    case LastNameRole:
        result = QVariant(m_proveedores.at(index.row())->lastName());
        break;
    case TipoJabaRole:
        result = QVariant::fromValue(m_proveedores.at(index.row())->tipoJaba());
        break;
    }

    return result;
}

bool ProveedorModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        switch(role){
        case IdRole:
            m_proveedores.at(index.row())->set_id( value.toString() );
            break;
        case NameRole:
            m_proveedores.at(index.row())->setName(value.toString());
            break;
        case FirstNameRole:
            m_proveedores.at(index.row())->setFirstName(value.toString());
            break;
        case LastNameRole:
            m_proveedores.at(index.row())->setLastName(value.toString());
            break;
        case TipoJabaRole:
            m_proveedores.at(index.row())->setTipoJaba(value.value<QVariantMap>());
            break;
        }
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ProveedorModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> ProveedorModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(IdRole, "id");
    roles.insert(NameRole, "name");
    roles.insert(FirstNameRole, "firstName");
    roles.insert(LastNameRole, "lastName");
    roles.insert(TipoJabaRole, "tipoJaba");

    return roles;
}

void ProveedorModel::load()
{
    getController->send();
}

Proveedor * const &ProveedorModel::at(int i) const
{
    return m_proveedores.at(i);
}

QQmlListProperty<Proveedor> ProveedorModel::proveedores()
{
    return {this, this,
        &ProveedorModel::appendProveedor,
        &ProveedorModel::proveedoresCount,
        &ProveedorModel::proveedorAt,
        &ProveedorModel::clearProveedores};
}

void ProveedorModel::appendProveedor(Proveedor * const &p)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_proveedores.append(p);
    endInsertRows();
}

int ProveedorModel::proveedoresCount() const
{
    return rowCount();
}

Proveedor *ProveedorModel::proveedorAt(int index) const
{
    return at(index);
}

void ProveedorModel::clearProveedores()
{
    m_proveedores.clear();
}

void ProveedorModel::replyFinishedJsArr(QVariantList arrResponse)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    for(QVariant prov: arrResponse){
        QVariantMap _prov = prov.value<QVariantMap>();
        Proveedor *proveedor = new Proveedor();
        proveedor->set_id(_prov.value("id").toString());
        proveedor->setName(_prov.value("name").toString());
        proveedor->setFirstName(_prov.value("firstName").toString());
        proveedor->setLastName(_prov.value("lastName").toString());

        QVariantMap _prov_tipojaba = _prov.value("tipoJaba").value<QVariantMap>();
        TipoJabaMatriz *prov_tipojaba = new TipoJabaMatriz();
        prov_tipojaba->set_id(_prov_tipojaba.value("id").toString());
        prov_tipojaba->setName(_prov_tipojaba.value("name").toString());
        prov_tipojaba->setAbreviacion(_prov_tipojaba.value("abreviacion").toString());
        proveedor->setTipoJaba(prov_tipojaba);
        m_proveedores.append(proveedor);
    }
    endInsertRows();
    emit replyFinished(arrResponse);
}

void ProveedorModel::appendProveedor(QQmlListProperty<Proveedor> *lst, Proveedor *b)
{
    reinterpret_cast<ProveedorModel *>(lst->object)->appendProveedor(b);
}

int ProveedorModel::proveedoresCount(QQmlListProperty<Proveedor> *lst)
{
    return reinterpret_cast<ProveedorModel *>(lst->object)->proveedoresCount();
}

Proveedor *ProveedorModel::proveedorAt(QQmlListProperty<Proveedor> *lst, int index)
{
    return reinterpret_cast<ProveedorModel *>(lst->object)->proveedorAt(index);
}

void ProveedorModel::clearProveedores(QQmlListProperty<Proveedor> *lst)
{
    reinterpret_cast<ProveedorModel *>(lst->object)->clearProveedores();
}
