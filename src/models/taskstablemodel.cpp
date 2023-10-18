#include "taskstablemodel.h"

#include <QSqlError>
#include <QSqlRecord>
#include <QDateTime>

#include "dbaccess.h"
#include "task.h"

TasksTableModel::TasksTableModel(QObject *parent)
    : BaseTableModel{parent}
{
    setTable("tasks");
    setFilter("parentGoalId IS NULL");
    setSort(fieldIndex("dateTime"),Qt::DescendingOrder);
    select();
}

void TasksTableModel::insertRecord(Task *task)
{
    QSqlRecord rec = record();
    rec.setGenerated("itemId",false);
    rec.setValue("name", task->name());
    rec.setValue("done", 0);
    rec.setValue("dateTime", task->dateTime());
    rec.setValue("date", task->dateTime().toString(Qt::ISODate).first(10));
    rec.setValue("duration", task->duration());
    rec.setValue("outcomes", task->outcomes());
    rec.setValue("parentGoalId", task->parentGoalId() ? task->parentGoalId() : QVariant(QMetaType::fromType<int>()) );

    DBAccess dbAccess;
    for(int i = 0; i < rowCount(); i++)
    {
        if(record(i).value("dateTime").toDateTime() < task->dateTime())
        {
            QSqlTableModel::insertRecord(i,rec);
            return;
        }
    }

    if (!QSqlTableModel::insertRecord(-1,rec))
        qWarning() << "TasksTableModel::insertRecord: Cannot insert task";
}

