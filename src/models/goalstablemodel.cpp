#include "goalstablemodel.h"

#include <QDebug>
#include <QSqlError>

GoalsTableModel::GoalsTableModel(QObject *parent)
    : BaseTableModel(parent)
{
    setTable("goals");
    select();
}
