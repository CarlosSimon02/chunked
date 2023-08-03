import QtQuick as Q
import QtQuick.Controls as Q
import QtQuick.Layouts as Q
import app

import "./side_menu"
import "./body"
//import "./popups"

import components as C

C.ApplicationWindow {

//    Popups {
//        id: popups
//        anchors.fill: parents
//    }

    DBAccess {
        id: dbAccess
    }

    Q.ColumnLayout {
        anchors.fill: parent

        Q.Item {
            Q.Layout.maximumWidth: 1700
            Q.Layout.maximumHeight: 1080
            Q.Layout.fillWidth: true
            Q.Layout.fillHeight: true
            Q.Layout.alignment: Qt.AlignCenter
            Q.Layout.margins: 15

            Q.RowLayout {
                anchors.fill: parent
                spacing: 10

                SideMenuView {
                    id: sideMenu
                    Q.Layout.fillHeight: true
                }

                BodyView {
                    id: bodyView
                    Q.Layout.fillWidth: true
                    Q.Layout.fillHeight: true
                    currentIndex: sideMenu.currentIndex
                }
            }
        }
    }
}
