import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ColumnLayout {
    property alias label: label.text
    property alias imageSource: image.source

    Text {
        id: label
    }

    Pane {
        id: pane
        Layout.preferredWidth: 300
        Layout.preferredHeight: 150
        padding: 10

        background: Rectangle {
            border.width: 1
            border.color: "lightgrey"
        }

        Rectangle {
            id: dragIndicator
            anchors.fill: parent

            ColumnLayout {
                anchors.centerIn: parent

                Text {
                    text: "Drag image here"
                }

                Button {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Browse image"
                    onClicked: fileDialog.open()
                }
            }
        }

        Image {
            id: image
            anchors.fill: parent
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectCrop
        }

        DropArea {
            anchors.fill: parent
            onEntered: dragIndicator.color = "lightgrey"
            onExited: dragIndicator.color = "transparent"
            onDropped: drop => image.source = drop.urls[0]
        }

        FileDialog {
            id: fileDialog
            onAccepted: image.source = selectedFile
        }
    }
}
