#include "goalsdataaccess.h"

GoalsDataAccess::GoalsDataAccess()
{

}

void GoalsDataAccess::loadData(Goal* goal)
{
    QSqlQuery query;
    query.prepare("SELECT name, imageSource, category, startDateTime, "
                  "endDateTime, progressTracker, progressValue, targetValue, "
                  "progressUnit, mission, vision, obstacles, resources, parentGoalId "
                  "FROM goals "
                  "WHERE itemId=:itemId;");
    query.bindValue(":itemId", goal->itemId());
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
        goal->setVision(query.value(10).toString());
        goal->setObstacles(query.value(11).toString());
        goal->setResources(query.value(12).toString());
        goal->setParentGoalId(query.value(13).toInt());
    }
    else
    {
        if (query.lastError().isValid())
            qDebug() << "GoalsDataAccess::loadData" << query.lastError().text();
    }
}

void GoalsDataAccess::saveData(Goal* goal)
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
        qDebug() << "GoalsDataAccess::saveData" << query.lastError().text();
}

QVariant GoalsDataAccess::getData(const QString& tableName, const QString& columnName, int itemId)
{
    QSqlQuery query;
    query.prepare("SELECT " + columnName + " FROM " + tableName + " WHERE itemId=:itemId;");
    query.bindValue(":itemId", itemId);
    query.exec();

    if (query.lastError().isValid())
        qDebug() << "GoalsDataAccess::getData" << query.lastError().text();

    query.next();
    return query.value(0);
}
