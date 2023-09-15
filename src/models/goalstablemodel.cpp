#include "goalstablemodel.h"

#include <QDebug>
#include <QSqlError>

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

void GoalsTableModel::insertRecord(Goal* goal)
{
    QSqlRecord rec = record();
    rec.setGenerated("itemId",false);
    rec.setValue("name", goal->name());
    rec.setValue("imageSource", goal->imageSource());
    rec.setValue("category", goal->category());
    rec.setValue("startDateTime", goal->startDateTime());
    rec.setValue("endDateTime", goal->endDateTime());
    rec.setValue("progressTracker", goal->progressTracker());
    rec.setValue("progressValue", goal->progressValue());
    rec.setValue("targetValue", goal->targetValue());
    rec.setValue("progressUnit", goal->progressUnit());
    rec.setValue("mission", goal->mission());
    rec.setValue("vision", goal->vision());
    rec.setValue("obstacles", goal->obstacles());
    rec.setValue("resources", goal->resources());
    rec.setValue("parentGoalId", goal->parentGoalId() ? goal->parentGoalId() : QVariant(QMetaType::fromType<int>()));

    if (!insertRecord(0,rec))
        qWarning() << "GoalsTableModel::insertGoal: Cannot insert goal";

}
