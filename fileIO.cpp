#include <fileIO.h>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
FileIO::FileIO(QObject *parent) : QObject(parent){
    m_timer.setInterval(5000);
    m_timer.start();
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
    if (event->type() == QEvent::GrabMouse)
           m_timer.start();
    return QObject::eventFilter(obj, event);
}
void FileIO::goLockScreen(){
    qDebug("test");
}
