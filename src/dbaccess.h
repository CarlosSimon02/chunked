#ifndef DBACCESS_H
#define DBACCESS_H

#include <QObject>
#include <QtQml/qqml.h>

#include "goal.h"
#include "task.h"
#include "models/goalstablemodel.h"
#include "models/taskstablemodel.h"

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
    Q_INVOKABLE void saveTaskItem(Task* task);
    Q_INVOKABLE GoalsTableModel* createGoalsTableModel(int parentGoalId = 0);
    Q_INVOKABLE TasksTableModel* createTasksTableModel(int parentGoalId = 0);

private:
    void checkParentGoalUpdate(const QString& columnName,
                               int itemId);
    void updateParentGoalTargetValue(int itemId);
    void updateParentGoalProgressValue(int itemId);

signals:

};

#endif // DBACCESS_H
