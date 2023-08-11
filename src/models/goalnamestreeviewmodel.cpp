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

//    QStandardItem *value1 = new QStandardItem;
//    QStandardItem *value2 = new QStandardItem;
//    QStandardItem *value3 = new QStandardItem;
//    QStandardItem *value4 = new QStandardItem;
//    QStandardItem *value5 = new QStandardItem;
//    QStandardItem *value6 = new QStandardItem;
//    QStandardItem *value7 = new QStandardItem;
//    QStandardItem *value8 = new QStandardItem;
//    QStandardItem *value9 = new QStandardItem;

    group1->setData("Group 1",GoalName);
    group2->setData("Group 2",GoalName);
    group3->setData("Group 3",GoalName);

    group1->setData(1,ID);
    group2->setData(2,ID);
    group3->setData(3,ID);

//    value1->setText("Value 1");
//    value2->setText("Value 2");
//    value3->setText("Value 3");
//    value4->setText("Value 4");
//    value5->setText("Value 5");
//    value6->setText("Value 6");
//    value7->setText("Value 7");
//    value8->setText("Value 8");
//    value9->setText("Value 9");

//    group1->appendRow(value1);
//    group1->appendRow(value2);
//    group1->appendRow(value3);

//    group2->appendRow(value4);
//    group2->appendRow(value5);
//    group2->appendRow(value6);

//    group3->appendRow(value7);
//    group3->appendRow(value8);
//    group3->appendRow(value9);

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
