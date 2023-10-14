#include "dbaccess.h"

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

DBAccess::DBAccess(QObject *parent)
    : QObject{parent}
{
    if(!QSqlDatabase::contains(QSqlDatabase::defaultConnection))
    {
        //opens connection
        QSqlDatabase db{ QSqlDatabase::addDatabase("QSQLITE") };
        db.setDatabaseName(":memory:");
        if(!db.open())
            qWarning() << db.lastError().text();

        //initialize database schema
        QSqlQuery query;
        query.exec("PRAGMA foreign_keys = ON;");
        query.exec("CREATE TABLE IF NOT EXISTS goals ("
                   "itemId INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "name TEXT, "
                   "imageSource TEXT,"
                   "category TEXT, "
                   "startDateTime VARCHAR(20), "
                   "endDateTime VARCHAR(20), "
                   "progressTracker INTEGER, "
                   "progressValue INTEGER, "
                   "targetValue INTEGER, "
                   "progressUnit VARCHAR(20),"
                   "mission TEXT, "
                   "vision TEXT, "
                   "obstacles TEXT, "
                   "resources TEXT, "
                   "parentGoalId INTEGER, "
                   "FOREIGN KEY(parentGoalId) REFERENCES goals(itemId) ON DELETE CASCADE"
                   ");");
        if (query.lastError().isValid())
            qWarning() << "DBAccess::DBAccess" << query.lastError().text();

        query.exec("CREATE TABLE IF NOT EXISTS tasks ("
                   "itemId INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "name TEXT, "
                   "done INTEGER, "
                   "dateTime TEXT, "
                   "duration INTEGER, "
                   "outcomes INTEGER, "
                   "parentGoalId INTEGER, "
                   "FOREIGN KEY(parentGoalId) REFERENCES goals(itemId) ON DELETE CASCADE"
                   ");");
        if (query.lastError().isValid())
            qWarning() << "DBAccess::DBAccess" << query.lastError().text();
    }
}

QVariant DBAccess::getValue(const QString& tableName,
                            const QString& columnName,
                            int itemId)
{
    QSqlQuery query;
    query.prepare("SELECT " + columnName + " FROM " + tableName + " WHERE itemId = :itemId;");
    query.bindValue(":itemId", itemId);
    query.exec();

    if(query.lastError().isValid())
        qWarning() << "DBAccess::getValue" << query.lastError().text();

    query.next();
    return query.value(0);
}

void DBAccess::updateValue(const QString& tableName,
                           const QString& columnName,
                           int itemId,
                           const QVariant& value)
{
    QSqlQuery query;
    query.prepare("UPDATE " + tableName + " SET " + columnName + " = :value WHERE itemId = :itemId");
    query.bindValue(":value",value);
    query.bindValue(":itemId", itemId);
    query.exec();

    if(query.lastError().isValid())
        qWarning() << "DBAccess::updateValue" << query.lastError().text();

    if(columnName == "targetValue" && tableName == "goals")
        updateParentGoalTargetValue(getValue(tableName,"parentGoalId",itemId).toInt());
    else if((columnName == "progressValue" && tableName == "goals") ||
             (columnName == "done" && tableName == "tasks"))
        updateParentGoalProgressValue(getValue(tableName,"parentGoalId",itemId).toInt());
}

Goal* DBAccess::getGoalItem(int itemId)
{
    QSqlQuery query;
    query.prepare("SELECT name, imageSource, category, startDateTime, "
                  "endDateTime, progressTracker, progressValue, targetValue, "
                  "progressUnit, mission, vision, obstacles, resources, parentGoalId "
                  "FROM goals "
                  "WHERE itemId = :itemId;");
    query.bindValue(":itemId", itemId);
    query.exec();

    if (query.lastError().isValid())
        qWarning() << "DBAccess::getGoalItem" << query.lastError().text();

    query.first();

    Goal* goal = new Goal;
    goal->setItemId(itemId);
    goal->setName(query.value(0).toString());
    goal->setImageSource(query.value(1).toString());
    goal->setCategory(query.value(2).toString());
    goal->setStartDateTime(query.value(3).toString());
    goal->setEndDateTime(query.value(4).toString());
    goal->setProgressTracker(query.value(5).toInt());
    goal->setProgressValue(query.value(6).toInt());
    goal->setTargetValue(query.value(7).toInt());
    goal->setProgressUnit(query.value(8).toString());
    goal->setMission(query.value(9).toString());
    goal->setVision(query.value(10).toString());
    goal->setObstacles(query.value(11).toString());
    goal->setResources(query.value(12).toString());
    goal->setParentGoalId(query.value(13).toInt());

    return goal;
}

void DBAccess::saveGoalItem(Goal* goal)
{
    QSqlQuery query;
    query.prepare("INSERT INTO goals "
                  "(name, imageSource, category, startDateTime, "
                  "endDateTime, progressTracker, progressValue, targetValue, "
                  "progressUnit, mission, vision, obstacles, resources, parentGoalId) "
                  "VALUES "
                  "(:name, :imageSource, :category, :startDateTime, "
                  ":endDateTime, :progressTracker, :progressValue, :targetValue, "
                  ":progressUnit, :mission, :vision, :obstacles, :resources, :parentGoalId);");
    query.bindValue(":name", goal->name());
    query.bindValue(":imageSource", goal->imageSource());
    query.bindValue(":category", goal->category());
    query.bindValue(":startDateTime", goal->startDateTime());
    query.bindValue(":endDateTime", goal->endDateTime());
    query.bindValue(":progressTracker", goal->progressTracker());
    query.bindValue(":progressValue", goal->progressValue());
    query.bindValue(":targetValue", goal->targetValue());
    query.bindValue(":progressUnit", goal->progressUnit());
    query.bindValue(":mission", goal->mission());
    query.bindValue(":vision", goal->vision());
    query.bindValue(":obstacles", goal->obstacles());
    query.bindValue(":resources", goal->resources());
    query.bindValue(":parentGoalId", goal->parentGoalId() ? goal->parentGoalId() : QVariant(QMetaType::fromType<int>()));
    query.exec();

    if (query.lastError().isValid())
        qWarning() << query.lastQuery() << "DBAccess::saveGoalItem" << query.lastError().text();

    if(goal->targetValue())
        updateParentGoalTargetValue(goal->parentGoalId());
    if(goal->progressValue())
        updateParentGoalProgressValue(goal->parentGoalId());
}

void DBAccess::updateGoalItem(Goal *goal)
{
    QSqlQuery query;

    //if progress tracker was changed, delete all child items
    if(goal->progressTracker() != getValue("goals", "progressTracker",goal->itemId()))
    {
        query.exec("DELETE FROM goals WHERE parentGoalId = " + goal->itemId());
        query.exec("DELETE FROM tasks WHERE parentGoalId = " + goal->itemId());
    }

    query.prepare("UPDATE goals "
                  "SET name = :name, imageSource = :imageSource, category = :category, "
                  "startDateTime = :startDateTime, endDateTime = :endDateTime, "
                  "progressTracker = :progressTracker, progressValue = :progressValue, "
                  "targetValue = :targetValue, progressUnit = :progressUnit, mission = :mission"
                  "vision = :vision, obstacles = :obstacles, resources = :resources, parentGoalId = :parentGoalId "
                  "WHERE itemId = :itemId;");
    query.bindValue(":name", goal->name());
    query.bindValue(":imageSource", goal->imageSource());
    query.bindValue(":category", goal->category());
    query.bindValue(":startDateTime", goal->startDateTime());
    query.bindValue(":endDateTime", goal->endDateTime());
    query.bindValue(":progressTracker", goal->progressTracker());
    query.bindValue(":progressValue", goal->progressValue());
    query.bindValue(":targetValue", goal->targetValue());
    query.bindValue(":progressUnit", goal->progressUnit());
    query.bindValue(":mission", goal->mission());
    query.bindValue(":vision", goal->vision());
    query.bindValue(":obstacles", goal->obstacles());
    query.bindValue(":resources", goal->resources());
    query.bindValue(":parentGoalId", goal->parentGoalId() ? goal->parentGoalId() : QVariant(QMetaType::fromType<int>()));
    query.bindValue(":itemId", goal->itemId());
    query.exec();

    if (query.lastError().isValid())
        qWarning() << query.lastQuery() << "DBAccess::updateGoalItem" << query.lastError().text();

    updateParentGoalTargetValue(goal->parentGoalId());
    updateParentGoalProgressValue(goal->parentGoalId());
}

void DBAccess::saveTaskItem(Task *task)
{
    QSqlQuery query;
    query.prepare("INSERT INTO tasks "
                  "(name, done, startDateTime, endDateTime, actualDuration, "
                  "outcome, notes, parentGoalId) "
                  "VALUES "
                  "(:name, :done, :startDateTime, :endDateTime, :actualDuration, "
                  ":outcome, :notes, :parentGoalId);");
    query.bindValue(":name", task->name());
    query.bindValue(":done", task->done());
    query.bindValue(":startDateTime", task->startDateTime());
    query.bindValue(":endDateTime", task->endDateTime());
    query.bindValue(":actualDuration", task->actualDuration());
    query.bindValue(":outcome", task->outcome());
    query.bindValue(":notes", task->notes());
    query.bindValue(":parentGoalId", task->parentGoalId() ? task->parentGoalId() : QVariant(QMetaType::fromType<int>()));
    query.exec();

    if (query.lastError().isValid())
        qWarning() << "DBAccess::saveTaskItem" << query.lastError().text();

    updateParentGoalTargetValue(task->parentGoalId());
    if(task->done())
        updateParentGoalProgressValue(task->parentGoalId());
}

void DBAccess::updateParentGoalTargetValue(int itemId)
{
    if(itemId)
    {
        int progressTracker = getValue("goals", "progressTracker", itemId).toInt();
        QSqlQuery query;

        switch (progressTracker)
        {
        case 0:
            query.prepare("SELECT SUM(targetValue) FROM goals WHERE parentGoalId = :parentGoalId;");
            break;
        case 1:
            query.prepare("SELECT COUNT(*) FROM goals WHERE parentGoalId = :parentGoalId;");
            break;
        case 2:
            query.prepare("SELECT SUM(outcome) FROM tasks WHERE parentGoalId = :parentGoalId;");
            break;
        case 3:
            query.prepare("SELECT COUNT(*) FROM tasks WHERE parentGoalId = :parentGoalId;");
            break;
        case 4:
            return;
            break;
        case 5:
            return;
            break;
        case 6:
            return;
        }

        query.bindValue(":parentGoalId",itemId);
        query.exec();

        if (query.lastError().isValid())
            qWarning() << query.lastQuery() << "\n" << "DBAccess::updateParentGoalTargetValue" << query.lastError().text();

        query.first();
        updateValue("goals", "targetValue", itemId, query.value(0).toInt());
    }
}

void DBAccess::updateParentGoalProgressValue(int itemId)
{
    if(itemId)
    {
        int progressTracker = getValue("goals", "progressTracker", itemId).toInt();
        QSqlQuery query;

        switch (progressTracker)
        {
        case 0:
            query.prepare("SELECT SUM(progressValue) FROM goals WHERE parentGoalId = :parentGoalId;");
            break;
        case 1:
            query.prepare("SELECT COUNT(*) FROM goals WHERE parentGoalId = :parentGoalId AND progressValue >= targetValue AND targetValue > 0;");
            break;
        case 2:
            query.prepare("SELECT SUM(outcome) FROM tasks WHERE parentGoalId = :parentGoalId AND done = 1;");
            break;
        case 3:
            query.prepare("SELECT COUNT(*) FROM tasks WHERE parentGoalId = :parentGoalId AND done = 1;");
            break;
        case 4:
            return;
            break;
        case 5:
            return;
            break;
        case 6:
            return;
        }

        query.bindValue(":parentGoalId",itemId);
        query.exec();

        if (query.lastError().isValid())
            qWarning() << query.lastQuery() << "\n" << "DBAccess::updateParentGoalProgressValue" << query.lastError().text();

        query.first();
        updateValue("goals", "progressValue", itemId, query.value(0).toInt());
    }
}



