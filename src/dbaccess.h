#ifndef DBACCESS_H
#define DBACCESS_H

#include <QObject>
#include <QtQml/qqml.h>

#include "goal.h"

class DBAccess : public QObject
{
    Q_OBJECT
    QML_ELEMENT

private:
    void initSchema();

public:
    explicit DBAccess(QObject *parent = nullptr);


signals:

};

#endif // DBACCESS_H
