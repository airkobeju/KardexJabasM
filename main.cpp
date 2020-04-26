#include <QGuiApplication>
#include <QSettings>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFont>
#include <QFontDatabase>
#include <QVariant>
#include <QDebug>

#include "util.h"

#include "http/getcontroller.h"
#include "http/postcontroller.h"

#include "model/boleta.h"
#include "model/proveedor.h"
#include "model/serieboleta.h"
#include "model/tipooperacion.h"
#include "model/tipojabamatriz.h"
#include "model/tipojaba.h"
#include "model/itemsdetailboleta.h"
#include "model/itemgrupokardex.h"
#include "model/itemkardex.h"

#include "boletamodel.h"
#include "itemdetailboletamodel.h"
#include "tipojabamodel.h"
#include "kardexmodel.h"
#include "seriemodel.h"
#include "proveedormodel.h"

int main(int argc, char *argv[])
{
    QSettings settings(QDir::current().path() + "/settings.ini", QSettings::IniFormat);
//    settings.beginGroup("AppConfig");
//    settings.setValue("OrganizationName","JMTP");
//    settings.setValue("OrganizationDomain","jmtp.com");
//    settings.setValue("ApplicationName","Jabas Kardex");
//    settings.endGroup();

    Util::serverHost = settings.value("Server/Url").toString();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName(settings.value("AppConfig/OrganizationName").toString());
    app.setOrganizationDomain(settings.value("AppConfig/OrganizationDomain").toString());
    app.setApplicationName(settings.value("AppConfig/ApplicationName").toString());

    QFontDatabase::addApplicationFont("qrc:/fonts/Comfortaa-Regular.ttf");
    QFontDatabase::addApplicationFont("qrc:/fonts/Existence-Light.ttf");
    QFont fnt("Comfortaa", 12);

    app.setFont(fnt);

    qmlRegisterType<GetController>("com.jmtp.http", 1, 0, "GetController");
    qmlRegisterType<PostController>("com.jmtp.http", 1, 0, "PostController");
    //Model types
    qmlRegisterType<Boleta>("com.jmtp.model", 1, 0, "Boleta");
    qmlRegisterType<SerieBoleta>("com.jmtp.model", 1, 0, "SerieBoleta");
    qmlRegisterType<TipoOperacion>("com.jmtp.model", 1, 0, "TipoOperacion");
    qmlRegisterType<TipoJabaMatriz>("com.jmtp.model", 1, 0, "TipoJabaMatriz");
    qmlRegisterType<TipoJaba>("com.jmtp.model", 1, 0, "TipoJaba");
    qmlRegisterType<ItemsDetailBoleta>("com.jmtp.model", 1, 0, "ItemsDetailBoleta");
    qmlRegisterType<Proveedor>("com.jmtp.model", 1, 0, "Proveedor");
    //Objetos para el modelo de Kardex  ItemKardex->ItemGrupoKardex
    qmlRegisterType<ItemGrupoKardex>("com.jmtp.model", 1, 0, "ItemGrupoKardex");
    qmlRegisterType<ItemKardex>("com.jmtp.model", 1, 0, "ItemKardex");
    //Models continer
    qmlRegisterType<BoletaModel>("com.jmtp.model", 1, 0, "BoletaModel");
    qmlRegisterType<ItemDetailBoletaModel>("com.jmtp.model", 1, 0, "ItemDetailBoletaModel");
    qmlRegisterType<TipoJabaModel>("com.jmtp.model", 1, 0, "TipoJabaModel");
    qmlRegisterType<KardexModel>("com.jmtp.model", 1, 0, "KardexModel");
    qmlRegisterType<SerieModel>("com.jmtp.model", 1, 0, "SerieModel");
    qmlRegisterType<ProveedorModel>("com.jmtp.model", 1, 0, "ProveedorModel");

    QQmlApplicationEngine engine;

//    KardexModel *kardexModel = new KardexModel();
//    qDebug()<<"**Cantidad de Items: "<< kardexModel->rowCount();
    engine.rootContext()->setContextProperty("serverHost", settings.value("Server/Url").toString());

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
