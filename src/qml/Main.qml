import QtQuick
import QtQml
import QtQuick.Controls.Basic
import QtQuick.Layouts
import org.wangwenx190.FramelessHelper
import app

import "views/side_menu"
import "views/goal_info"

import components as Comp

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    font.family: "Poppins"
    color: Comp.ColorScheme.primaryColor.dark

    FramelessHelper.onReady: {
        FramelessHelper.titleBarItem = topBar
        FramelessHelper.setHitTestVisible(sideMenu)
        FramelessHelper.setHitTestVisible(headerTab)
        FramelessHelper.setSystemButton(topBar.minimizeButton, FramelessHelperConstants.Minimize)
        FramelessHelper.setSystemButton(topBar.maximizeButton, FramelessHelperConstants.Maximize)
        FramelessHelper.setSystemButton(topBar.closeButton, FramelessHelperConstants.Close)
        window.visible = true;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        SideMenuView {
            id: sideMenu
            Layout.fillHeight: true
        }

        ColumnLayout {
            spacing: 0

            Comp.HeaderTab {
                id: headerTab
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

    Comp.TopBar {
        id: topBar
        width: parent.width
        height: 65
    }
}
