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
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    qDebug() << "this is main, thread id's " << app.thread() -> currentThread();
    return app.exec();
}

