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
            Layout.margins: 20
            spacing: 30

            ColumnLayout {
                spacing: 8

                Text {
                    Layout.fillWidth: true
                    Layout.preferredWidth: width
                    wrapMode: Text.Wrap
                    text: "To Become a Freaking Software Engineer"
                    font.pixelSize: Comp.Globals.fontSize.large
                    font.weight: Font.DemiBold
                    color: "white"
                }

                Text {
                    text: "6h 40m remaining"
                    font.pixelSize: Comp.Globals.fontSize.small
                    color: Comp.Globals.color.secondary.shade2
                }
            }

            RowLayout {
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
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8

                Repeater {
                    delegate: RowLayout {
                        Text {
                            Layout.preferredWidth: 100
                            Layout.alignment: Qt.AlignTop
                            text: model.label + ":"
                            font.pixelSize: Comp.Globals.fontSize.small
                            font.weight: Font.DemiBold
                            color: Comp.Globals.color.secondary.shade3
                        }

                        Text {
                            Layout.fillWidth: true
                            Layout.preferredWidth: implicitWidth
                            text: model.value
                            font.pixelSize: Comp.Globals.fontSize.small
                            color: model.color
                            wrapMode: Text.Wrap
                        }
                    }

                    model: ListModel {
                        ListElement {
                            label: "Parent Goal"
                            value: "Sample"
                            color: "white"
                        }

                        ListElement {
                            label: "Status"
                            value: "Active"
                            color: "green"
                        }

                        ListElement {
                            label: "Category"
                            value: "Home"
                            color: "white"
                        }

                        ListElement {
                            label: "Time Frame"
                            value: "29 Sep 2023 03:49 PM -\n29 Sep 2023 03:49 PM"
                            color: "white"
                        }

                        ListElement {
                            label: "Range"
                            value: "5h 2m"
                            color: "white"
                        }

                        ListElement {
                            label: "Tracker"
                            value: "Subgoals(Total Progress)"
                            color: "white"
                        }
                    }
                }
            }
        }
    }
}
