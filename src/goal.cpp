#include "goal.h"

Goal::Goal(QObject *parent)
    : QObject{parent}
{
}

int Goal::id() const
{
    return m_id;
}

void Goal::setId(int id)
{
    if (id != m_id)
    {
        m_id = id;
        emit idChanged();
    }
}

QString Goal::name() const
{
    return m_name;
}

void Goal::setName(const QString &name)
{
    if (name != m_name)
    {
        m_name = name;
        emit nameChanged();
    }
}

QString Goal::imageSource() const
{
    return m_imageSource;
}

void Goal::setImageSource(const QString &imageSource)
{
    if (imageSource != m_imageSource)
    {
        m_imageSource = imageSource;
        emit imageSourceChanged();
    }
}

QString Goal::category() const
{
    return m_category;
}

void Goal::setCategory(const QString &category)
{
    if (category != m_category)
    {
        m_category = category;
        emit categoryChanged();
    }
}

QString Goal::startDateTime() const
{
    return m_startDateTime;
}

void Goal::setStartDateTime(const QString &startDateTime)
{
    if (startDateTime != m_startDateTime)
    {
        m_startDateTime = startDateTime;
        emit startDateTimeChanged();
    }
}

QString Goal::endDateTime() const
{
    return m_endDateTime;
}

void Goal::setEndDateTime(const QString &endDateTime)
{
    if (endDateTime != m_endDateTime)
    {
        m_endDateTime = endDateTime;
        emit endDateTimeChanged();
    }
}

QString Goal::progressTracker() const
{
    return m_progressTracker;
}

void Goal::setProgressTracker(const QString &progressTracker)
{
    if (progressTracker != m_progressTracker)
    {
        m_progressTracker = progressTracker;
        emit progressTrackerChanged();
    }
}

int Goal::progressValue() const
{
    return m_progressValue;
}

void Goal::setProgressValue(int progressValue)
{
    if (progressValue != m_progressValue)
    {
        m_progressValue = progressValue;
        emit progressValueChanged();
    }
}

int Goal::targetValue() const
{
    return m_targetValue;
}

void Goal::setTargetValue(int targetValue)
{
    if (targetValue != m_targetValue)
    {
        m_targetValue = targetValue;
        emit targetValueChanged();
    }
}

QString Goal::progressUnit() const
{
    return m_progressUnit;
}

void Goal::setProgressUnit(const QString &progressUnit)
{
    if (progressUnit != m_progressUnit)
    {
        m_progressUnit = progressUnit;
        emit progressUnitChanged();
    }
}

QString Goal::mission() const
{
    return m_mission;
}

void Goal::setMission(const QString &mission)
{
    if (mission != m_mission)
    {
        m_mission = mission;
        emit missionChanged();
    }
}

QString Goal::vision() const
{
    return m_vision;
}

void Goal::setVision(const QString &vision)
{
    if (vision != m_vision)
    {
        m_vision = vision;
        emit visionChanged();
    }
}

QString Goal::obstacles() const
{
    return m_obstacles;
}

void Goal::setObstacles(const QString &obstacles)
{
    if (obstacles != m_obstacles)
    {
        m_obstacles = obstacles;
        emit obstaclesChanged();
    }
}

QString Goal::resources() const
{
    return m_resources;
}

void Goal::setResources(const QString &resources)
{
    if (resources != m_resources)
    {
        m_resources = resources;
        emit resourcesChanged();
    }
}

int Goal::parentGoal() const
{
    return m_parentGoal;
}

void Goal::setParentGoal(int parentGoal)
{
    if (parentGoal != m_parentGoal)
    {
        m_parentGoal = parentGoal;
        emit parentGoalChanged();
    }
}
