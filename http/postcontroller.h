#ifndef POSTCONTROLLER_H
#define POSTCONTROLLER_H

#include <QObject>
#include <QtNetwork>

class PostController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString jsonString READ jsonString WRITE setJsonString NOTIFY jsonStringChanged)
public:
    explicit PostController(QObject *parent = nullptr);

    Q_INVOKABLE void send(QUrl ruta);
    Q_INVOKABLE void send();

    QUrl url() const;
    void setUrl(const QUrl &value);

    QString jsonString() const;
    void setJsonString(const QString &value);

signals:
    void replyFinished(QString strJson);
    void urlChanged();
    void jsonStringChanged();

public slots:
    void finished(QNetworkReply* reply);

private:
    QUrl gc_url;
    QNetworkAccessManager *networkManager;
    QNetworkReply * reply;
    QNetworkRequest request;
    QString json_str;
};

#endif // POSTCONTROLLER_H
