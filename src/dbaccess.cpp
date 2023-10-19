#include "dbaccess.h"

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>
#include <QDateTime>
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

        //for manual tracker base goals
        query.exec("CREATE TABLE IF NOT EXISTS goalProgress ("
                   "itemId INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "value INTEGER, "
                   "target INTEGER,"
                   "goalId INTEGER, "
                   "FOREIGN KEY(goal) REFERENCES goals(itemId) ON DELETE CASCADE"
                   ");");
        if (query.lastError().isValid())
            qWarning() << "DBAccess::DBAccess" << query.lastError().text();

        query.exec("CREATE TABLE IF NOT EXISTS tasks ("
                   "itemId INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "name TEXT, "
                   "done INTEGER, "
                   "dateTime TEXT, "
                   "date TEXT, "  //This is for listview sectioning use only, do not explicitly assign value, base on dateTime value
                   "duration INTEGER, "
                   "outcomes INTEGER, "
                   "parentGoalId INTEGER, "
                   "FOREIGN KEY(parentGoalId) REFERENCES goals(itemId) ON DELETE CASCADE"
                   ");");
        if (query.lastError().isValid())
            qWarning() << "DBAccess::DBAccess" << query.lastError().text();

        query.exec("CREATE TABLE IF NOT EXISTS habits ("
                   "itemId INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "name TEXT, "
                   "category TEXT, "
                   "startDateTime TEXT, "
                   "endDateTime TEXT, "  //This is for listview sectioning use only, do not explicitly assign value, base on dateTime value
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
    goal->setStartDateTime(query.value(3).toDateTime());
    goal->setEndDateTime(query.value(4).toDateTime());
    goal->setProgressTracker(query.value(5).toInt());
    goal->setProgressUnit(query.value(6).toString());
    goal->setMission(query.value(7).toString());
    goal->setVision(query.value(8).toString());
    goal->setObstacles(query.value(9).toString());
    goal->setResources(query.value(10).toString());
    goal->setParentGoalId(query.value(11).toInt());

    return goal;
}

int DBAccess::saveGoalItem(Goal* goal)
{
    QSqlQuery query;
    query.prepare("INSERT INTO goals "
                  "(name, imageSource, category, startDateTime, "
                  "endDateTime, progressTracker, "
                  "progressUnit, mission, vision, obstacles, resources, parentGoalId) "
                  "VALUES "
                  "(:name, :imageSource, :category, :startDateTime, "
                  ":endDateTime, :progressTracker, "
                  ":progressUnit, :mission, :vision, :obstacles, :resources, :parentGoalId);");
    query.bindValue(":name", goal->name());
    query.bindValue(":imageSource", goal->imageSource());
    query.bindValue(":category", goal->category());
    query.bindValue(":startDateTime", goal->startDateTime());
    query.bindValue(":endDateTime", goal->endDateTime());
    query.bindValue(":progressTracker", goal->progressTracker());
    query.bindValue(":progressUnit", goal->progressUnit());
    query.bindValue(":mission", goal->mission());
    query.bindValue(":vision", goal->vision());
    query.bindValue(":obstacles", goal->obstacles());
    query.bindValue(":resources", goal->resources());
    query.bindValue(":parentGoalId", goal->parentGoalId() ? goal->parentGoalId() : QVariant(QMetaType::fromType<int>()));
    query.exec();

    if (query.lastError().isValid())
        qWarning() << query.lastQuery() << "DBAccess::saveGoalItem" << query.lastError().text();

    return query.lastInsertId().toInt();
}

void DBAccess::removeGoalItem(int itemId)
{
    QSqlQuery query;
    query.prepare("DELETE FROM goals WHERE itemId = :itemId");
    query.bindValue(":itemId", itemId);
    query.exec();
}

void DBAccess::updateGoalItem(Goal *goal)
{
    QSqlQuery query;

    //if progress tracker was changed, delete all child items
    if(goal->progressTracker() != getValue("goals", "progressTracker",goal->itemId()))
    {
        query.exec("DELETE FROM goals WHERE parentGoalId = " + goal->itemId());
        query.exec("DELETE FROM tasks WHERE parentGoalId = " + goal->itemId());
        query.exec("DELETE FROM goalProgress WHERE goalId = " + goal->itemId());
        query.exec("DELETE FROM habits WHERE parentGoalId = " + goal->itemId());
    }

    query.prepare("UPDATE goals "
                  "SET name = :name, imageSource = :imageSource, category = :category, "
                  "startDateTime = :startDateTime, endDateTime = :endDateTime, "
                  "progressTracker = :progressTracker, "
                  "progressUnit = :progressUnit, mission = :mission"
                  "vision = :vision, obstacles = :obstacles, resources = :resources, parentGoalId = :parentGoalId "
                  "WHERE itemId = :itemId;");
    query.bindValue(":name", goal->name());
    query.bindValue(":imageSource", goal->imageSource());
    query.bindValue(":category", goal->category());
    query.bindValue(":startDateTime", goal->startDateTime());
    query.bindValue(":endDateTime", goal->endDateTime());
    query.bindValue(":progressTracker", goal->progressTracker());
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
}

Progress DBAccess::getGoalProgress(int itemId)
{
    Progress progress(0,0);
    if(itemId)
    {
        int progressTracker = getValue("goals", "progressTracker", itemId).toInt();
        QSqlQuery query;

        switch (progressTracker)
        {
        case 0:
            query.prepare("SELECT itemId FROM goals WHERE parentGoalId = :parentGoalId;");
            query.bindValue(":parentGoalId",itemId);
            query.exec();
            while(query.next())
            {
                Progress childItemProgress = getGoalProgress(query.value(0).toInt());
                progress.first += childItemProgress.first;
                progress.second += childItemProgress.second;
            }
            break;
        case 1:
            query.prepare("SELECT itemId FROM goals WHERE parentGoalId = :parentGoalId;");
            query.bindValue(":parentGoalId",itemId);
            query.exec();
            while(query.next())
            {
                Progress childItemProgress = getGoalProgress(query.value(0).toInt());
                progress.first += childItemProgress.second > 0 && childItemProgress.first == childItemProgress.second ? 1 : 0;
                progress.second++;
            }
            break;
        case 2:
            query.prepare("SELECT SUM(CASE WHEN done == 1 THEN outcomes ELSE 0 END),SUM(outcomes) FROM tasks WHERE parentGoalId == :parentGoalId;");
            query.bindValue(":parentGoalId",itemId);
            query.exec();
            progress.first = query.value(0).toInt();
            progress.second = query.value(1).toInt();
            break;
        case 3:
            query.prepare("SELECT SUM(CASE WHEN done == 1 THEN 1 ELSE 0 END), COUNT(*) FROM tasks WHERE parentGoalId == :parentGoalId;");
            query.bindValue(":parentGoalId",itemId);
            query.exec();
            progress.first = query.value(0).toInt();
            progress.second = query.value(1).toInt();
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            query.prepare("SELECT value, target FROM goalProgress WHERE goalId == :goalId;");
            query.bindValue(":goalId",itemId);
            query.exec();
            progress.first = query.value(0).toInt();
            progress.second = query.value(1).toInt();
            break;
        }
    }

    return progress;
}

void DBAccess::saveGoalProgress(Progress *progress, int goalId)
{
    QSqlQuery query;
    query.prepare("INSERT INTO goalProgress "
                  "(value, target, goalId) "
                  "VALUES "
                  "(:value, :target, :goalId);");
    query.bindValue(":value", progress->first);
    query.bindValue(":target", progress->second);
    query.bindValue(":goalId", goalId);
    query.exec();

    if (query.lastError().isValid())
        qWarning() << "DBAccess::saveGoalProgress" << query.lastError().text();
}

void DBAccess::removeGoalProgress(int goalId)
{
    QSqlQuery query;
    query.prepare("DELETE FROM goals WHERE itemId = :itemId");
    query.bindValue(":itemId", itemId);
    query.exec();
}

void DBAccess::updateGoalProgress(Progress *progress, int goalId)
{
    QSqlQuery query;
    query.prepare("UPDATE goalProgress "
                  "SET value = :value, target = :target "
                  "WHERE goalId = :goalId;");
    query.bindValue(":value", progress->first);
    query.bindValue(":target", progress->second);
    query.bindValue(":goalId", goalId);
    query.exec();

    if (query.lastError().isValid())
        qWarning() << query.lastQuery() << "DBAccess::updateGoalProgress" << query.lastError().text();
}

Task *DBAccess::getTaskItem(int itemId)
{
    QSqlQuery query;
    query.prepare("SELECT name, done, dateTime, duration, "
                  "outcomes, parentGoalId "
                  "FROM tasks "
                  "WHERE itemId = :itemId;");
    query.bindValue(":itemId", itemId);
    query.exec();

    if (query.lastError().isValid())
        qWarning() << "DBAccess::getTaskItem" << query.lastError().text();

    query.first();

    Task* task = new Task;
    task->setItemId(itemId);
    task->setName(query.value(0).toString());
    task->setDone(query.value(1).toBool());
    task->setDateTime(query.value(2).toDateTime());
    task->setDuration(query.value(3).toInt());
    task->setOutcomes(query.value(4).toInt());
    task->setParentGoalId(query.value(5).toInt());

    return task;
}

void DBAccess::saveTaskItem(Task *task)
{
    QSqlQuery query;
    query.prepare("INSERT INTO tasks "
                  "(name, done, dateTime, date, duration, "
                  "outcomes, parentGoalId) "
                  "VALUES "
                  "(:name, :done, :dateTime, :date, :duration, "
                  ":outcomes, :parentGoalId);");
    query.bindValue(":name", task->name());
    query.bindValue(":done", task->done());
    query.bindValue(":dateTime", task->dateTime());
    query.bindValue(":date", task->dateTime().toString(Qt::ISODate).first(10));
    query.bindValue(":duration", task->duration());
    query.bindValue(":outcomes", task->outcomes());
    query.bindValue(":parentGoalId", task->parentGoalId() ? task->parentGoalId() : QVariant(QMetaType::fromType<int>()));
    query.exec();

    if (query.lastError().isValid())
        qWarning() << "DBAccess::saveTaskItem" << query.lastError().text();
}

void DBAccess::updateTaskItem(Task *task)
{
    QSqlQuery query;

    query.prepare("UPDATE tasks "
                  "SET name = :name, done = :done, dateTime = :dateTime, "
                  "date = :date, duration = :duration, outcomes = :outcomes, parentGoalId = :parentGoalId "
                  "WHERE itemId = :itemId;");
    query.bindValue(":name", task->name());
    query.bindValue(":done", task->done());
    query.bindValue(":dateTime", task->dateTime());
    query.bindValue(":date", task->dateTime().toString(Qt::ISODate).first(10));
    query.bindValue(":duration", task->duration());
    query.bindValue(":outcomes", task->outcomes());
    query.bindValue(":parentGoalId", task->parentGoalId() ? task->parentGoalId() : QVariant(QMetaType::fromType<int>()));
    query.bindValue(":itemId", task->itemId());
    query.exec();

    if (query.lastError().isValid())
        qWarning() << query.lastQuery() << "DBAccess::updateTaskItem" << query.lastError().text();
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
            query.prepare("SELECT SUM(outcomes) FROM tasks WHERE parentGoalId = :parentGoalId;");
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
    Progress progress(0,0);
    if(itemId)
    {
        int progressTracker = getValue("goals", "progressTracker", itemId).toInt();
        QSqlQuery query;

        switch (progressTracker)
        {
        case 0:
            query.prepare("SELECT itemId FROM goals WHERE parentGoalId = :parentGoalId;");
            query.bindValue(":parentGoalId",itemId);
            query.exec();
        case 1:
            query.prepare("SELECT COUNT(*) FROM goals WHERE parentGoalId = :parentGoalId AND progressValue >= targetValue AND targetValue > 0;");
            break;
        case 2:
            query.prepare("SELECT SUM(outcomes) FROM tasks WHERE parentGoalId = :parentGoalId AND done = 1;");
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

    return progress;
}



