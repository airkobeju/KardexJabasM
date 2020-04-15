#ifndef BOLETAMODEL_H
#define BOLETAMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QQmlListProperty>
#include "model/boleta.h"
#include "http/getcontroller.h"

class BoletaModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<Boleta> boletas READ boletas)
public:
    enum BoletaRoles
    {
        IdRole = Qt::UserRole + 1,
        SerieRole = Qt::UserRole + 2,
        NumeracionRole = Qt::UserRole + 3,
        FechaRole = Qt::UserRole + 4,
        ProveedorRole = Qt::UserRole + 5,
        NotaRole = Qt::UserRole + 6,
        ItemsEntradaRole = Qt::UserRole + 7,
        ItemsSalidaRole = Qt::UserRole + 8,
        VentaRole = Qt::UserRole + 9,
        CloseRole = Qt::UserRole + 10
    };
    explicit BoletaModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void loadData();

    QQmlListProperty<Boleta> boletas();
    void appendBoleta(Boleta *const & b);
    int boletasCount() const;
    Boleta *boletaAt(int index) const;
    void clearBoletas();

signals:
    void replyFinished(QVariantList arrResponse);

public slots:
    void replyFinishedJsArr(QVariantList arrResponse);

private:
    static void appendBoleta(QQmlListProperty<Boleta> *lst, Boleta* b);
    static int boletasCount(QQmlListProperty<Boleta> *lst);
    static Boleta *boletaAt(QQmlListProperty<Boleta> *lst, int index);
    static void clearBoletas(QQmlListProperty<Boleta> *lst);

    QList<Boleta *> m_boletas;
    GetController *m_boletaController;


};

#endif // BOLETAMODEL_H
