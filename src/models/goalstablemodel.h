#ifndef GOALSTABLEMODEL_H
#define GOALSTABLEMODEL_H

#include <QSqlQueryModel>
#include <QtQml/qqml.h>
#include <QHash>

class GoalsTableModel : public QSqlQueryModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit GoalsTableModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    void setParentGoalId(int itemId);
    int parentGoalId();
    Q_INVOKABLE void select();

private:
    int m_parentGoalId = 0;
};

#endif // GOALSTABLEMODEL_H
