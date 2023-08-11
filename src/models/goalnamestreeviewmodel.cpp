#include "goalnamestreeviewmodel.h"
#include <QStandardItem>

GoalNamesTreeViewModel::GoalNamesTreeViewModel(QObject *parent)
    : QStandardItemModel(parent)
{
    setColumnCount(1);
    QStandardItem *rootItem = invisibleRootItem();

    QStandardItem *group1 = new QStandardItem;
    QStandardItem *group2 = new QStandardItem;
    QStandardItem *group3 = new QStandardItem;

    QStandardItem *value1 = new QStandardItem;
    QStandardItem *value2 = new QStandardItem;
    QStandardItem *value3 = new QStandardItem;
    QStandardItem *value4 = new QStandardItem;
    QStandardItem *value5 = new QStandardItem;
    QStandardItem *value6 = new QStandardItem;
    QStandardItem *value7 = new QStandardItem;
    QStandardItem *value8 = new QStandardItem;
    QStandardItem *value9 = new QStandardItem;

    group1->setData("Group 1",GoalName);
    group2->setData("Group 2",GoalName);
    group3->setData("Group 3",GoalName);

    group1->setData(1,ID);
    group2->setData(2,ID);
    group3->setData(3,ID);

    value1->setData("Value 1", GoalName);
    value2->setData("Value 2", GoalName);
    value3->setData("Value 3", GoalName);
    value4->setData("Value 4", GoalName);
    value5->setData("Value 5", GoalName);
    value6->setData("Value 6", GoalName);
    value7->setData("Value 7", GoalName);
    value8->setData("Value 8", GoalName);
    value9->setData("Value 9", GoalName);

    value1->setData("1", ID);
    value2->setData("2", ID);
    value3->setData("3", ID);
    value4->setData("4", ID);
    value5->setData("5", ID);
    value6->setData("6", ID);
    value7->setData("7", ID);
    value8->setData("8", ID);
    value9->setData("9", ID);

    group1->appendRow(value1);
    group1->appendRow(value2);
    group1->appendRow(value3);

    group2->appendRow(value4);
    group2->appendRow(value5);
    group2->appendRow(value6);

    group3->appendRow(value7);
    group3->appendRow(value8);
    group3->appendRow(value9);

    rootItem->appendRow(group1);
    rootItem->appendRow(group2);
    rootItem->appendRow(group3);
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
