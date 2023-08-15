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
    Q_INVOKABLE void loadData(Goal* goal);
    Q_INVOKABLE void saveData(Goal* goal);
    Q_INVOKABLE QVariant getData(const QString& tableName, const QString& columnName, int itemId);

signals:

};

#endif // DBACCESS_H
