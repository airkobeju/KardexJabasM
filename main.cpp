#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "http/getcontroller.h"
#include "http/postcontroller.h"

//#include <bsoncxx/builder/basic/document.hpp>
//#include <bsoncxx/builder/basic/kvp.hpp>
//#include <bsoncxx/json.hpp>
//#include <bsoncxx/stdx/make_unique.hpp>
//#include <bsoncxx/builder/stream/document.hpp>

//#include <mongocxx/client.hpp>
//#include <mongocxx/instance.hpp>
//#include <mongocxx/logger.hpp>
//#include <mongocxx/options/client.hpp>
//#include <mongocxx/uri.hpp>

#include <QFont>
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    /**
    mongocxx::instance instance{}; // This should be done only once.
    mongocxx::uri uri("mongodb://localhost:27017");
    mongocxx::client client(uri);

    mongocxx::database db = client["kardexjabas"];
    mongocxx::collection coll = db["proveedor"];

    auto builder = bsoncxx::builder::stream::document{};
    bsoncxx::document::value doc_value = builder
      << "nombre" << "Juan Manuel"
      << "apellido" << "Ticona Pacheco"
      << bsoncxx::builder::stream::finalize;

    bsoncxx::stdx::optional<mongocxx::result::insert_one> result = coll.insert_one(doc_value.view());
**/

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont("qrc:/fonts/Comfortaa-Regular.ttf");
    QFontDatabase::addApplicationFont("qrc:/fonts/Existence-Light.ttf");
    QFont fnt("Comfortaa", 12);

    app.setFont(fnt);

    qmlRegisterType<GetController>("com.jmtp.http", 1, 0, "GetController");
    qmlRegisterType<PostController>("com.jmtp.http", 1, 0, "PostController");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
