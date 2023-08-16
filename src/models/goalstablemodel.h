#ifndef GOALSTABLEMODEL_H
#define GOALSTABLEMODEL_H

#include <QSqlTableModel>
#include <QtQml/qqml.h>
#include <QHash>

class GoalsTableModel : public QSqlTableModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit GoalsTableModel(QObject *parent = nullptr);
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE void refresh();
};

#endif // GOALSTABLEMODEL_H
