#ifndef HABIT_H
#define HABIT_H

#include <QObject>
#include <QDateTime>
#include <QtQml/qqml.h>

class Habit : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int itemId READ itemId WRITE setItemId NOTIFY itemIdChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(int frequency READ frequency WRITE setFrequency NOTIFY frequencyChanged)
    Q_PROPERTY(QDateTime startDateTime READ startDateTime WRITE setStartDateTime NOTIFY startDateTimeChanged)
    Q_PROPERTY(QDateTime endDateTime READ endDateTime WRITE setEndDateTime NOTIFY endDateTimeChanged)
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit Habit(QObject *parent = nullptr);

    int itemId() const;
    void setItemId(int itemId);
    QString name() const;
    void setName(const QString& name);
    QString category() const;
    void setCategory(const QString& category);
    int frequency() const;
    void setFrequency(int frequency);
    QDateTime startDateTime() const;
    void setStartDateTime(const QDateTime& startDateTime);
    QDateTime endDateTime() const;
    void setEndDateTime(const QDateTime& endDateTime);
    int parentGoalId();
    void setParentGoalId(int parentGoalId);

signals:
    void itemIdChanged();
    void nameChanged();
    void categoryChanged();
    void frequencyChanged();
    void startDateTimeChanged();
    void endDateTimeChanged();
    void parentGoalIdChanged();

private:
    int m_itemId;
    QString m_name;
    QString m_category;
    int m_frequency;
    QDateTime m_startDateTime;
    QDateTime m_endDateTime;
    int m_parentGoalId;
};

#endif // HABIT_H
