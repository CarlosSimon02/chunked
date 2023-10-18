#ifndef HABITSTABLEMODEL_H
#define HABITSTABLEMODEL_H

#include "basetablemodel.h"

class HabitsTableModel : public BaseTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit HabitsTableModel(QObject *parent = nullptr);
};

#endif // HABITSTABLEMODEL_H
