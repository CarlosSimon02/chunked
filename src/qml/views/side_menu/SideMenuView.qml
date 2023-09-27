import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts 

import "./components" as MComp
import components as Comp

Pane {
    padding: 0
    horizontalPadding: 10
    visible: window.width >= Comp.Globals.screen.smallW
    property alias currentItem: menuListView.currentItem
    property alias currentIndex: menuListView.currentIndex

    Material.background: Material.color(Material.Grey, Material.ShadeA100)

    Column {
        spacing: 50
        anchors.fill: parent
        //To vertically align center menuButton to page header
        anchors.top: parent.top
        anchors.topMargin: (60/2) - (menuButton.height/2)

        Comp.MenuButton {
            id: menuButton
            anchors.horizontalCenter: menuListView.horizontalCenter
        }

        MComp.MenuListView {
            id: menuListView
            //To make it scrollable when column height is smaller that contentHeight
            height: parent.height - parent.spacing - menuButton.height
        }

        states: State {
            name: "opened"
            when: menuButton.opened

            PropertyChanges {
                target: menuListView
                width: 170
            }

            AnchorChanges {
                target: menuButton
                anchors.horizontalCenter: undefined
                anchors.right: menuListView.right
            }
        }

        transitions: Transition {
            to: "opened"
            reversible: true

            NumberAnimation {
                target: menuListView
                property: "width"
                duration: 200
                easing.type: Easing.OutQuad
            }

            AnchorAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }
}
