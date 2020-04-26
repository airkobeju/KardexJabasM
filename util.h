#ifndef UTIL_H
#define UTIL_H

#include <QObject>

class Util : public QObject
{
    Q_OBJECT
public:
    explicit Util(QObject *parent = nullptr);

    inline static QString serverHost = "";

signals:

};

#endif // UTIL_H
