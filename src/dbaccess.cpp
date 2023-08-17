#include "dbaccess.h"

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

DBAccess::DBAccess(QObject *parent)
    : QObject{parent}
{
    initDatabase();
}

void DBAccess::initDatabase()
{
    if(!QSqlDatabase::contains(QSqlDatabase::defaultConnection))
    {
        QSqlDatabase db{ QSqlDatabase::addDatabase("QSQLITE") };
        db.setDatabaseName(":memory:");
//        db.setDatabaseName("data.sqlite");

        if(!db.open())
            qDebug() << db.lastError().text();
        if(!checkDBSchema())
            db.close();
    }
}

bool DBAccess::checkDBSchema()
{
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
    {
        qDebug() << "DBAccess::initSchema" << query.lastError().text();
        return false;
    }

    for(int i = 0; i < 10; i++)
    {
        query.exec("INSERT INTO goals (name,imageSource,category,startDateTime,endDateTime,progressTracker,progressValue,targetValue,progressUnit) VALUES ("
                   "'Become a Freaking Software Engineer', 'file:/Users/Carlos Simon/Downloads/643b8d08354c7818786eb7a9_Prompt engineer.png', 'Home', "
                   "'02 Sep 2023 11:59 PM', '02 Sep 2023 11:59 PM',"
                   "0, 70, 100, 'plates');");
    }

    if (query.lastError().isValid())
    {
        qDebug() << query.lastError().text();
        return false;
    }

    return true;
}


