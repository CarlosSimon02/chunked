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

QString Task::dateTime() const
{
    return m_dateTime;
}

void Task::setDateTime(const QString &dateTime)
{
    if (dateTime != m_dateTime)
    {
        m_dateTime = dateTime;
        emit dateTimeChanged();
    }
}

int Task::duration() const
{
    return m_duration;
}

void Task::setDuration(int duration)
{
    if (duration != m_duration)
    {
        m_duration = duration;
        emit durationChanged();
    }
}

int Task::outcomes() const
{
    return m_outcomes;
}

void Task::setOutcomes(int outcomes)
{
    if (outcomes != m_outcomes)
    {
        m_outcomes = outcomes;
        emit outcomesChanged();
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
