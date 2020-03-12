#ifndef TIPOJABAMATRIZ_H
#define TIPOJABAMATRIZ_H

#include <QObject>

class TipoJabaMatriz : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id WRITE set_id)
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString abreviacion READ abreviacion WRITE setAbreviacion)
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

signals:

private:
    QString m__id;
    QString m_name;
    QString m_abreviacion;

};

#endif // TIPOJABAMATRIZ_H
