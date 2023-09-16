#include "basetablemodel.h"

#include <QSqlRecord>
#include <QSqlError>
#include <QDebug>

BaseTableModel::BaseTableModel(QObject *parent)
    : QSqlTableModel{parent}
{
    setEditStrategy(EditStrategy::OnFieldChange);
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
            value = QSqlTableModel::data(index, role);
        else
        {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlTableModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;
}

QVariant BaseTableModel::data(const QString &fieldName, int row)
{
    int col = record().indexOf(fieldName);

    if(col == -1)
    {
        qWarning() << "BaseTableModel::data: field name not found";
        return QVariant{};
    }

    return data(index(row,col));
}

bool BaseTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (index.isValid())
    {
        if(role == Qt::EditRole)
        {
            QSqlTableModel::setData(index, value, Qt::EditRole);
            return true;
        }
        else
        {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            if (QSqlTableModel::setData(modelIndex, value, Qt::EditRole))
                return true;
            else {
                qWarning() << "setData return false";
                return false;
            }
        }
    }

    return false;
}

bool BaseTableModel::setData(const QString &fieldName, int row, const QVariant &value)
{
    int col = record().indexOf(fieldName);

    if(col == -1)
    {
        qWarning() << "BaseTableModel::setData: field name not found";
        return false;
    }

    return setData(index(row,col), value);
}

int BaseTableModel::parentGoalId()
{
    return m_parentGoalId;
}

void BaseTableModel::setParentGoalId(int parentGoalId)
{
    if(parentGoalId != m_parentGoalId)
    {
        m_parentGoalId = parentGoalId;
        if(m_parentGoalId) setFilter("parentGoalId = " + QString::number(m_parentGoalId));
        else setFilter("parentGoalId IS NULL");
        select();
        emit parentGoalIdChanged();
    }
}

void BaseTableModel::refresh()
{
    select();
}

bool BaseTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    emit beginRemoveRows(parent,row,row+count-1);
    bool result = QSqlTableModel::removeRows(row,row+count-1,parent);
    emit endRemoveRows();
    return result;
}

