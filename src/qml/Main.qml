import QtQuick
import QtQml
import QtQuick.Controls.Basic
import QtQuick.Layouts
import org.wangwenx190.FramelessHelper
import app

import "./views/main"
import "./views/goal_info"

import components as Comp

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    visible: true
    font.family: "Poppins"
    color: Comp.ColorScheme.primaryColor.dark

    FramelessHelper.onReady: {
//        FramelessHelper.titleBarItem = titleBar
//        FramelessHelper.setHitTestVisible(columnLayout)
        window.visible = true;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    Comp.TopBar {
        id: topBar
        width: parent.width
        height: 65
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Item {
            Layout.maximumWidth: 1700
            Layout.maximumHeight: 1080
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            Layout.margins: 15

            StackView {
                id: stackView
                anchors.fill: parent

                popEnter: null
                popExit: null
                pushEnter: null
                pushExit: null
                replaceEnter: null
                replaceExit: null

                initialItem: MainView {
                    id: mainView
                }
            }

            Component {
                id: goalInfoView

                GoalInfoView {}
            }
        }
    }
}

//import QtQuick
//import QtQuick.Controls.Basic
//import org.wangwenx190.FramelessHelper

//FramelessWindow {
//    id: window
//    objectName: "window"
//    visible: false // Hide the window before we sets up it's correct size and position.
//    width: 800
//    height: 600
//    title: qsTr("FramelessHelper demo application - Qt Quick [") + objectName +']'
//    color: {
//        if (FramelessHelper.blurBehindWindowEnabled) {
//            return "transparent";
//        }
//        if (FramelessUtils.systemTheme === FramelessHelperConstants.Dark) {
//            return FramelessUtils.defaultSystemDarkColor;
//        }
//        return FramelessUtils.defaultSystemLightColor;
//    }

//    Component.onDestruction: Settings.saveGeometry(window)

//    FramelessHelper.onReady: {
//        // Let FramelessHelper know what's our homemade title bar, otherwise
//        // our window won't be draggable.
//        FramelessHelper.titleBarItem = titleBar;
////        if (!$isMacOSHost) {
////            // Make our own items visible to the hit test and on Windows, enable
////            // the snap layout feature (available since Windows 11).
////            FramelessHelper.setSystemButton(titleBar.minimizeButton, FramelessHelperConstants.Minimize);
////            FramelessHelper.setSystemButton(titleBar.maximizeButton, FramelessHelperConstants.Maximize);
////            FramelessHelper.setSystemButton(titleBar.closeButton, FramelessHelperConstants.Close);
////        }
////        if (!Settings.restoreGeometry(window)) {
////            FramelessHelper.moveWindowToDesktopCenter();
////        }
//        // Finally, show the window after everything is setted.
//        window.visible = true;
//    }

//    Shortcut {
//        sequences: [ StandardKey.Cancel, StandardKey.Close, StandardKey.Quit ]
//        onActivated: {
//            if (window.visibility === Window.FullScreen) {
//                window.toggleFullScreen();
//            } else {
//                window.close();
//            }
//        }
//    }

//    Shortcut {
//        sequences: [ StandardKey.FullScreen, "ALT+RETURN" ]
//        onActivated: window.toggleFullScreen()
//    }

//    Timer {
//        interval: 100
//        running: true
//        repeat: true
//        onTriggered: timeLabel.text = Qt.formatTime(new Date(), "hh:mm:ss")
//    }

//    Label {
//        id: timeLabel
//        anchors.centerIn: parent
//        font {
//            pointSize: 70
//            bold: true
//        }
//        color: (FramelessUtils.systemTheme === FramelessHelperConstants.Dark) ? Qt.color("white") : Qt.color("black")
//    }

//    StandardTitleBar {
//        id: titleBar
//        anchors {
//            top: parent.top
//            topMargin: window.visibility === Window.Windowed ? 1 : 0
//            left: parent.left
//            right: parent.right
//        }
//        height: 100
//        titleLabel.visible: false
////        windowIcon: "qrc:///images/microsoft.svg"
////        windowIconVisible: true
//    }
//}
