#ifndef BASETABLEMODEL_H
#define BASETABLEMODEL_H

#include <QSqlTableModel>
#include <QtQml/qqml.h>

class BaseTableModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit BaseTableModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QVariant data(const QModelIndex &index,
                              int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QVariant data(const QString& fieldName, int row);

    Q_INVOKABLE bool setData(const QModelIndex &index,
                             const QVariant &value,
                             int role = Qt::EditRole) override;
    Q_INVOKABLE bool setData(const QString& fieldName,
                             int row,
                             const QVariant &value);

    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;

    int parentGoalId();
    void setParentGoalId(int parentGoalId);

signals:
    parentGoalIdChanged();

private:
    int m_parentGoalId = 0;
};

#endif // BASETABLEMODEL_H
