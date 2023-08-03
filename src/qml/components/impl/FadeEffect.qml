import QtQuick as Q
import QtQuick.Controls as Q

import components as C

Q.Item {
    id: item
    property Q.color colorEffect
    property bool controlIsHovered
    property bool controlIsDown
    property bool controlIsHighlighted

    Q.Rectangle {
        id: rectangle
        anchors.fill: parent
        radius: C.Units.commonRadius

        color: C.Utils.setColorAlpha(item.colorEffect, 0)

        states: [
            Q.State {
                name: "down"
                when: item.controlIsDown && !item.controlIsHighlighted

                Q.PropertyChanges {
                    target: rectangle
                    color: C.Utils.setColorAlpha(colorEffect, 0.2)
                }
            },
            Q.State {
                name: "hovered"
                when: item.controlIsHovered && !item.controlIsHighlighted

                Q.PropertyChanges {
                    target: rectangle
                    color: C.Utils.setColorAlpha(colorEffect, 0.1)
                }
            }
        ]

        transitions: [
            Q.Transition {
                from: "hovered"
                to: "down"
                reversible: true
                Q.ColorAnimation { duration: 300 }
            },
            Q.Transition {
                to: "hovered"
                reversible: true
                Q.ColorAnimation { duration: 300 }
            }
        ]
    }
}


