import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

import components as Comp

Pane {
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
        radius: Comp.Units.commonRadius

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 0

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

            Comp.Button {
                Layout.alignment: Qt.AlignHCenter
                text: "Browse image"
                font.weight: Font.DemiBold
                font.pixelSize: 12
                foregroundColor: Comp.ColorScheme.secondaryColor.dark
                onClicked: fileDialog.open()
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
                    radius: Comp.Units.commonRadius
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 1.5
        border.color: Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Units.commonRadius
    }

    DropArea {
        anchors.fill: parent
        onEntered: drag => {
                       dragIndicator.color = Comp.ColorScheme.secondaryColor.veryDark

                   }

        onExited: dragIndicator.color = "transparent"
        onDropped: drop => {
                       image.source = drop.urls[0]
                   }
    }

    FileDialog {
        id: fileDialog
        onAccepted: image.source = selectedFile
    }
}
