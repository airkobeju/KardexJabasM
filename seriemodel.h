#ifndef SERIEMODEL_H
#define SERIEMODEL_H

#include <QAbstractListModel>
#include <QQmlListProperty>
#include "model/serieboleta.h"
#include "http/getcontroller.h"

class SerieModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<SerieBoleta> series READ series)
public:
    enum SerieRoles
    {
        IdRole = Qt::UserRole + 1,
        ValueRole = Qt::UserRole + 2,
        NotaRole = Qt::UserRole + 3,
        OperacionRole = Qt::UserRole + 4
    };

    explicit SerieModel(QObject *parent = nullptr);

    // Basic functionality:
    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    void appendSerie(SerieBoleta *const & );
    int seriesCount() const;
    SerieBoleta *serieAt(int index) const;
    void clearSeries();
    QQmlListProperty<SerieBoleta> series();

    QList<SerieBoleta *> getSeries() const;
    void setSeries(const QList<SerieBoleta *> &series);

    Q_INVOKABLE void load();
    Q_INVOKABLE SerieBoleta *at(int index) const;

signals:
    void replyFinished(int length);

public slots:
    void replyFinishedJsArr(QVariantList arrResponse);

private:
    static void appendSerie(QQmlListProperty<SerieBoleta> *lst, SerieBoleta* b);
    static int seriesCount(QQmlListProperty<SerieBoleta> *lst);
    static SerieBoleta *serieAt(QQmlListProperty<SerieBoleta> *lst, int index);
    static void clearSeries(QQmlListProperty<SerieBoleta> *lst);

    QList<SerieBoleta *> m_series;
    GetController *getController;
};

#endif // SERIEMODEL_H
