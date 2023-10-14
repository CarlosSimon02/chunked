#ifndef TASK_H
#define TASK_H

#include <QObject>
#include <QtQml/qqml.h>

class Task : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int itemId READ itemId WRITE setItemId NOTIFY itemIdChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool done READ done WRITE setDone NOTIFY doneChanged)
    Q_PROPERTY(QString dateTime READ dateTime WRITE setDateTime NOTIFY dateTimeChanged)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(int outcomes READ outcomes WRITE setOutcomes NOTIFY outcomesChanged)
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit Task(QObject *parent = nullptr);
    int itemId() const;
    void setItemId(int itemId);
    QString name() const;
    void setName(const QString& name);
    bool done() const;
    void setDone(bool done);
    QString dateTime() const;
    void setDateTime(const QString& startDateTime);
    int duration() const;
    void setDuration(int duration);
    int outcomes() const;
    void setOutcomes(int outcomes);
    int parentGoalId() const;
    void setParentGoalId(int parentGoalId);

signals:
    void itemIdChanged();
    void nameChanged();
    void doneChanged();
    void dateTimeChanged();
    void durationChanged();
    void outcomesChanged();
    void parentGoalIdChanged();

private:
    int m_itemId;
    QString m_name;
    bool m_done = false;
    QString m_dateTime;
    int m_duration;
    int m_outcomes = 1;
    int m_parentGoalId = 0;
};

#endif // TASK_H
