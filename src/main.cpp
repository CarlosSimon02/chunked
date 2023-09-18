//#include <QGuiApplication>
//#include <QtQml>
//#include <FramelessHelper/Quick/framelessquickmodule.h>
//#include <FramelessHelper/Core/private/framelessconfig_p.h>
//#include "application.h"

//FRAMELESSHELPER_REQUIRE_CONFIG(window)
//FRAMELESSHELPER_USE_NAMESPACE

//int main(int argc, char *argv[])
//{
//    FramelessHelper::Quick::initialize();
//    Application app(argc, argv);
//    FramelessHelper::Core::setApplicationOSThemeAware();
//    FramelessHelper::Quick::registerTypes(app.engine());
//    return app.exec();
//}
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>

FRAMELESSHELPER_REQUIRE_CONFIG(window)
FRAMELESSHELPER_USE_NAMESPACE

int main(int argc, char *argv[])
{
    FramelessHelper::Quick::initialize();
    QGuiApplication app(argc, argv);


    std::unique_ptr<QQmlApplicationEngine> engine = std::make_unique<QQmlApplicationEngine>();
    const QUrl url(u"qrc:/Main.qml"_qs);

    engine->load(url);
    FramelessHelper::Core::setApplicationOSThemeAware();
    FramelessHelper::Quick::registerTypes(engine.get());

    return app.exec();
}

