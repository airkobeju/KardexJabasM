#include "getcontroller.h"
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

GetController::GetController(QObject *parent) : QObject(parent)
{
    m_networkManager = new QNetworkAccessManager(this);
    connect(m_networkManager,SIGNAL(finished(QNetworkReply *)), this, SLOT(finished(QNetworkReply *)));
}

void GetController::send(QUrl ruta)
{
    request.setUrl(ruta);

    currentReply = m_networkManager->get(request);
}

void GetController::send()
{
    //TODO: controlar excepción si url no está seteada.
    if( this->gc_url.url()==nullptr || this->gc_url.url()=="" )
        return;
    send(this->gc_url);
}

void GetController::finished(QNetworkReply *reply)
{
    //reply->readAll() pasa toda la información al objeto str_json y
    //queda vacio despues de la operación.
    QString str_json = QString::fromUtf8(reply->readAll());
    QJsonDocument _json(QJsonDocument::fromJson( str_json.toUtf8() ));
    if(_json.isArray()){
        QJsonArray json_arr = _json.array();
        emit replyFinishedJsArr(json_arr.toVariantList());
    }else if (_json.isObject()) {
        QJsonObject json_obj(_json.object());
        emit replyFinishedJsObj(json_obj.toVariantMap());
    }

    emit replyFinishedStr( str_json );

    //qDebug( reply->readAll().data() );
}

QNetworkAccessManager *GetController::networkManager() const
{
    return m_networkManager;
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


