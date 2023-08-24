#include "taskstablemodel.h"

TasksTableModel::TasksTableModel(QObject *parent)
    : BaseTableModel{parent}
{

}

void TasksTableModel::select()
{
    QString condition = parentGoalId() ? "parentGoalId = " + QString::number(parentGoalId()) : "parentGoalId IS NULL";
    setQuery("SELECT "
             "itemId, name, done, startDateTime, "
             "endDateTime, progressValue, targetValue, progressUnit "
             "FROM tasks "
             "WHERE " + condition + ";");

    if (lastError().isValid())
        qWarning() << "GoalsTableModel::select" << lastError().text();
}
