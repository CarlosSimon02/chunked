#ifndef TASKSTABLEMODEL_H
#define TASKSTABLEMODEL_H

#include <QQmlEngine>
#include "models/basetablemodel.h"

class TasksTableModel : public BaseTableModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit TasksTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void select() override;
};

#endif // TASKSTABLEMODEL_H
