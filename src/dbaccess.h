#ifndef DBACCESS_H
#define DBACCESS_H

#include <QObject>
#include <QtQml/qqml.h>

#include "goal.h"
#include "task.h"

class DBAccess : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit DBAccess(QObject *parent = nullptr);
    Q_INVOKABLE QVariant getValue(const QString& tableName,
                                  const QString& columnName,
                                  int itemId);
    Q_INVOKABLE void updateValue(const QString& tableName,
                                 const QString& columnName,
                                 int itemId,
                                 const QVariant& value);

    Q_INVOKABLE Goal* getGoalItem(int itemId);
    Q_INVOKABLE void saveGoalItem(Goal* goal);
    Q_INVOKABLE void removeGoalItem(int itemId);
    Q_INVOKABLE void updateGoalItem(Goal* goal);
    Q_INVOKABLE Task* getTaskItem(int itemId);
    Q_INVOKABLE void saveTaskItem(Task* task);

private:
    void updateParentGoalTargetValue(int itemId);
    void updateParentGoalProgressValue(int itemId);

signals:

};

#endif // DBACCESS_H
