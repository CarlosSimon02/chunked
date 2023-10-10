#ifndef GOALNAMESTREEVIEWMODEL_H
#define GOALNAMESTREEVIEWMODEL_H

#include <QStandardItemModel>
#include <QtQml/qqml.h>

class GoalNamesTreeViewModel : public QStandardItemModel
{
    Q_OBJECT
    QML_ELEMENT

    enum Roles {
        GoalName = Qt::UserRole + 1,
        ID,
        ProgressTracker
    };

public:
    explicit GoalNamesTreeViewModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    void setChildrenOfItem(QStandardItem* item);

};

#endif // GOALNAMESTREEVIEWMODEL_H
