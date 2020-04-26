#include "getcontroller.h"
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QTextStream>
#include <QDesktopServices>
#include <QUrl>

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
    QList<QByteArray> hds = reply->rawHeaderList();
    QVariant h;
    if(reply->hasRawHeader("Content-Disposition")){
        h = reply->rawHeader("Content-Disposition");
        QString _h = h.value<QString>();
        QStringList lst_h = _h.split(';');
        if(lst_h.at(0) == "attachment"){
            QString file_name = lst_h.at(1).split('=').at(1);

            QFile file(file_name);
                if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
                    return;

                file.write( reply->readAll() );

                QTextStream out(&file);
                //out.setCodec("ASCII");
                //out << reply->readAll();
                file.close();

                QDesktopServices::openUrl(QUrl(file_name));
        }

    }
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


