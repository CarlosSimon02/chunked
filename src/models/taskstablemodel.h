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
};

#endif // TASKSTABLEMODEL_H
