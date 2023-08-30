#include "goalstablemodel.h"

#include <QDebug>
#include <QSqlError>

GoalsTableModel::GoalsTableModel(QObject *parent)
    : BaseTableModel(parent)
{
    setTable("goals");
    setQuery("SELECT itemId, name, imageSource, category, startDateTime, "
             "endDateTime, progressTracker, progressValue, targetValue, progressUnit, parentGoalId "
             "FROM goals;");

    if(lastError().isValid())
        qWarning() << "GoalsTableModel::GoalsTableModel" << lastError().text();
}
