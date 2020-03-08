#include "getcontroller.h"
#include <QDebug>

GetController::GetController(QObject *parent) : QObject(parent)
{

}

void GetController::send(QUrl ruta)
{
    qDebug("Iniciando función send()");
    QNetworkAccessManager *networkManager = new QNetworkAccessManager(this);
    QNetworkRequest request;
    request.setUrl(ruta);
    //connect(networkManager, &QNetworkAccessManager::finished, this, &GetController::replayFinished);
    connect(networkManager,SIGNAL(finished(QNetworkReply *)), this, SLOT(finished(QNetworkReply *)));
    QNetworkReply* currentReply = networkManager->get(request);
}

void GetController::send()
{
    //TODO: controlar excepción si url no está seteada.
    send(this->gc_url);
}

void GetController::finished(QNetworkReply *reply)
{
    qDebug("Ejecutando slot::finished");
    QString str_json = QString::fromUtf8(reply->readAll());
    //QJsonDocument _json = QJsonDocument::fromBinaryData(reply->readAll());
    emit replyFinished( str_json );
    //qDebug( reply->readAll().data() );
}

QUrl GetController::url() const
{
    return gc_url;
}

void GetController::setUrl(const QUrl &value)
{
    if(value == this->gc_url)
        return;
    gc_url = value;
    emit urlChanged();
}


