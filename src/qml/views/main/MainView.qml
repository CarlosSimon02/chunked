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
        spacing: 0

        Comp.HeaderTab {

        }

        Loader {
            id: bodyView
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: sideMenu.currentItem.viewSource
    //        source: "qrc:/views/main/views/goals/GoalsView.qml"
        }
    }
}
