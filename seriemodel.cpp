#include "seriemodel.h"

SerieModel::SerieModel(QObject *parent)
    : QAbstractListModel(parent)
{
    getController = new GetController(this);
    connect(getController,SIGNAL(replyFinishedJsArr(QVariantList )), this, SLOT(replyFinishedJsArr(QVariantList )));
    getController->setUrl(QUrl("http://localhost:8095/rest/serieboleta/by_operacion/COMPRA"));
}

int SerieModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_series.count();
}

QVariant SerieModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    QVariant result;

    switch (role) {
    case IdRole:
        result = QVariant(m_series.at(index.row())->_id());
        break;
    case ValueRole:
        result = QVariant(m_series.at(index.row())->value());
        break;
    case NotaRole:
        result = QVariant(m_series.at(index.row())->nota());
        break;
    case OperacionRole:
        result = QVariant::fromValue(m_series.at(index.row())->operacion());
        break;
    }

    return result;
}

bool SerieModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {

        switch (role) {
        case IdRole:
            m_series.at(index.row())->set_id(value.toString());
            break;
        case ValueRole:
            m_series.at(index.row())->setValue(value.toString());
            break;
        case NotaRole:
            m_series.at(index.row())->setNota(value.toString());
            break;
        case OperacionRole:
            m_series.at(index.row())->setOperacion(value);
            break;
        }

        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags SerieModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> SerieModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(IdRole, "id");
    roles.insert(ValueRole, "value");
    roles.insert(NotaRole, "nota");
    roles.insert(OperacionRole, "operacion");

    return roles;
}

void SerieModel::appendSerie(SerieBoleta * const &s)
{
    m_series.append(s);
}

int SerieModel::seriesCount() const
{
    return m_series.count();
}

SerieBoleta *SerieModel::serieAt(int index) const
{
    return m_series.at(index);
}

void SerieModel::clearSeries()
{
    m_series.clear();
}

QQmlListProperty<SerieBoleta> SerieModel::series()
{
    return {this, this,
                &SerieModel::appendSerie,
                &SerieModel::seriesCount,
                &SerieModel::serieAt,
                &SerieModel::clearSeries};
}

QList<SerieBoleta *> SerieModel::getSeries() const
{
    return m_series;
}

void SerieModel::setSeries(const QList<SerieBoleta *> &series)
{
    m_series = series;
}

void SerieModel::load()
{
    getController->send();
}

SerieBoleta *SerieModel::at(int index) const
{
    return serieAt(index);
}

void SerieModel::replyFinishedJsArr(QVariantList arrResponse)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    for(QVariant r: arrResponse){
        QVariantMap obj = r.value<QVariantMap>();

        SerieBoleta *serie = new SerieBoleta();

        serie->set_id(obj.value("id").toString());
        serie->setNota(obj.value("nota").toString());
        serie->setValue(obj.value("value").toString());
        QVariantMap _operacion = obj.value("operacion").value<QVariantMap>();
        TipoOperacion *operacion = new TipoOperacion();
        operacion->set_id(_operacion.value("id").toString());
        operacion->setName(_operacion.value("name").toString());
        operacion->setDescription(_operacion.value("description").toString());
        serie->setOperacion(operacion);
        m_series.append(serie);
    }
    endInsertRows();
    emit replyFinished(m_series.count());
    qDebug()<<"SerieModel cargado.";
}

void SerieModel::appendSerie(QQmlListProperty<SerieBoleta> *lst, SerieBoleta *b)
{
    reinterpret_cast<SerieModel *>(lst->object)->appendSerie(b);
}

int SerieModel::seriesCount(QQmlListProperty<SerieBoleta> *lst)
{
    return reinterpret_cast<SerieModel *>(lst->object)->seriesCount();
}

SerieBoleta *SerieModel::serieAt(QQmlListProperty<SerieBoleta> *lst, int index)
{
    return reinterpret_cast<SerieModel *>(lst->object)->serieAt(index);
}

void SerieModel::clearSeries(QQmlListProperty<SerieBoleta> *lst)
{
    reinterpret_cast<SerieModel *>(lst->object)->clearSeries();
}
