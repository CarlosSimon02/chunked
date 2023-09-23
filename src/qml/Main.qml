import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import org.wangwenx190.FramelessHelper
import app

import "views/side_menu"
import "views/goal_info"

FramelessApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: false
    font.family: "Poppins"
    color: "blue"

    StandardTitleBar {
        id: titleBar
        color: "white"
        anchors {
            top: parent.top
            topMargin: window.visibility === Window.Windowed ? 1 : 0
            left: parent.left
            right: parent.right
        }
        titleLabel.visible: false
        windowIcon: "qrc:///images/microsoft.svg"
        windowIconVisible: true
    }

    FramelessHelper.onReady: {
        FramelessHelper.moveWindowToDesktopCenter()
        titleBar.color = window.color
        FramelessHelper.titleBarItem = titleBar
//        FramelessHelper.setHitTestVisible(sideMenu)
//        FramelessHelper.setHitTestVisible(headerTab)
        FramelessHelper.setSystemButton(titleBar.minimizeButton, FramelessHelperConstants.Minimize)
        FramelessHelper.setSystemButton(titleBar.maximizeButton, FramelessHelperConstants.Maximize)
        FramelessHelper.setSystemButton(titleBar.maximizeButton, FramelessHelperConstants.Normal)
        FramelessHelper.setSystemButton(titleBar.closeButton, FramelessHelperConstants.Close)
        window.visible = true;
    }

//    MouseArea {
//        anchors.fill: parent
//        onClicked: forceActiveFocus()
//    }

//    RowLayout {
//        id: mainLayout
//        anchors.fill: parent
//        anchors.margins: 15
//        spacing: 10

//        SideMenuView {
//            id: sideMenu
//            Layout.fillHeight: true
//        }

//        ColumnLayout {
//            spacing: 0

//            Comp.HeaderTab {
//                id: headerTab
//                iconSource: sideMenu.currentItem.icon.source
//                titleText: sideMenu.currentItem.text
//            }

//            StackView {
//                id: mainStackView
//                Layout.fillWidth: true
//                Layout.fillHeight: true
//                popEnter: null
//                popExit: null
//                pushEnter: null
//                pushExit: null
//                replaceEnter: null
//                replaceExit: null
//                clip: true

//                initialItem: Loader {
//                    id: mainLoader
//                    source: sideMenu.currentItem.viewSource
//            //        source: "qrc:/views/main/views/goals/GoalsView.qml"
//                }
//            }
//        }
//    }

//    Comp.TopBar {
//        id: topBar
//        width: parent.width
//        height: 65
//    }
}
