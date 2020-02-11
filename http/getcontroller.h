#ifndef GETCONTROLLER_H
#define GETCONTROLLER_H

#include <QObject>

class GetController : public QObject
{
    Q_OBJECT
public:
    explicit GetController(QObject *parent = nullptr);

signals:

public slots:
};

#endif // GETCONTROLLER_H
