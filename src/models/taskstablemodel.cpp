#include "taskstablemodel.h"

#include <QSqlError>
#include <QSqlRecord>

#include "task.h"

TasksTableModel::TasksTableModel(QObject *parent)
    : BaseTableModel{parent}
{
    setTable("tasks");
    setFilter("parentGoalId IS NULL");
    select();
}

void TasksTableModel::insertTask(Task *task)
{
    QSqlRecord rec = record();
    rec.setValue("name", task->name());
    rec.setValue("startDateTime", task->startDateTime());
    rec.set
}
