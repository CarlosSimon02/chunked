#ifndef GOALSDATAACCESS_H
#define GOALSDATAACCESS_H

#include <QObject>
#include <QQmlEngine>

#include "dbaccess.h"
#include "models/goalstablemodel.h"

class Goal;

class GoalsDataAccess : public DBAccess
{
    Q_OBJECT
    QML_ELEMENT

public:
    GoalsDataAccess(QObject *parent = nullptr);
    Q_INVOKABLE Goal* load(int itemId);
    Q_INVOKABLE void save(Goal* goal);
    Q_INVOKABLE QVariant get(const QString& columnName, int itemId);
    Q_INVOKABLE GoalsTableModel* createGoalsTableModel(int parentGoalId = 0);
};

#endif // GOALSDATAACCESS_H
