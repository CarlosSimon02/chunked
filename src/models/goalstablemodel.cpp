#include "goalstablemodel.h"

#include <QSqlRecord>
#include <QDebug>
#include <QSqlError>

GoalsTableModel::GoalsTableModel(QObject *parent, int parentGoalId)
    : QSqlTableModel(parent)
{
    setTable("goals");

    if(parentGoalId != 0)
        setFilter("parentGoalId="+parentGoalId);
    else
        setFilter("parentGoalId IS NULL");

    select();

//    if (lastError().isValid())
//        qDebug() << "GoalsDataAccess::createGoalsTableModel" << lastError().text;
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



