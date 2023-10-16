#ifndef TASKSTABLEMODEL_H
#define TASKSTABLEMODEL_H

#include <QQmlEngine>
#include "models/basetablemodel.h"

class Task;

class TasksTableModel : public BaseTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    Q_PROPERTY(QString filterDate READ filterDate WRITE setFilterDate NOTIFY filterDateChanged)
    Q_PROPERTY(int filterStatus READ filterStatus WRITE setFilterStatus NOTIFY filterStatusChanged)
    QML_ELEMENT

public:
    explicit TasksTableModel(QObject *parent = nullptr);
    Q_INVOKABLE void insertRecord(Task* task);

    QString filterDate();
    void setFilterDate(QString filterDate);
    int filterStatus();
    void setFilterStatus(int filterStatus);

signals:
    void filterDateChanged();
    void filterStatusChanged();

private:
    QString m_filterDate;
    int m_filterStatus;
};

#endif // TASKSTABLEMODEL_H
