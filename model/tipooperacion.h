#ifndef TIPOOPERACION_H
#define TIPOOPERACION_H

#include <QObject>
#include <QVariant>

class TipoOperacion : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString _id READ _id WRITE set_id NOTIFY _idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString  description READ description WRITE setDescription NOTIFY descriptionChanged)
public:
    explicit TipoOperacion(QObject *parent = nullptr);
    TipoOperacion(const QString &_id, const QString &m_name, const QString &m_description);

    QString _id() const;
    void set_id(const QString &_id);

    QString name() const;
    void setName(const QString &name);

    QString description() const;
    void setDescription(const QString &description);

    TipoOperacion &operator=(const TipoOperacion &to);
    bool operator==(const TipoOperacion &to);

    QVariantMap toJS() const;

signals:
    void _idChanged();
    void nameChanged();
    void descriptionChanged();

private:
    QString m__id;
    QString m_name;
    QString m_description;

};

#endif // TIPOOPERACION_H
