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
    firstItem->setData("None(Top Level Goal)", GoalName);
    firstItem->setData(0, ID);
    invisibleRootItem()->appendRow(firstItem);
    setChildrenOfItem(invisibleRootItem());
}

QHash<int, QByteArray> GoalNamesTreeViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(GoalName,"goalName");
    roles.insert(ID,"id");
    roles.insert(ProgressTracker,"progressTracker");
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
    case ProgressTracker:
        return item->data(ProgressTracker);
    default:
        return QStandardItemModel::data(index, role);
    }
}

void GoalNamesTreeViewModel::setChildrenOfItem(QStandardItem *item)
{
    QSqlQuery query;
    if(item == invisibleRootItem())
        query.prepare("SELECT name,itemId,progressTracker FROM goals WHERE parentGoalId IS NULL;");
    else
    {
        query.prepare("SELECT name,itemId,progressTracker FROM goals WHERE parentGoalId=:parentGoalId;");
        query.bindValue(":parentGoalId", item->data(ID));
    }

    query.exec();

    if (query.lastError().isValid())
    {
        qDebug() << "GoalNamesTreeViewModel::setChildrenOfItem" << query.lastError().text();
        return;
    }

    while(query.next())
    {
        QStandardItem* childItem = new QStandardItem;
        childItem->setData(query.value(0), GoalName);
        childItem->setData(query.value(1),ID);
        childItem->setData(query.value(2),ProgressTracker);
        setChildrenOfItem(childItem);
        item->appendRow(childItem);
    }
}
