#ifndef DBACCESS_H
#define DBACCESS_H

#include <QObject>
#include <QtQml/qqml.h>

#include "goal.h"

class QSqlDatabase;

class DBAccess : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit DBAccess(QObject *parent = nullptr);
    QSqlDatabase database();

private:
    bool checkDBSchema();

signals:

};

#endif // DBACCESS_H
