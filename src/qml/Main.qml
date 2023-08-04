import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import "./side_menu"
import "./body"
import "./popups"

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

            RowLayout {
                anchors.fill: parent
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
    }
}
