#ifndef APPLICATION_H
#define APPLICATION_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>

class Application: public QGuiApplication
{
    Q_OBJECT
public:
    Application(int &argc, char **argv, int flags = ApplicationFlags);
    std::unique_ptr<QQmlApplicationEngine> engine() const;

private:
    void loadFonts();

private:
    std::unique_ptr<QQmlApplicationEngine> m_engine;
};

#endif // APPLICATION_H
