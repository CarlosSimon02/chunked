import QtQuick 
import QtQuick.Controls.Material as Ctrl

Ctrl.ItemDelegate {
    id: iconLabelItemDelegate
    implicitWidth: 50
    implicitHeight: 50
    padding: 0
    horizontalPadding: 15
    icon.width: 18
    icon.height: 18
    property bool opened

    Ctrl.Material.foreground: Ctrl.Material.color(Ctrl.Material.Grey, Ctrl.Material.Shade400)

    Item {
        states: State {
            name: "opened"
            when: iconLabelItemDelegate.opened

            PropertyChanges {
                target: iconLabelItemDelegate
                horizontalPadding: 18
            }
        }

        transitions: Transition {
            to: "opened"
            reversible: true

            NumberAnimation {
                targets: [iconLabelItemDelegate]
                property:"horizontalPadding"
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }
}
