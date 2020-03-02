#ifndef FILEIO_H
#define FILEIO_H

#include <QQuickItem>
#include <QQuickView>
#include <QProcess>
#include <QTimer>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
class FileIO : public QObject
{
    Q_OBJECT
    QTimer myTime;
public:
    explicit FileIO(QObject *parent = 0) : QObject(parent) {}
public slots:
    void writeFile(const QString &nameFile,const QString &text) {
        QString urlFile = "../" + nameFile + ".tmp";
        QFile file(urlFile);
        if (!file.open(QFile::Append | QFile::Text)) return;
        QTextStream out(&file);
        out << text << endl;
        file.close();
    }
    QString readFile(const QString &nameFile) {
        QString urlFile = "../" + nameFile + ".tmp";
        QFile file(urlFile);
        if (!file.open(QFile::ReadOnly | QFile::Text)) return "";
        QTextStream in(&file);
        QString temp = in.readAll();
        file.close();
        return temp;
    }
    void clearData(const QString &nameFile){
        QString urlFile = "../" + nameFile + ".tmp";
        QFile file(urlFile);
        if (!file.open(QFile::WriteOnly|QFile::Truncate)) return;
        file.close();
    }
    int numberLine(const QString &nameFile){
        std::string urlFile = "../" + nameFile.toStdString() + ".tmp";
        int numberOfLines = 0;
        std::string line;
        std::ifstream file(urlFile);
        while(getline(file, line))
            numberOfLines++;
        file.close();
        return numberOfLines;
    }
    void deleteLine(const QString &nameFile, qint32 lineNumber){
        QFile oldFile("../" + nameFile + ".tmp");
        QFile newFile("../" + nameFile +"temp.tmp");
        qint32 lineCount = 0;
        if(!oldFile.open(QFile::ReadWrite | QFile::Text) || !newFile.open(QFile::ReadWrite | QFile::Text)) return;
        QTextStream in(&oldFile);
        QTextStream out(&newFile);
        while(!in.atEnd()){
            QString dataLine = in.readLine();
            if(lineNumber != lineCount) out << dataLine << endl;;
            lineCount +=1;
        }
        oldFile.close();
        newFile.close();
        oldFile.remove();
        newFile.rename("../" + nameFile +"temp.tmp", "../" + nameFile +".tmp");
    }
    void restart(){
        qApp->quit();
        QProcess::startDetached(qApp->arguments()[0], qApp->arguments());
    }
};
#endif
