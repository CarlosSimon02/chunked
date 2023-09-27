import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

import components as Comp

Pane {
    id: pane
    implicitWidth: 300
    implicitHeight: width * 9 / 16
    padding: 0
    background: null
    focusPolicy: Qt.ClickFocus

    HoverHandler {
        id: hoverHandler
    }

    property alias source: image.source

    Rectangle {
        id: dragIndicator
        anchors.fill: parent
        color: "transparent"
        radius: 4

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 5
            visible: image.status === Image.Null

            IconImage {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                Layout.bottomMargin: 10
                Layout.alignment: Qt.AlignHCenter
                color: Comp.Globals.color.secondary.shade1
                source: "qrc:/vision_board_icon.svg"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Drag image here or "
                font.pixelSize: Comp.Globals.fontSize.small
                color: Comp.Globals.color.secondary.shade1
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Browse image"
                font.underline: true
                font.pixelSize: Comp.Globals.fontSize.small
                color: Comp.Globals.color.secondary.shade1

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
                    radius: 6
                }
            }
        }

        onStatusChanged: {
            if(status === Image.Error) {
                errorDialog.open()
                image.source = ""
            }
        }

        Button {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            icon.source: "qrc:/delete_icon.svg"
            visible: pane.hovered && image.status === Image.Ready
            onClicked: image.source = ""

            Material.elevation: 0
            Material.roundedScale: Material.SmallScale
        }

        Button {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Change"
            visible: pane.hovered && image.status === Image.Ready
            onClicked: fileDialog.open()

            Material.elevation: 0
            Material.roundedScale: Material.SmallScale
        }

        Dialog {
            id: errorDialog
            parent: Overlay.overlay
            anchors.centerIn: parent
            title: "Error"
            standardButtons: Dialog.Ok
//            contentText: "Can't load image. Unsupported image format."
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: pane.focus ? 1.5 : 1
        border.color: pane.focus ? Comp.Globals.color.accent.shade1 :
                                   hoverHandler.hovered ? Comp.Globals.color.secondary.shade3 :
                                                          Comp.Globals.color.secondary.shade1
        radius: 4
    }

    DropArea {
        anchors.fill: parent
        onEntered: drag => {
                       dragIndicator.color = Comp.Globals.color.primary.shade3
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
