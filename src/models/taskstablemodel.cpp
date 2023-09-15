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

void TasksTableModel::insertRecord(Task *task)
{
    QSqlRecord rec = record();
    rec.setGenerated("itemId",false);
    rec.setValue("name", task->name());
    rec.setValue("done", 0);
    rec.setValue("startDateTime", task->startDateTime());
    rec.setValue("endDateTime", task->endDateTime());
    rec.setValue("actualDuration", task->actualDuration());
    rec.setValue("outcome", task->outcome());
    rec.setValue("notes", task->notes());
    rec.setValue("parentGoalId", task->parentGoalId() ? task->parentGoalId() : QVariant(QMetaType::fromType<int>()) );

    if (!insertRecord(0,rec))
        qWarning() << "TasksTableModel::insertRecord: Cannot insert task";

}
