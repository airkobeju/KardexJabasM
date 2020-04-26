#ifndef KADEXPROXYMODEL_H
#define KADEXPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

class KadexProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    KadexProxyModel();
};

#endif // KADEXPROXYMODEL_H
