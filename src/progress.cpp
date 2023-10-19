#include "progress.h"

Progress::Progress(QObject *parent)
    : QObject{parent}
{

}

int Progress::value()
{
    return m_value;
}

void Progress::setValue(int value)
{
    if (value != m_value)
    {
        m_value = value;
        emit valueChanged();
    }
}

int Progress::target()
{
    return m_target;
}

void Progress::setTarget(int target)
{
    if (target != m_target)
    {
        m_target = target;
        emit targetChanged();
    }
}

int Progress::parentId()
{
    return m_parentId;
}

void Progress::setParentId(int parentId)
{
    if (parentId != m_parentId)
    {
        m_parentId = parentId;
        emit parentIdChanged();
    }
}
