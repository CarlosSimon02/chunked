import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts 

import "./components" as MComp
import components as Comp

Pane {
    padding: 0
    horizontalPadding: 10
    property alias currentItem: menuListView.currentItem
    visible: window.width >= 700

    Material.background: Material.color(Material.Grey, Material.ShadeA100)

    Column {
        spacing: 50

        Comp.MenuButton {
            id: menuButton
            anchors.horizontalCenter: menuListView.horizontalCenter
        }

        MComp.MenuListView {
            id: menuListView
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
