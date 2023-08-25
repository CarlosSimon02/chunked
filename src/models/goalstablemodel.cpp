#include "goalstablemodel.h"

#include <QDebug>
#include <QSqlError>

GoalsTableModel::GoalsTableModel(QObject *parent)
    : BaseTableModel(parent)
{
}

void GoalsTableModel::select()
{
    QString condition = parentGoalId() ? "parentGoalId = " + QString::number(parentGoalId()) : "parentGoalId IS NULL";
    setQuery("SELECT "
             "itemId, name, imageSource, category, startDateTime, "
             "endDateTime, progressValue, targetValue, progressUnit "
             "FROM goals "
             "WHERE " + condition + ";");

    if (lastError().isValid())
        qWarning() << "GoalsTableModel::select" << lastError().text();
}


