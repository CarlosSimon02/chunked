#include "goalnamestreeviewmodel.h"
#include <QStandardItem>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

GoalNamesTreeViewModel::GoalNamesTreeViewModel(QObject *parent)
    : QStandardItemModel(parent)
{
    setColumnCount(1);
    QStandardItem* firstItem = new QStandardItem;
    firstItem->setData("None(Top Level Goal", GoalName);
    firstItem->setData(0, ID);
    invisibleRootItem()->appendRow(firstItem);
    setChildrenOfItem(invisibleRootItem());
}

QHash<int, QByteArray> GoalNamesTreeViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(GoalName,"goalName");
    roles.insert(ID,"id");
    return roles;
}

QVariant GoalNamesTreeViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    QStandardItem *item = itemFromIndex(index);

    switch (role) {
    case GoalName:
        return item->data(GoalName);
    case ID:
        return item->data(ID);
    default:
        return QStandardItemModel::data(index, role);
    }
}

void GoalNamesTreeViewModel::setChildrenOfItem(QStandardItem *item)
{
    QVariant parentGoalId = item == invisibleRootItem() ? QVariant(QMetaType::fromType<int>()) : item->data(ID);

    QSqlQuery query;
    query.prepare("SELECT name,id FROM goals WHERE parentGoalId=:parentGoalId");
    query.bindValue(":parentGoalId",parentGoalId);

    if (query.lastError().isValid())
    {
        qDebug() << query.lastError().text();
        return;
    }

    while(query.next())
    {
        QStandardItem* childItem = new QStandardItem;
        childItem->setData(query.value(0), GoalName);
        childItem->setData(query.value(1),ID);
        item->appendRow(item);
        setChildrenOfItem(childItem);
    }
}
