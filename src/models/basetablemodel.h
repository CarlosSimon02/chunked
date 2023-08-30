#ifndef BASETABLEMODEL_H
#define BASETABLEMODEL_H

#include <QSqlTableModel>
#include <QtQml/qqml.h>

class BaseTableModel : public QSqlTableModel
{
    Q_OBJECT

public:
    explicit BaseTableModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index,
                  int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index,
                 const QVariant &value,
                 int role = Qt::EditRole) override;
    void setParentGoalId(int parentGoalId);
    int parentGoalId();
    Q_INVOKABLE void refresh();

private:
    int m_parentGoalId = 0;
};

#endif // BASETABLEMODEL_H
