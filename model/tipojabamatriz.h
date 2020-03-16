#ifndef TIPOJABAMATRIZ_H
#define TIPOJABAMATRIZ_H

#include <QObject>
#include <QVariant>
#include <QMetaType>

class TipoJabaMatriz : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString abreviacion READ abreviacion WRITE setAbreviacion NOTIFY abreviacionChanged)
public:
    explicit TipoJabaMatriz(QObject *parent = nullptr);
    TipoJabaMatriz(const QString &_id, const QString &name, const QString &abreviacion);

    QString _id() const;
    void set_id(const QString &_id);

    QString name() const;
    void setName(const QString &name);

    QString abreviacion() const;
    void setAbreviacion(const QString &abreviacion);

    TipoJabaMatriz &operator=(const TipoJabaMatriz &tjm);
    bool operator==(const TipoJabaMatriz &tjm);

public slots:
    void printerJSObj(QVariantMap obj);
signals:
    void _idChanged();
    void nameChanged();
    void abreviacionChanged();

private:
    QString m__id;
    QString m_name;
    QString m_abreviacion;

};


#endif // TIPOJABAMATRIZ_H
