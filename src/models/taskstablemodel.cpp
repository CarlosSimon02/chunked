#include "taskstablemodel.h"

#include <QSqlError>

TasksTableModel::TasksTableModel(QObject *parent)
    : BaseTableModel{parent}
{
    setTable("tasks");
    setFilter("parentGoalId IS NULL");
    select();
}
