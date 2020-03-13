#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick>
#include <QQuickView>
#include <QQmlEngine>
#include <fileIO.h>
#include <myimagesaver.h>
int main(int argc, char *argv[])
{
    qmlRegisterType<FileIO>("FileIO", 1, 0, "FileIO");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    QGuiApplication app(argc, argv);
    FileIO *fileIO = new FileIO();
    app.installEventFilter(fileIO);
    app.setOrganizationName("fileDialog");
    app.setOrganizationDomain("fileDialog");
    QQmlApplicationEngine engine;
    MyImageSaver myImageSaver;
    engine.rootContext()->setContextProperty("MyImageSaver",&myImageSaver);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [&engine,url,fileIO](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
        QObject::connect(fileIO, SIGNAL(signalAppIsDoubleClick()), engine.rootObjects().first(), SIGNAL(appIsDoubleClick()));
        QObject::connect(fileIO, SIGNAL(signalAppIsInactive()), engine.rootObjects().first(), SIGNAL(appIsInactive()));
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}

