import QtQuick
import QtQuick.Controls.Basic as Ctrl

import components as Comp

Ctrl.Button {
    id: control
    implicitWidth: 60
    implicitHeight: 40
    icon.width: 14
    icon.height: 14
    icon.color: Comp.Globals.color.secondary.shade3
    display: Ctrl.Button.IconOnly
    property color fadeColor: Comp.Globals.color.secondary.shade3
    property double hoveredOpacity: 0.2
    property double pressedOpacity: 0.3

    background: Rectangle {
        color: "transparent"

        Rectangle {
            id: rectangle
            anchors.fill: parent
            opacity: 0.0
            color: control.fadeColor

            states: [
                State {
                    name: "down"
                    when: control.down

                    PropertyChanges {
                        target: rectangle
                        opacity: control.pressedOpacity
                    }
                },
                State {
                    name: "hovered"
                    when: control.hovered

                    PropertyChanges {
                        target: rectangle
                        opacity: control.hoveredOpacity
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "hovered"
                    to: "down"
                    reversible: false
                    PropertyAnimation { property: "opacity"; duration: 300 }
                },
                Transition {
                    to: "hovered"
                    reversible: true
                    PropertyAnimation { property: "opacity"; duration: 300 }
                }
            ]
        }
    }
}
