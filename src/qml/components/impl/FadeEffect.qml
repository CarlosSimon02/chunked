import QtQuick 
import QtQuick.Controls 

import components as Comp

Item {
    id: item
    property color colorEffect
    property bool controlIsHovered
    property bool controlIsDown
    property bool controlIsHighlighted
    property bool controlIsEnabled

    Rectangle {
        id: rectangle
        anchors.fill: parent
        radius: Comp.Consts.commonRadius

        color: Comp.Utils.setColorAlpha(item.colorEffect, 0)

        states: [
            State {
                name: "down"
                when: item.controlIsDown && !item.controlIsHighlighted && item.controlIsEnabled

                PropertyChanges {
                    target: rectangle
                    color: Comp.Utils.setColorAlpha(colorEffect, 0.2)
                }
            },
            State {
                name: "hovered"
                when: item.controlIsHovered && !item.controlIsHighlighted && item.controlIsEnabled

                PropertyChanges {
                    target: rectangle
                    color: Comp.Utils.setColorAlpha(colorEffect, 0.1)
                }
            }
        ]

        transitions: [
            Transition {
                from: "hovered"
                to: "down"
                reversible: true
                ColorAnimation { duration: 300 }
            },
            Transition {
                to: "hovered"
                reversible: true
                ColorAnimation { duration: 300 }
            }
        ]
    }
}


