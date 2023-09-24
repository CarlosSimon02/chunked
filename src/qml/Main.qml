import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import org.wangwenx190.FramelessHelper
import app

import "views/side_menu"
import "views/goal_info"
import "views/top_bar"

FramelessApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: false
    font.family: "Poppins"

    Material.theme: Material.Dark

    FramelessHelper.onReady: {
        FramelessHelper.moveWindowToDesktopCenter()
        FramelessHelper.titleBarItem = topBarView
//        FramelessHelper.setHitTestVisible(sideMenu)
//        FramelessHelper.setHitTestVisible(headerTab)
        FramelessHelper.setSystemButton(topBarView.minimizeButton, FramelessHelperConstants.Minimize)
        FramelessHelper.setSystemButton(topBarView.maximizeButton, FramelessHelperConstants.Maximize)
        FramelessHelper.setSystemButton(topBarView.maximizeButton, FramelessHelperConstants.Normal)
        FramelessHelper.setSystemButton(topBarView.closeButton, FramelessHelperConstants.Close)
        window.visible = true;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    Pane {
        anchors.fill: parent
        padding: 0
        Material.background: Material.color(Material.Grey, Material.Shade900)
    }

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 0

        TopBarView {
            id: topBarView
            Layout.fillWidth: true
        }

        SideMenuView {
            id: sideMenu
            Layout.fillHeight: true
        }

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
    }
}
