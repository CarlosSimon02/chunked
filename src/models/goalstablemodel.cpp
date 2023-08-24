#include "goalstablemodel.h"

#include <QSqlRecord>
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>

GoalsTableModel::GoalsTableModel(QObject *parent)
    : QSqlQueryModel(parent)
{
    select();
}

QHash<int, QByteArray> GoalsTableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < this->record().count(); i ++)
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    return roles;
}

QVariant GoalsTableModel::data(const QModelIndex &index, int role) const
{
    QVariant value;
    if (index.isValid())
    {
        if (role < Qt::UserRole)
            value = QSqlQueryModel::data(index, role);
        else
        {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

void GoalsTableModel::setParentGoalId(int itemId)
{
    if(itemId != m_parentGoalId)
    {
        m_parentGoalId = itemId;
        select();
    }
}

int GoalsTableModel::parentGoalId()
{
    return m_parentGoalId;
}

void GoalsTableModel::select()
{
    QString condition = parentGoalId() ? "parentGoalId = " + QString::number(parentGoalId()) : "parentGoalId IS NULL";
    setQuery("SELECT "
             "itemId, name, imageSource, category, startDateTime, "
             "endDateTime, progressValue, targetValue, progressUnit "
             "FROM goals "
             "WHERE " + condition + ";");

    if (lastError().isValid())
        qWarning() << "GoalsTableModel::select" << lastError().text();
}


