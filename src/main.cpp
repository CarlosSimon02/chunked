#include <QFontDatabase>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QQmlContext>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>

FRAMELESSHELPER_REQUIRE_CONFIG(window)
FRAMELESSHELPER_USE_NAMESPACE

void loadFonts()
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

int main(int argc, char *argv[])
{
    FramelessHelper::Quick::initialize();
    QApplication app(argc, argv);
    loadFonts();

    std::unique_ptr<QQmlApplicationEngine> engine = std::make_unique<QQmlApplicationEngine>();
    engine->addImportPath(":/common");
    const QUrl url(u"qrc:/Main.qml"_qs);
    engine->load(url);
    FramelessHelper::Quick::registerTypes(engine.get());

    return app.exec();
}
