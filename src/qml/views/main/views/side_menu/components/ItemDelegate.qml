import QtQuick 
import QtQuick.Controls 

import components as Comp

Comp.ItemDelegate {
    id: iconLabelItemDelegate 
    property bool opened

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
