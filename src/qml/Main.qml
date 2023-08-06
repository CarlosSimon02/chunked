import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import "./views/side_menu"
import "./views/body"
import "./views/popups"
import "./views/goal_info"

import components as Comp

Comp.ApplicationWindow {
    DBAccess {
        id: dbAccess
    }

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.maximumWidth: 1700
            Layout.maximumHeight: 1080
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            Layout.margins: 15

            Popups {
                id: popups
                anchors.fill: parent
            }

            StackView {
                id: stackView
                anchors.fill: parent
                initialItem: RowLayout {
                    spacing: 10

                    SideMenuView {
                        id: sideMenu
                        Layout.fillHeight: true
                    }

                    BodyView {
                        id: bodyView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        currentIndex: sideMenu.currentIndex
                    }
                }
            }

            Component {
                id: goalInfoView

                GoalInfoView {}
            }
        }
    }
}
