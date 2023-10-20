#ifndef HABIT_H
#define HABIT_H

#include <QObject>
#include <QtQml/qqml.h>

class habit : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int itemId READ itemId WRITE setItemId NOTIFY itemIdChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString imageSource READ imageSource WRITE setImageSource NOTIFY imageSourceChanged)
    Q_PROPERTY(QString category READ category WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(QDateTime startDateTime READ startDateTime WRITE setStartDateTime NOTIFY startDateTimeChanged)
    Q_PROPERTY(QDateTime endDateTime READ endDateTime WRITE setEndDateTime NOTIFY endDateTimeChanged)
    Q_PROPERTY(int progressTracker READ progressTracker WRITE setProgressTracker NOTIFY progressTrackerChanged)
    Q_PROPERTY(QString progressUnit READ progressUnit WRITE setProgressUnit NOTIFY progressUnitChanged)
    Q_PROPERTY(QString mission READ mission WRITE setMission NOTIFY missionChanged)
    Q_PROPERTY(QString vision READ vision WRITE setVision NOTIFY visionChanged)
    Q_PROPERTY(QString obstacles READ obstacles WRITE setObstacles NOTIFY obstaclesChanged)
    Q_PROPERTY(QString resources READ resources WRITE setResources NOTIFY resourcesChanged)
    Q_PROPERTY(int parentGoalId READ parentGoalId WRITE setParentGoalId NOTIFY parentGoalIdChanged)
    QML_ELEMENT

public:
    explicit habit(QObject *parent = nullptr);

signals:

};

#endif // HABIT_H
