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
    Q_PROPERTY(QString startDateTime READ startDateTime WRITE setStartDateTime NOTIFY startDateTimeChanged)
    Q_PROPERTY(QString endDateTime READ endDateTime WRITE setEndDateTime NOTIFY endDateTimeChanged)
    Q_PROPERTY(int actualDuration READ actualDuration WRITE setActualDuration NOTIFY actualDurationChanged)
    Q_PROPERTY(int outcome READ outcome WRITE setOutcome NOTIFY outcomeChanged)
    Q_PROPERTY(QString notes READ notes WRITE setNotes NOTIFY notesChanged)
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
    QString startDateTime() const;
    void setStartDateTime(const QString& startDateTime);
    QString endDateTime() const;
    void setEndDateTime(const QString& endDateTime);
    int actualDuration() const;
    void setActualDuration(int actualDuration);
    int outcome() const;
    void setOutcome(int outCome);
    QString notes() const;
    void setNotes(const QString& notes);
    int parentGoalId() const;
    void setParentGoalId(int parentGoalId);

signals:
    void itemIdChanged();
    void nameChanged();
    void doneChanged();
    void startDateTimeChanged();
    void endDateTimeChanged();
    void actualDurationChanged();
    void outcomeChanged();
    void notesChanged();
    void parentGoalIdChanged();

private:
    int m_itemId;
    QString m_name;
    bool m_done = false;
    QString m_startDateTime;
    QString m_endDateTime;
    int m_actualDuration;
    int m_outcome = 1;
    QString m_notes;
    int m_parentGoalId = 0;
};

#endif // TASK_H
