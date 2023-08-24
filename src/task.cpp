#include "task.h"

Task::Task(QObject *parent)
    : QObject{parent}
{

}

int Task::itemId() const
{
    return m_itemId;
}

void Task::setItemId(int itemId)
{
    if (itemId != m_itemId)
    {
        m_itemId = itemId;
        emit itemIdChanged();
    }
}

QString Task::name() const
{
    return m_name;
}

void Task::setName(const QString &name)
{
    if (name != m_name)
    {
        m_name = name;
        emit nameChanged();
    }
}

bool Task::done() const
{
    return m_done;
}

void Task::setDone(bool done)
{
    if (done != m_done)
    {
        m_done = done;
        emit doneChanged();
    }
}

QString Task::startDateTime() const
{
    return m_startDateTime;
}

void Task::setStartDateTime(const QString &startDateTime)
{
    if (startDateTime != m_startDateTime)
    {
        m_startDateTime = startDateTime;
        emit startDateTimeChanged();
    }
}

QString Task::endDateTime() const
{
    return m_endDateTime;
}

void Task::setEndDateTime(const QString &endDateTime)
{
    if (endDateTime != m_endDateTime)
    {
        m_endDateTime = endDateTime;
        emit endDateTimeChanged();
    }
}

int Task::actualDuration() const
{
    return m_actualDuration;
}

void Task::setActualDuration(int actualDuration)
{
    if (actualDuration != m_actualDuration)
    {
        m_actualDuration = actualDuration;
        emit actualDurationChanged();
    }
}

int Task::outcome() const
{
    return m_outcome;
}

void Task::setOutcome(int outcome)
{
    if (outcome != m_outcome)
    {
        m_outcome = outcome;
        emit outcomeChanged();
    }
}

QString Task::notes() const
{
    return m_notes;
}

void Task::setNotes(const QString &notes)
{
    if (notes != m_notes)
    {
        m_notes = notes;
        emit notesChanged();
    }
}

int Task::parentGoalId() const
{
    return m_parentGoalId;
}

void Task::setParentGoalId(int parentGoalId)
{
    if (parentGoalId != m_parentGoalId)
    {
        m_parentGoalId = parentGoalId;
        emit parentGoalIdChanged();
    }
}
