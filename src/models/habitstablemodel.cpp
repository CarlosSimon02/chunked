#include "habitstablemodel.h"

#include <QSqlRecord>

#include "habit.h"

HabitsTableModel::HabitsTableModel(QObject *parent)
    : BaseTableModel{parent}
{
    setTable("habits");
    setFilter("parentGoalId IS NULL");
    select();
}

void HabitsTableModel::insertRecord(Habit *habit)
{
    QSqlRecord rec = record();
    rec.setGenerated("itemId",false);
    rec.setValue("name", habit->name());
    rec.setValue("category", habit->category());
    rec.setValue("frequency", habit->frequency());
    rec.setValue("startDateTime", habit->startDateTime());
    rec.setValue("endDateTime", habit->endDateTime());
    rec.setValue("parentGoalId", habit->parentGoalId() ? habit->parentGoalId() : QVariant(QMetaType::fromType<int>()) );

    if (!QSqlTableModel::insertRecord(-1,rec))
        qWarning() << "TasksTableModel::insertRecord: Cannot insert task";
}
