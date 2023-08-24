#ifndef TASK_H
#define TASK_H

#include <QObject>
#include <QtQml/qqml.h>

class Task : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int itemId READ itemId WRITE setItemId NOTIFY itemIdChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool done READ done WRITE done NOTIFY doneChanged)
    Q_PROPERTY(QString startDateTime READ startDateTime WRITE setStartDateTime NOTIFY startDateTimeChanged)
    Q_PROPERTY(QString endDateTime READ endDateTime WRITE setEndDateTime NOTIFY endDateTimeChanged)
    Q_PROPERTY(int actualDuration READ actualDuration WRITE setActualDuration NOTIFY actualDurationChanged)
    Q_PROPERTY(int outcome READ outcome WRITE setOutcome NOTIFY outcomeChanged)
    Q_PROPERTY(QString notes READ notes WRITE setNotes NOTIFY notesChanged)
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit Task(QObject *parent = nullptr);

signals:
    void itemIdChanged();
    void nameChanged();
    void doneChanged();
    void startDateTimeChanged();
    void endDateTimeChanged();
    void actualDurationChanged();
    void outcomeChanged();
    void parentGoalIdChanged();
    void notesChanged();
    void parentGoalIdChanged();

private:
    int m_itemId;
    QString m_name;
    bool m_done;
    QString m_startDateTime;
    QString m_endDateTime;
    int m_actualDuration;
    int m_outcome;
    int m_parentGoalId;
    QString m_notes;
    int parentGoalId;
};

#endif // TASK_H
