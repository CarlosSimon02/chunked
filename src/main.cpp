#include <QGuiApplication>
#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>

#include "application.h"

FRAMELESSHELPER_USE_NAMESPACE

int main(int argc, char *argv[])
{
    FramelessHelper::Quick::initialize();
    Application app(argc, argv);
    FramelessHelper::Core::setApplicationOSThemeAware();
    FramelessHelper::Quick::registerTypes(app.engine().get());
    return app.exec();
}
