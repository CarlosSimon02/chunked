#ifndef TASKSTABLEMODEL_H
#define TASKSTABLEMODEL_H

#include <QQmlEngine>
#include "models/basetablemodel.h"

class Task;

class TasksTableModel : public BaseTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit TasksTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void insertTask(Task* task);
};

#endif // TASKSTABLEMODEL_H
