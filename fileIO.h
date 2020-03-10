#ifndef FILEIO_H
#define FILEIO_H

#include <QQuickItem>
#include <QQuickView>
#include <QProcess>
#include <QTimer>
#include <QDateTime>
class FileIO : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(bool appIsActive READ appIsActive WRITE setAppIsActive NOTIFY appIsActiveChanged)
public:
    explicit FileIO(QObject *parent = nullptr);
//    inline bool appIsActive() const {return m_appIsActive;}
public slots:
    void writeFile(const QString &nameFile,const QString &text);
    QString readFile(const QString &nameFile);
    void restart();
 //   void setAppIsActive(bool appIsActive);

private slots:
    void appNowInactive();
signals:
 //   void appIsActiveChanged(bool appIsActive);
    void signalAppIsDoubleClick();
    void signalAppIsInactive();
protected:
    bool eventFilter(QObject *obj, QEvent *event) override;
    QTimer m_timer;
 //   bool m_appIsActive = true;
};

#endif
