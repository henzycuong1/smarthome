#include "myimagesaver.h"
#include <QFile>
#include <QImage>
#include <QDebug>
#include <QBuffer>
#include <QStandardPaths>
#include <QQuickItemGrabResult>
#include <QDateTime>
MyImageSaver::MyImageSaver(QObject *parent)
    : QObject { parent }
{
}

bool MyImageSaver::savePicture(const QString &id, QObject *objectImage)
{
    const int nImages = mImages.size();
    for (int ix = 0; ix < nImages; ++ix)
    {
        if (mImages.at(ix).id() == id)
        {
            return false;
        }
    }

    QQuickItemGrabResult *item = static_cast<QQuickItemGrabResult *>(objectImage);
    QByteArray imageData;
    QBuffer buffer(&imageData);
    if (item->image().save(&buffer, "PNG"))
    {
        MyImage image;
        image.setData(imageData);
        image.setId(id);
        mImages.append(image);
        return true;
    }
    return false;
}

bool MyImageSaver::writePictures()
{
    const int nImages = mImages.size();
    for (int ix = 0; ix < nImages; ++ix)
    {
        QFile file;
  //      QString filename = mImages.at(ix).id().split("/").last() + ".png";
        QString date = QString(QDateTime::currentDateTime().toString());
        QString dateName;
        for(int i = 0; i < date.size(); i++){
            if(date[i] == ' ' || date[i] == ':'){
                dateName.append('-');
                continue;
            }
            dateName.append(date[i]);
        }
        qDebug () << "name: " << dateName << endl;
        QString filename = dateName + ".png";
        QString directory = QStandardPaths::writableLocation(QStandardPaths::DesktopLocation);
        QString path = directory + "/" + filename;
        file.setFileName(path);
        if (file.open(QIODevice::WriteOnly))
        {
            if (file.write(mImages.at(ix).data()) > 0)
            {
                file.flush();
                file.close();
            }
            else
            {
                qDebug() << "Error: " << file.errorString();
                return false;
            }
        }
        else
        {
            qDebug() << "Error write picture: " << file.errorString();
            return false;
        }
    }
    return true;
}
