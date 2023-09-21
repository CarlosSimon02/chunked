import QtQuick
import QtQml
import QtQuick.Controls.Basic
import QtQuick.Layouts
import org.wangwenx190.FramelessHelper
import app

import "views/side_menu"
import "views/goal_info"

import components as Comp

FramelessApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: false
    font.family: "Poppins"
    color: Comp.ColorScheme.primaryColor.dark


    FramelessHelper.onReady: {
        FramelessHelper.moveWindowToDesktopCenter()
        FramelessHelper.titleBarItem = topBar
        FramelessHelper.setHitTestVisible(sideMenu)
        FramelessHelper.setHitTestVisible(headerTab)
        FramelessHelper.setSystemButton(topBar.minimizeButton, FramelessHelperConstants.Minimize)
        FramelessHelper.setSystemButton(topBar.maximizeButton, FramelessHelperConstants.Maximize)
        FramelessHelper.setSystemButton(topBar.maximizeButton, FramelessHelperConstants.Normal)
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
                iconSource: sideMenu.currentItem.icon.source
                titleText: sideMenu.currentItem.text
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

        minimizeButton.onClicked:window.showMinimized()
        maximizeButton.onClicked: {
            if(!window.maximized)
            {
                window.showMaximized()
            }
            else {
                window.showNormal()
            }
        }
        maximizeButton.icon.source: window.maximized ?
                                        "qrc:/restore_down_icon.svg" :
                                        "qrc:/maximize_icon.svg"
        closeButton.onClicked: window.close()

    }
}
