import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./views/goals"
import "./views/settings"
import "./views/side_menu"

RowLayout {
    spacing: 10

    SideMenuView {
        id: sideMenu
        Layout.fillHeight: true
    }

    Loader {
        id: bodyView
        Layout.fillWidth: true
        Layout.fillHeight: true
        source: sideMenu.currentViewSource
//        source: "qrc:/views/main/views/goals/GoalsView.qml"
    }
}
