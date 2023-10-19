cmake_minimum_required(VERSION 3.16)

project(chunked VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
set(FramelessHelper_DIR "D:/framelesshelper/build/lib/cmake/FramelessHelper")

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql Qml Widgets)
find_package(FramelessHelper REQUIRED COMPONENTS Core Quick)

qt_standard_project_setup()

qt_add_executable(chunked
    src/dbaccess.cpp
    src/dbaccess.h
    src/goal.cpp
    src/goal.h
    src/task.cpp
    src/task.h
    src/icons/icons.qrc
    src/main.cpp
    src/models/basetablemodel.cpp
    src/models/basetablemodel.h
    src/models/goalstablemodel.cpp
    src/models/goalstablemodel.h
    src/models/goalnamestreeviewmodel.cpp
    src/models/goalnamestreeviewmodel.h
    src/models/habitstablemodel.cpp
    src/models/habitstablemodel.h
    src/models/taskstablemodel.cpp
    src/models/taskstablemodel.h
    src/progress.cpp
    src/progress.h
    src/qml/qml.qrc
)

target_include_directories(chunked
    PRIVATE src
    PRIVATE src/models
)

qt6_add_qml_module(chunked
    URI app
    VERSION 1.0
    SOURCES
)

list(APPEND QML_DIRS ${CMAKE_SOURCE_DIR}/src/qml/common)
list(APPEND QML_DIRS D:/framelesshelper/build/qml)
list(REMOVE_DUPLICATES QML_DIRS)
set(QML_IMPORT_PATH "${QML_DIRS}"
    CACHE STRING "Qt Creator 4.1 extra qml import paths"
    FORCE
)

set_target_properties(chunked PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(chunked PRIVATE
    Qt6::Quick
    Qt6::Sql
    Qt6::Widgets
    FramelessHelper::Core
    FramelessHelper::Quick
)

install(TARGETS chunked
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
