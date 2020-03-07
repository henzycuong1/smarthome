#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>
#include <QQuickView>
#include <QQmlEngine>
#include <fileIO.h>
int main(int argc, char *argv[])
{
    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    QGuiApplication app(argc, argv);
    app.setOrganizationName("fileDialog");
    app.setOrganizationDomain("fileDialog");
    app.installEventFilter(new FileIO());
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
//    QQuickItem *item = engine.rootObjects().at(0)->findChild<QQuickItem*>("LockScreen123");
//    if(item)
//        item->setProperty("visible",true);
    return app.exec();
}

