#include "basetablemodel.h"

#include <QSqlRecord>

BaseTableModel::BaseTableModel(QObject *parent)
    : QSqlQueryModel{parent}
{

}

QHash<int, QByteArray> BaseTableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    for (int i = 0; i < this->record().count(); i ++)
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    return roles;
}

QVariant BaseTableModel::data(const QModelIndex &index, int role) const
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

void BaseTableModel::setParentGoalId(int itemId)
{
    if(itemId != m_parentGoalId)
    {
        m_parentGoalId = itemId;
        select();
    }
}

int BaseTableModel::parentGoalId()
{
    return m_parentGoalId;
}
