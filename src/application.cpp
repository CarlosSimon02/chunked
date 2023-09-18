#include "application.h"

#include <QFontDatabase>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QQmlContext>

#include "goal.h"
#include "dbaccess.h"
#include "models/goalstablemodel.h"

Application::Application(int &argc, char *argv[], int flags)
    : QGuiApplication{ argc, argv, flags },
    m_engine{new QQmlApplicationEngine}
{
    loadFonts();
    DBAccess* dbAccess = new DBAccess;
    m_engine->rootContext()->setContextProperty("dbAccess",dbAccess);
    m_engine->addImportPath("qrc:/");
    const QUrl url(u"qrc:/Main.qml"_qs);
    m_engine->load(url);
}

QQmlApplicationEngine* Application::engine() const
{
    return m_engine.get();
}

void Application::loadFonts()
{
    QFontDatabase::addApplicationFont(":/Poppins-Black.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-BlackItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-Bold.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-BoldItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-ExtraBold.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-ExtraBoldItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-ExtraLight.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-ExtraLightItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-Italic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-Light.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-LightItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-Medium.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-MediumItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-Regular.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-SemiBold.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-SemiBoldItalic.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-Thin.ttf");
    QFontDatabase::addApplicationFont(":/Poppins-ThinItalic.ttf");
}



