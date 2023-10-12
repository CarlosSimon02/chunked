#include "goalstablemodel.h"

#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>

#include "goal.h"

GoalsTableModel::GoalsTableModel(QObject *parent)
    : BaseTableModel(parent)
{
    setTable("goals");
    setQuery("SELECT itemId, name, imageSource, category, startDateTime, "
             "endDateTime, progressTracker, progressValue, targetValue, progressUnit, parentGoalId "
             "FROM goals;");
    setFilter("parentGoalId IS NULL");

    if(lastError().isValid())
        qWarning() << "GoalsTableModel::GoalsTableModel" << lastError().text();
}
