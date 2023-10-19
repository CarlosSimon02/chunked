#ifndef DBACCESS_H
#define DBACCESS_H

#include <QObject>
#include <QtQml/qqml.h>
#include <QPair>

#include "goal.h"
#include "progress.h"
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
    Q_INVOKABLE int saveGoalItem(Goal* goal);
    Q_INVOKABLE void removeGoalItem(int itemId);
    Q_INVOKABLE void updateGoalItem(Goal* goal);
    Q_INVOKABLE Progress* getGoalProgress(int goalId);
    Q_INVOKABLE void saveGoalProgress(Progress* progress);
    Q_INVOKABLE void removeGoalProgress(int goalId);
    Q_INVOKABLE void updateGoalProgress(Progress* progress);
    Q_INVOKABLE Task* getTaskItem(int itemId);
    Q_INVOKABLE void saveTaskItem(Task* task);
    Q_INVOKABLE void updateTaskItem(Task* task);

signals:

};

#endif // DBACCESS_H
