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
//    rec.setValue("itemId", QVariant());
    rec.setValue("name", task->name());
    rec.setValue("done", 0);
//    rec.setValue("startDateTime", task->startDateTime());
//    rec.setValue("endDateTime", task->endDateTime());
//    rec.setValue("actualDuration", task->actualDuration());
//    rec.setValue("outcome", task->outcome());
//    rec.setValue("notes", task->notes());
//    rec.setValue("parentGoalId", task->parentGoalId());

//    qWarning() << rec.value("name");

    if(rowCount() == 0)
        beginInsertRows(QModelIndex(),0,1);

    if (!insertRecord(0,rec))
        qWarning() << "TasksTableModel::insertTask: Cannot insert task";
}
