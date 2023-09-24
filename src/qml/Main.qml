import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import org.wangwenx190.FramelessHelper
import app

import "views/side_menu"
import "views/top_bar"
import "views/goals"

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

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 0

        TopBarView {
            id: topBarView
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: 0

            SideMenuView {
                id: sideMenu
                Layout.fillHeight: true
            }

            GoalsView {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    //This is for modal popups, I want TopBarView to be responsive even popup is open
    Pane {
        id: backdrop
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height - topBarView.height
        padding: 0
        visible: false
        background: Rectangle {
            color: "#7F000000"
        }
    }

    Drawer {
        id: drawer
        width: 170
        height: window.height
        interactive: false
        Overlay.modal: null
        modal: false
        Material.background: "black"
        Material.roundedScale: Material.NotRounded

        Connections {
            target: window
            function onWidthChanged() {
                if(drawer.opened && sideMenu.visible)
                    drawer.close()
            }
        }

        onAboutToShow: backdrop.visible = true
        onAboutToHide: backdrop.visible = false
    }
}
