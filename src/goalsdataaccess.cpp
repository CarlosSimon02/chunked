#include "goalsdataaccess.h"
#include "goal.h"

#include <QSqlQuery>
#include <QSqlError>

GoalsDataAccess::GoalsDataAccess(QObject *parent)
    : DBAccess{parent}
{
}

Goal* GoalsDataAccess::load(int itemId)
{
    QSqlQuery query;
    query.prepare("SELECT name, imageSource, category, startDateTime, "
                  "endDateTime, progressTracker, progressValue, targetValue, "
                  "progressUnit, mission, vision, obstacles, resources, parentGoalId "
                  "FROM goals "
                  "WHERE itemId = :itemId;");
    query.bindValue(":itemId", itemId);
    query.exec();
    query.first();

    if (query.lastError().isValid())
        qDebug() << "GoalsDataAccess::load" << query.lastError().text();

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

void GoalsDataAccess::save(Goal* goal)
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
        qDebug() << "GoalsDataAccess::save" << query.lastError().text();
}

QVariant GoalsDataAccess::get(const QString& columnName, int itemId)
{
    QSqlQuery query;
    query.prepare("SELECT " + columnName + " FROM goals WHERE itemId = :itemId;");
    query.bindValue(":itemId", itemId);
    query.exec();

    if(query.lastError().isValid())
        qDebug() << "GoalsDataAccess::get" << query.lastError().text();

    query.next();
    return query.value(0);
}

void GoalsDataAccess::update(const QString &columnName, int itemId, const QVariant &value)
{
    QSqlQuery query;
    if(itemId)
    {
        query.prepare("UPDATE goals SET :columnName = :value WHERE itemId = :itemId");
        query.bindValue(":itemId", itemId);
    }
    else
        query.prepare("UPDATE goals SET :columnName = :value WHERE itemId IS NULL");
    query.bindValue(":columnName", columnName);
    query.bindValue(":value",value);
    query.exec();

    if(query.lastError().isValid())
        qDebug() << "GoalsDataAccess::update" << query.lastError().text();

    parentUpdate(columnName, itemId);
}

GoalsTableModel *GoalsDataAccess::createGoalsTableModel(int parentGoalId)
{
    GoalsTableModel* model = new GoalsTableModel;
    model->setTable("goals");

    if(parentGoalId)
        model->setFilter("parentGoalId = "+QString::number(parentGoalId));
    else
        model->setFilter("parentGoalId IS NULL");

    model->select();

    if (model->lastError().isValid())
        qDebug() << "GoalsDataAccess::createGoalsTableModel " << model->lastError().text();

    return model;
}
