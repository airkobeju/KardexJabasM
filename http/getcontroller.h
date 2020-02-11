#ifndef GETCONTROLLER_H
#define GETCONTROLLER_H

#include <QObject>
#include <QtNetwork>

class GetController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
public:
    explicit GetController(QObject *parent = nullptr);

    //Q_INVOKABLE void send(const QUrl &ruta);
    Q_INVOKABLE void send(QUrl ruta);
    Q_INVOKABLE void send();


    QUrl url() const;
    void setUrl(const QUrl &value);

signals:
    void replyFinished(QString strJson);
    void urlChanged();

public slots:
    void finished(QNetworkReply* reply);

private:
    QUrl gc_url;
};

#endif // GETCONTROLLER_H
