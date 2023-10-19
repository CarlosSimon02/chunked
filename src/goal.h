#ifndef GOAL_H
#define GOAL_H

#include <QObject>
#include <QDateTime>
#include <QtQml/qqml.h>

class Goal : public QObject
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
    explicit Goal(QObject *parent = nullptr);
    int itemId() const;
    void setItemId(int itemId);
    QString name() const;
    void setName(const QString& name);
    QString imageSource() const;
    void setImageSource(const QString& imageSource);
    QString category() const;
    void setCategory(const QString& category);
    QDateTime startDateTime() const;
    void setStartDateTime(const QDateTime& startDateTime);
    QDateTime endDateTime() const;
    void setEndDateTime(const QDateTime& endDateTime);
    int progressTracker() const;
    void setProgressTracker(int progressTracker);
    QString progressUnit() const;
    void setProgressUnit(const QString& progressUnit);
    QString mission() const;
    void setMission(const QString& mission);
    QString vision() const;
    void setVision(const QString& vision);
    QString obstacles() const;
    void setObstacles(const QString& obstacles);
    QString resources() const;
    void setResources(const QString& resources);
    int parentGoalId() const;
    void setParentGoalId(int parentGoalId);

signals:
    void itemIdChanged();
    void nameChanged();
    void imageSourceChanged();
    void categoryChanged();
    void startDateTimeChanged();
    void endDateTimeChanged();
    void progressTrackerChanged();
    void progressUnitChanged();
    void missionChanged();
    void visionChanged();
    void obstaclesChanged();
    void resourcesChanged();
    void parentGoalIdChanged();

private:
    int m_itemId;
    QString m_name;
    QString m_imageSource;
    QString m_category;
    QDateTime m_startDateTime;
    QDateTime m_endDateTime;
    int m_progressTracker;
    QString m_progressUnit;
    QString m_mission;
    QString m_vision;
    QString m_obstacles;
    QString m_resources;
    int m_parentGoalId;
};

#endif // GOAL_H
