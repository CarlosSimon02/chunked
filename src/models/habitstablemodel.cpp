#include "habitstablemodel.h"

HabitsTableModel::HabitsTableModel(QObject *parent)
    : BaseTableModel{parent}
{
    setTable("habits");
    setFilter("parentGoalId IS NULL");
    select();
}
