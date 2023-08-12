#include "dbaccess.h"

#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

DBAccess::DBAccess(QObject *parent)
    : QObject{parent}
{
    initSchema();
}

void DBAccess::initSchema()
{
    QSqlDatabase db{ QSqlDatabase::addDatabase("QSQLITE") };
    db.setDatabaseName(":memory:");
    if(!db.open()) qDebug() << db.lastError().text();

    QSqlQuery query;

    query.exec("CREATE TABLE IF NOT EXISTS goals ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
               "name TEXT, "
               "imageSource TEXT,"
               "category TEXT, "
               "startDateTime VARCHAR(20), "
               "endDateTime VARCHAR(20), "
               "progressTracker TEXT, "
               "progressValue INTEGER, "
               "targetValue INTEGER, "
               "progressUnit VARCHAR(20),"
               "mission TEXT, "
               "vision TEXT, "
               "obstacles TEXT, "
               "resources TEXT, "
               "parentGoalId INTEGER,"
               "FOREIGN KEY(parentGoalId) REFERENCES goals(id)"
               ");");

    if (query.lastError().isValid())
        qDebug() << query.lastError().text();

//    for(int i = 0; i < 10; i++)
//    {
//        query.exec("INSERT INTO goals (name,imageSource,category,startDateTime,endDateTime,progressTracker,progressValue,targetValue,progressUnit) VALUES ("
//                   "'Become a Freaking Software Engineer', 'file:/Users/Carlos Simon/Downloads/643b8d08354c7818786eb7a9_Prompt engineer.png', 'Home', "
//                   "'02 Sep 2023 11:59 PM', '02 Sep 2023 11:59 PM',"
//                   "'Progress tracker', 70, 100, 'plates');");
//    }


    if (query.lastError().isValid())
        qDebug() << query.lastError().text();
}

void DBAccess::loadData(Goal* goal)
{
    QSqlQuery query;
    query.prepare("SELECT name, imageSource, category, startDateTime, "
                         "endDateTime, progressTracker, progressValue, targetValue, "
                         "progressUnit, mission, vision, obstacles, resources, parentGoalId "
                  "FROM goals "
                  "WHERE id=:id;");
    query.bindValue(":id", goal->id());
    query.exec();

    if(query.isActive() && query.isSelect())
    {
        query.first();
        goal->setName(query.value(0).toString());
        goal->setImageSource(query.value(1).toString());
        goal->setCategory(query.value(2).toString());
        goal->setStartDateTime(query.value(3).toString());
        goal->setEndDateTime(query.value(4).toString());
        goal->setProgressTracker(query.value(5).toString());
        goal->setProgressValue(query.value(6).toInt());
        goal->setTargetValue(query.value(7).toInt());
        goal->setProgressUnit(query.value(8).toString());
        goal->setMission(query.value(9).toString());
        goal->setObstacles(query.value(10).toString());
        goal->setResources(query.value(11).toString());
        goal->setParentGoal(query.value(12).toInt());
    }
    else
    {
        if (query.lastError().isValid())
            qDebug() << query.lastError().text();
    }
}

void DBAccess::saveData(Goal* goal)
{
    QSqlQuery query;
    query.prepare("INSERT INTO goals "
                  "(name) "
                  "VALUES "
                  "(:name);");
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
        qDebug() << query.lastError().text();
}
