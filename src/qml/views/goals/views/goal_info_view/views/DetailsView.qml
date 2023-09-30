import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import components as Comp

ScrollView {
    id: scrollView

    clip: true

    layer.samples: 8
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: scrollView.width
            height: scrollView.height

            radius: 10
        }
    }

    background: Rectangle {
        color: Comp.Globals.color.primary.shade3
    }

    ColumnLayout {
        width: scrollView.width
        spacing: 0

        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            source: "file:/Users/Carlos Simon/Downloads/dg0xaud-b2b199e4-e4fa-4f4c-a017-71e709e95926.png"
            sourceSize.width: 350
            sourceSize.height: 197
        }

        ColumnLayout {
            Layout.margins: 15
            spacing: 30

            Text {
                Layout.fillWidth: true

                text: "Fuck you all to the world"
                font.pixelSize: Comp.Globals.fontSize.large
                color: "white"
            }

            RowLayout {
                RowLayout {
                    Layout.alignment: Qt.AlignBottom

                    ProgressBar {
                        Layout.fillWidth: true
                        Material.accent: Material.color(Material.Lime, Material.Shade900)
                        value: 0.5
                    }

                    Text {
                        text: "50%"
                        font.pixelSize: Comp.Globals.fontSize.large
                        color: Material.color(Material.Lime, Material.Shade900)
                    }

                    ColumnLayout {

                    }
                }
            }
        }
    }
}
