#ifndef GOALSTABLEMODEL_H
#define GOALSTABLEMODEL_H

#include <QtQml/qqml.h>
#include <models/basetablemodel.h>

class GoalsTableModel : public BaseTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit GoalsTableModel(QObject *parent = nullptr);
};

#endif // GOALSTABLEMODEL_H
