import QtQuick as Q
import QtQuick.Controls as Q

import components as C

C.ItemDelegate {
    id: iconLabelItemDelegate 
    property bool opened

    Q.Item {
        states: Q.State {
            name: "opened"
            when: iconLabelItemDelegate.opened

            Q.PropertyChanges {
                target: iconLabelItemDelegate
                horizontalPadding: 18
            }
        }

        transitions: Q.Transition {
            to: "opened"
            reversible: true

            Q.NumberAnimation {
                targets: [iconLabelItemDelegate]
                property:"horizontalPadding"
                duration: 500
                easing.type: Q.Easing.OutQuad
            }
        }
    }
}
