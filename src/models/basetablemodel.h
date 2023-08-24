#ifndef BASETABLEMODEL_H
#define BASETABLEMODEL_H

#include <QSqlQueryModel>
#include <QtQml/qqml.h>

class BaseTableModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit BaseTableModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    void setParentGoalId(int itemId);
    int parentGoalId();
    virtual void select() = 0;

private:
    int m_parentGoalId = 0;
};

#endif // BASETABLEMODEL_H
