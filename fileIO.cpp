#include <fileIO.h>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
FileIO::FileIO(QObject *parent) : QObject(parent){
    m_timer.setInterval(30000);
    connect(&m_timer,&QTimer::timeout,this,&FileIO::appNowInactive);
    connect(&m_timer,&QTimer::timeout, &m_timer, &QTimer::stop);
}
void FileIO::writeFile(const QString &nameFile,const QString &text) {
    QString urlFile = "../smarthome/" + nameFile;
    QFile file(urlFile);
    if (!file.open(QFile::WriteOnly | QFile::Text)) return;
    QTextStream out(&file);
    out << text << endl;
    file.close();
}
QString FileIO::readFile(const QString &nameFile) {
    QString urlFile = "../smarthome/" + nameFile;
    QFile file(urlFile);
    if (!file.open(QFile::ReadOnly | QFile::Text)) return "";
    QTextStream in(&file);
    QString temp = in.readAll();
    file.close();
    return temp;
}
void FileIO::restart(){
    qApp->quit();
    QProcess::startDetached(qApp->arguments()[0], qApp->arguments());
}
bool FileIO::eventFilter(QObject *obj, QEvent *event){
    if(event->type() == QEvent::MouseMove || event->type() == QEvent::MouseButtonPress || event->type() == QEvent::MouseButtonRelease){
//        setAppIsActive(true);
        m_timer.start();
    }
    if(event->type() == QEvent::MouseButtonDblClick){
        emit signalAppIsDoubleClick();
    }
    // standard event processing
    return QObject::eventFilter(obj, event);
}
//void FileIO::setAppIsActive(bool appIsActive)
//{
//    if (m_appIsActive == appIsActive)
//        return;

//    m_appIsActive = appIsActive;
//    emit appIsActiveChanged(m_appIsActive);
//    emit m_appIsActive ? signalAppIsActive() : signalAppIsInactive();
//}

void FileIO::appNowInactive()
{
//    setAppIsActive(false);
    emit signalAppIsInactive();
    qDebug() << "App is idle";
}
