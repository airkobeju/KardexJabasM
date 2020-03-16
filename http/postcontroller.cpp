#include "postcontroller.h"

PostController::PostController(QObject *parent): QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);
}

void PostController::send(QUrl ruta)
{
    connect(networkManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));

    QByteArray postDataSize = this->json_str.toUtf8();

    QNetworkRequest request( ruta );
    request.setRawHeader("Content-Type", "application/json");
    request.setRawHeader("Content-Length", postDataSize);

    QNetworkReply * reply = networkManager->post(request,this->json_str.toUtf8());
}

void PostController::send()
{
    this->send( gc_url );
}

QUrl PostController::url() const
{
    return this->gc_url;
}

void PostController::setUrl(const QUrl &value)
{
    if(value == this->gc_url)
        return;
    this->gc_url = value;
    emit urlChanged();
}

QString PostController::jsonString() const
{
    return json_str;
}

void PostController::setJsonString(const QString &value)
{
    if(value == this->json_str)
        return;
    json_str = value;
    emit jsonStringChanged();
}

void PostController::finished(QNetworkReply *reply)
{
    QString str_json = QString::fromUtf8(reply->readAll());
    emit replyFinished( str_json );
}
