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
                    font.pixelSize: Comp.Globals.fontSize.medium
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
                spacing: 12

                Repeater {
                    delegate: RowLayout {
                        spacing: 20

                        IconLabel {
                            Layout.alignment: Qt.AlignTop
                            display: IconLabel.IconOnly
                            icon.source: iconSource
                            icon.width: 18
                            icon.height: 18
                            icon.color: Comp.Globals.color.secondary.shade2

                            HoverHandler {
                                id: hover
                            }

                            ToolTip.visible: hover.hovered
                            ToolTip.text: label
                        }

                        Text {
                            Layout.fillWidth: true
                            Layout.preferredWidth: implicitWidth
                            text: model.value
                            font.pixelSize: Comp.Globals.fontSize.medium
                            color: model.color
                            wrapMode: Text.Wrap
                        }
                    }

                    model: ListModel {
                        ListElement {
                            iconSource: "qrc:/hierarchy_icon.svg"
                            label: "Parent Goal"
                            value: "Sample"
                            color: "white"
                        }

                        ListElement {
                            iconSource: "qrc:/status_icon.svg"
                            label: "Status"
                            value: "Active"
                            color: "green"
                        }

                        ListElement {
                            iconSource: "qrc:/category_icon.svg"
                            label: "Category"
                            value: "Home"
                            color: "white"
                        }

                        ListElement {
                            iconSource: "qrc:/date_time_icon.svg"
                            label: "Time Frame"
                            value: "29 Sep 2023 03:49 PM -\n29 Sep 2023 03:49 PM\n(5h 2m)"
                            color: "white"
                        }

                        ListElement {
                            iconSource: "qrc:/tracker_icon.svg"
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
