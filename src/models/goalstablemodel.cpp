#include "goalstablemodel.h"

#include <QSqlRecord>
#include <QDebug>

GoalsTableModel::GoalsTableModel(QObject *parent)
    : QSqlTableModel(parent)
{
    setTable("goals");
    setFilter("parentGoal IS NULL");
    setEditStrategy(QSqlTableModel::OnFieldChange);
    select();
}

QHash<int, QByteArray> GoalsTableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for(int i = 0; i < columnCount(); i++)
    {
        roles.insert(Qt::UserRole + i,record().fieldName(i).toUtf8());
    }
    return roles;
}

QVariant GoalsTableModel::data(const QModelIndex &index, int role) const
{
    if(index.row() >= rowCount()) {
        return QString("");
    }
    if(role < Qt::UserRole) {
        return QSqlTableModel::data(index, role);
    }
    else {
        return QSqlTableModel::data(this->index(index.row(), role - Qt::UserRole), Qt::DisplayRole);
    }
}

void GoalsTableModel::refresh()
{
    select();
}

int GoalsTableModel::parentGoal() const
{
    return m_parentGoal;
}

void GoalsTableModel::setParentGoal(int parentGoal)
{
    if (parentGoal != m_parentGoal)
    {
        m_parentGoal = parentGoal;
        setFilter("parentGoal="+QString::number(parentGoal));
        emit parentGoalChanged();
    }
}




