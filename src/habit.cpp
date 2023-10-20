#include "habit.h"

Habit::Habit(QObject *parent)
    : QObject{parent}
{

}

int Habit::itemId() const
{
    return m_itemId;
}

void Habit::setItemId(int itemId)
{
    if (itemId != m_itemId)
    {
        m_itemId = itemId;
        emit itemIdChanged();
    }
}

QString Habit::name() const
{
    return m_name;
}

void Habit::setName(const QString &name)
{
    if (name != m_name)
    {
        m_name = name;
        emit nameChanged();
    }
}

QString Habit::category() const
{
    return m_category;
}

void Habit::setCategory(const QString &category)
{
    if (category != m_category)
    {
        m_category = category;
        emit categoryChanged();
    }
}

int Habit::frequency() const
{
    return m_frequency;
}

void Habit::setFrequency(int frequency)
{
    if (frequency != m_frequency)
    {
        m_frequency = frequency;
        emit frequencyChanged();
    }
}

int Habit::targetDays() const
{
    return m_targetDays;
}

void Habit::setTargetDays(int targetDays)
{
    if (targetDays != m_targetDays)
    {
        m_targetDays = targetDays;
        emit targetDaysChanged();
    }
}

QDateTime Habit::startDateTime() const
{
    return m_startDateTime;
}

void Habit::setStartDateTime(const QDateTime &startDateTime)
{
    if (startDateTime != m_startDateTime)
    {
        m_startDateTime = startDateTime;
        emit startDateTimeChanged();
    }
}

QDateTime Habit::endDateTime() const
{
    return m_endDateTime;
}

void Habit::setEndDateTime(const QDateTime &endDateTime)
{
    if (endDateTime != m_endDateTime)
    {
        m_endDateTime = endDateTime;
        emit endDateTimeChanged();
    }
}

int Habit::parentGoalId()
{
    return m_parentGoalId;
}

void Habit::setParentGoalId(int parentGoalId)
{
    if (parentGoalId != m_parentGoalId)
    {
        m_parentGoalId = parentGoalId;
        emit parentGoalIdChanged();
    }
}
