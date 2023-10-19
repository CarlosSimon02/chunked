#ifndef PROGRESS_H
#define PROGRESS_H

#include <QObject>
#include <QtQml/qqml.h>

class Progress : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(int target READ target WRITE setTarget NOTIFY targetChanged)
    Q_PROPERTY(int parentId READ parentId WRITE setParentId NOTIFY parentIdChanged)
    QML_ELEMENT

public:
    explicit Progress(QObject *parent = nullptr);

    int value();
    void setValue(int value);
    int target();
    void setTarget(int target);
    int parentId();
    void setParentId(int parentId);

signals:
    void valueChanged();
    void targetChanged();
    void parentIdChanged();

private:
    int m_value = 0;
    int m_target = 0;
    int m_parentId = 0;
};

#endif // PROGRESS_H
