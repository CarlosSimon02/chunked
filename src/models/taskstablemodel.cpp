#include "taskstablemodel.h"

#include <QSqlError>

TasksTableModel::TasksTableModel(QObject *parent)
    : BaseTableModel{parent}
{
    setTable("tasks");
    select();
}
