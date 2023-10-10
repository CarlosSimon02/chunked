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

int main(int argc, char *argv[])
{
    FramelessHelper::Quick::initialize();
    QApplication app(argc, argv);

    std::unique_ptr<QQmlApplicationEngine> engine = std::make_unique<QQmlApplicationEngine>();
    engine->addImportPath(":/common");
    const QUrl url(u"qrc:/Main.qml"_qs);
    engine->load(url);
    FramelessHelper::Quick::registerTypes(engine.get());

    return app.exec();
}
