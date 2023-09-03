import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

import components as Comp

Comp.Pane {
    id: pane
    implicitWidth: 300
    implicitHeight: 150
    padding: 0
    background: null

    property alias source: image.source

    Rectangle {
        id: dragIndicator
        anchors.fill: parent
        color: "transparent"
        radius: Comp.Consts.commonRadius

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 5
            visible: image.status === Image.Null

            IconImage {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                Layout.bottomMargin: 10
                Layout.alignment: Qt.AlignHCenter
                color: Comp.ColorScheme.secondaryColor.veryDark
                source: "qrc:/vision_board_icon.svg"
            }

            Comp.Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Drag image here or "
                font.pixelSize: 12
                color: Comp.ColorScheme.secondaryColor.dark
            }

            Comp.Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Browse image"
                font.underline: true
                font.pixelSize: 12
                color: Comp.ColorScheme.secondaryColor.dark

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }

                TapHandler {
                    onTapped: fileDialog.open()
                }
            }
        }
    }

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: {sourceSize.width = width}
        sourceSize.height: {sourceSize.height = height}
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: image.width
                height: image.height

                Rectangle {
                    anchors.fill: parent
                    radius: Comp.Consts.commonRadius
                }
            }
        }

        onStatusChanged: {
            if(status === Image.Error) {
                errorDialog.open()
                image.source = ""
            }
        }

        Comp.Button {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            icon.source: "qrc:/delete_icon.svg"
            visible: pane.hovered && image.status === Image.Ready
            backgroundColor: Comp.ColorScheme.primaryColor.light
            onClicked: image.source = ""
        }

        Comp.Button {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Change"
            visible: pane.hovered && image.status === Image.Ready
            backgroundColor: Comp.ColorScheme.primaryColor.light
            onClicked: fileDialog.open()
        }

        Dialog {
            id: errorDialog
            implicitWidth: 300
            implicitHeight: 200
            parent: Overlay.overlay
            anchors.centerIn: parent
            title: "An Error Occurred"
            standardButtons: Dialog.Ok

            Label {
                text: "Unsupported image format."
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 1
        border.color: Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Consts.commonRadius
    }

    DropArea {
        anchors.fill: parent
        onEntered: drag => {
                       dragIndicator.color = Comp.ColorScheme.secondaryColor.veryDark

                   }

        onExited: dragIndicator.color = "transparent"
        onDropped: drop => {
                       dragIndicator.color = "transparent"
                       image.source = drop.urls[0]
                   }
    }

    FileDialog {
        id: fileDialog
        nameFilters: ["PNG image (*.png)", "JPEG image (*.jpg)"]
        onAccepted: image.source = selectedFile
    }
}
