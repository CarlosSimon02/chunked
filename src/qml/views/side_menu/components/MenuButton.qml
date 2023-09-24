import QtQuick 
import QtQuick.Controls.Material

Button {
    id: button
    property bool opened: false
    flat: true
    onClicked: opened = !opened

    contentItem: Item {
        id: item
        implicitWidth: button.icon.width
        implicitHeight: button.icon.height

        Column {
            anchors.centerIn: parent
            topPadding: 4
            bottomPadding: 4
            spacing: (item.implicitHeight - (6 + topPadding + bottomPadding)) / 2

            Rectangle {
                id: top
                anchors.right: parent.right
                height: 2
                width: item.implicitWidth - 10
                radius: 10
                color: button.icon.color
            }

            Rectangle {
                id: middle
                anchors.right: parent.right
                height: 2
                width: item.implicitWidth
                radius: 10
                color: button.icon.color
            }

            Rectangle {
                id: bottom
                height: 2
                width: item.implicitWidth - 10
                radius: 10
                color: button.icon.color
            }

            states: State {
                name: "opened"
                when: button.opened

                PropertyChanges { target: top; width: item.implicitWidth }
                PropertyChanges { target: middle; width: item.implicitWidth - 8 }
                PropertyChanges { target: bottom; width: item.implicitWidth - 16 }
                AnchorChanges { target: bottom; anchors.left: undefined; anchors.right: parent.right }
            }

            transitions: Transition {
                to: "opened"
                reversible: true

                NumberAnimation {
                    targets: [top,middle,bottom]
                    property:"width"
                    duration: 500
                    easing.type: Easing.OutQuad
                }

                AnchorAnimation {
                    duration: 500
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
