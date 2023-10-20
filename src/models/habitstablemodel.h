#ifndef HABITSTABLEMODEL_H
#define HABITSTABLEMODEL_H

#include "basetablemodel.h"

class Habit;

class HabitsTableModel : public BaseTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit HabitsTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void insertRecord(Habit* habit);
};

#endif // HABITSTABLEMODEL_H
