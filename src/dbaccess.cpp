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
                   "FOREIGN KEY(parentGoalId) REFERENCES goals(itemId)"
                   ");");
        if (query.lastError().isValid())
            qWarning() << "DBAccess::DBAccess" << query.lastError().text();

        query.exec("CREATE TABLE IF NOT EXISTS tasks ("
                   "itemId INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "name TEXT, "
                   "completed INTEGER, "
                   "outcome INTEGER, "
                   "parentGoalId INTEGER, "
                   "FOREIGN KEY(parentGoalId) REFERENCES goals(itemId)"
                   ");");
        if (query.lastError().isValid())
            qWarning() << "DBAccess::DBAccess" << query.lastError().text();

//        //just example data --to be deleted
//        for(int i = 0; i < 10; i++)
//        {
//            query.exec("INSERT INTO goals (name,imageSource,category,startDateTime,endDateTime,progressTracker,progressValue,targetValue,progressUnit) VALUES ("
//                       "'Become a Freaking Software Engineer', 'file:/Users/Carlos Simon/Downloads/643b8d08354c7818786eb7a9_Prompt engineer.png', 'Home', "
//                       "'02 Sep 2023 11:59 PM', '02 Sep 2023 11:59 PM',"
//                       "0, 70, 100, 'plates');");
//        }

//        if (query.lastError().isValid())
//            qWarning() << query.lastError().text();
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

    checkParentGoalUpdate(columnName, getValue(tableName,"parentGoalId",itemId).toInt());
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
        qWarning() << "DBAccess::saveGoalItem" << query.lastError().text();
}

GoalsTableModel *DBAccess::createGoalsTableModel(int parentGoalId)
{
    GoalsTableModel* model = new GoalsTableModel;
    model->setTable("goals");

    if(parentGoalId)
        model->setFilter("parentGoalId = "+QString::number(parentGoalId));
    else
        model->setFilter("parentGoalId IS NULL");

    model->select();

    if (model->lastError().isValid())
        qWarning() << "DBAccess::createGoalsTableModel" << model->lastError().text();

    return model;
}

void DBAccess::checkParentGoalUpdate(const QString &columnName, int itemId)
{
    if(itemId)
    {
        int progressTracker = getValue("goals", "progressTracker", itemId).toInt();
        int value = 0;
        QString targetColumn = "";
        QSqlQuery query;

        //if
        switch (progressTracker) {
        case 0:
            if(columnName == "targetValue")
                query.prepare("SELECT SUM(targetValue) FROM goals WHERE parentGoalId = :parentGoalId"), targetColumn = "targetValue";
            else if(columnName == "progressValue")
                query.prepare("SELECT SUM(progressValue) FROM goals WHERE parentGoalId = :parentGoalId"), targetColumn = "progressValue";
            else return;
            break;
        case 1:
            if(columnName == "targetValue")
                query.prepare("SELECT COUNT(*) FROM goals WHERE parentGoalId = :parentGoalId"), targetColumn = "targetValue";
            else if(columnName == "progressValue")
                query.prepare("SELECT COUNT(*) FROM goals WHERE (parentGoalId = :parentGoalId, progressValue = targetValue, targetValue != 0)"), targetColumn = "targetValue";
            else return;
            break;
        case 2:
            return;
            break;
        case 3:
            return;
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
            qWarning() << "DBAccess::checkParentGoalUpdate" << query.lastError().text();

        query.first();
        updateValue("goals", targetColumn, itemId, query.value(0).toInt());
    }
}



