import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./views/side_menu"
import "./views/header"

import components as Comp

RowLayout {
    spacing: 10

    SideMenuView {
        id: sideMenu
        Layout.fillHeight: true
    }

    ColumnLayout {
        spacing: -Comp.Consts.commonRadius

        Header {
            Layout.fillWidth: true
        }

        Loader {
            id: bodyView
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: sideMenu.currentViewSource
    //        source: "qrc:/views/main/views/goals/GoalsView.qml"
        }
    }
}
