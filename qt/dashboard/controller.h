#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QThread>

class Controller : public QObject
{
    Q_OBJECT
    QThread workerThread;
public:
    Controller() {
    }

    ~Controller() {
    }
public slots:
    void handleResults(const QString &);
signals:
    void operate(const QString &);
};

#endif // CONTROLLER_H
