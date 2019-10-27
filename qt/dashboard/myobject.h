#ifndef MYOBJECT_H
#define MYOBJECT_H

#include <QObject>
#include <QDebug>

class MyObject : public QObject
{
    Q_OBJECT
public:
    explicit MyObject (QObject* parent = nullptr);
    Q_INVOKABLE int turnOn(int on){
        qDebug() << "MyObject::turnOn() " << on << endl;
        return on;
    }

signals:

public slots:
};

#endif // MYOBJECT_H
