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
    color: "#121212"

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

    //For textinput controls to lose focus when click outside
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
                id: sideMenuView
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

        signal tapped
        signal close
        signal open

        onOpen: visible = true
        onClose: visible = false

        TapHandler {
            onTapped: {
                backdrop.tapped()
                backdrop.close()
            }
        }
    }

    //For responsive design, can only use when SideMenuView is not visible
    SideMenuDrawerView {
        id: sideMenuDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }
}
