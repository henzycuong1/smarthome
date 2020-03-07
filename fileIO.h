#ifndef FILEIO_H
#define FILEIO_H

#include <QQuickItem>
#include <QQuickView>
#include <QProcess>
#include <QTimer>
class FileIO : public QObject
{
    Q_OBJECT
public:
    explicit FileIO(QObject *parent = nullptr);
public slots:
    void writeFile(const QString &nameFile,const QString &text);
    QString readFile(const QString &nameFile);
    void restart();
    void goLockScreen();
protected:
    bool eventFilter(QObject *obj, QEvent *event) override;
    QTimer m_timer;
};

#endif
