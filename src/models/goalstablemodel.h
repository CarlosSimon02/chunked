#ifndef GOALSTABLEMODEL_H
#define GOALSTABLEMODEL_H

#include <QSqlTableModel>
#include <QtQml/qqml.h>
#include <QHash>

class GoalsTableModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoal NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit GoalsTableModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void refresh();

    int parentGoalId() const;
    void setParentGoal(int parentGoalId);

signals:
    void parentGoalIdChanged();

private:
    int m_parentGoalId;
};

#endif // GOALSTABLEMODEL_H
