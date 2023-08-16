#ifndef DBACCESS_H
#define DBACCESS_H

#include <QObject>
#include <QtQml/qqml.h>

class DBAccess : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit DBAccess(QObject *parent = nullptr);

private:
    void initDatabase();
    bool checkDBSchema();

signals:

};

#endif // DBACCESS_H
