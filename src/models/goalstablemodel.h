#ifndef GOALSTABLEMODEL_H
#define GOALSTABLEMODEL_H

#include <QtQml/qqml.h>
#include <models/basetablemodel.h>

class Goal;

class GoalsTableModel : public BaseTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit GoalsTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void insertRecord(Goal* goal);
};

#endif // GOALSTABLEMODEL_H
