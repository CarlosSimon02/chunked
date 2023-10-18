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
    Q_INVOKABLE void insertRecord(Task* task);
    Q_INVOKABLE bool setData(const QModelIndex &index,
                             const QVariant &value,
                             int role = Qt::EditRole) override;

};

#endif // TASKSTABLEMODEL_H
