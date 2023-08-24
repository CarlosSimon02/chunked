#include "taskstablemodel.h"

#include <QSqlError>

TasksTableModel::TasksTableModel(QObject *parent)
    : BaseTableModel{parent}
{

}

void TasksTableModel::select()
{
    QString condition = parentGoalId() ? "parentGoalId = " + QString::number(parentGoalId()) : "parentGoalId IS NULL";
    setQuery("SELECT "
             "itemId, name, done, startDateTime, "
             "endDateTime, outcome "
             "FROM tasks "
             "WHERE " + condition + ";");

    if (lastError().isValid())
        qWarning() << "TasksTableModel::select" << lastError().text();
}
