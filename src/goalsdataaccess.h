#ifndef GOALSDATAACCESS_H
#define GOALSDATAACCESS_H

#include <QObject>
#include <QQmlEngine>

class GoalsDataAccess
{
    Q_OBJECT
    QML_ELEMENT
public:
    GoalsDataAccess(QObject *parent = nullptr);
    Q_INVOKABLE void loadData(Goal* goal);
    Q_INVOKABLE void saveData(Goal* goal);
    Q_INVOKABLE QVariant getData(const QString& tableName, const QString& columnName, int itemId);
};

#endif // GOALSDATAACCESS_H
