#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>
#include <QQmlEngine>
#include <fileIO.h>
int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("fileDialog");
    app.setOrganizationDomain("fileDialog");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");
    engine.load(url);

    return app.exec();
}
