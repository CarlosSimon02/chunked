import QtQuick as Q

import components as C

C.Button {
    id: button
    onClicked: button.highlighted = !button.highlighted

    contentItem: Q.Item {
        id: item
        implicitWidth: button.icon.width
        implicitHeight: button.icon.height

        Q.Column {
            anchors.centerIn: parent
            topPadding: 4
            bottomPadding: 4
            spacing: (item.implicitHeight - (6 + topPadding + bottomPadding)) / 2

            Q.Rectangle {
                id: top
                anchors.right: parent.right
                height: 2
                width: item.implicitWidth - 10
                radius: 10
                color: button.icon.color
            }

            Q.Rectangle {
                id: middle
                anchors.right: parent.right
                height: 2
                width: item.implicitWidth
                radius: 10
                color: button.icon.color
            }

            Q.Rectangle {
                id: bottom
                height: 2
                width: item.implicitWidth - 10
                radius: 10
                color: button.icon.color
            }

            states: Q.State {
                name: "opened"
                when: button.highlighted

                Q.PropertyChanges { target: top; width: item.implicitWidth }
                Q.PropertyChanges { target: middle; width: item.implicitWidth - 8 }
                Q.PropertyChanges { target: bottom; width: item.implicitWidth - 16 }
                Q.AnchorChanges { target: bottom; anchors.left: undefined; anchors.right: parent.right }
            }

            transitions: Q.Transition {
                to: "opened"
                reversible: true

                Q.NumberAnimation {
                    targets: [top,middle,bottom]
                    property:"width"
                    duration: 500
                    easing.type: Q.Easing.OutQuad
                }

                Q.AnchorAnimation {
                    duration: 500
                    easing.type: Q.Easing.OutQuad
                }
            }
        }
    }
}
