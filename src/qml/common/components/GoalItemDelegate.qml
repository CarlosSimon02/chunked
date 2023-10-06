import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    property bool isSubGoal: false
    property bool hasImage: true

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            opacity: 0.7
            visible: control.hasImage
            source: "file:/Users/Carlos Simon/Downloads/dg0xaud-b2b199e4-e4fa-4f4c-a017-71e709e95926.png"
            sourceSize.width: {sourceSize.width = width}
            sourceSize.height: {sourceSize.height = height}
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: image.width
                    height: image.height

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: -control.Material.roundedScale

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: control.Material.roundedScale
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: control.Material.roundedScale
                        }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.margins: 15
            spacing: 15

            RowLayout {
                spacing: 8

                Text {
                    id: goalName
                    text: "To Become a Freaking Software Engineer"
                    Layout.fillWidth: true
                    font.weight: Font.Medium
                    font.pixelSize: control.isSubGoal ? Comp.Globals.fontSize.medium :
                                                        Comp.Globals.fontSize.large
                    wrapMode: Text.Wrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    color: "white"
                }

                IconLabel {
                    Layout.preferredHeight: 27
                    Layout.alignment: Qt.AlignTop
                    icon.source: "qrc:/three_dots_icon.svg"
                    icon.width: 18
                    icon.height: 18
                    icon.color: Comp.Globals.color.secondary.shade2
                }
            }

            ColumnLayout {
                spacing: 6

                ContentIconLabel {
                    id: timeRemaining
                    icon.source: "qrc:/time_icon.svg"
                    text: "1h 2m remaining"
                    //color depends on status
                    color: "green"
                }

                ContentIconLabel {
                    id: category
                    spacing: 8
                    icon.source: "qrc:/category_icon.svg"
                    text: "Home"
                    visible: !control.isSubGoal
                }

                ContentIconLabel {
                    icon.source: "qrc:/progress_icon.svg"
                    text: "1 / 20 goals completed"
                }
            }

            RowLayout {
                Layout.fillHeight: true
                Layout.maximumHeight: Number.POSITIVE_INFINITY

                RowLayout {
                    Layout.alignment: Qt.AlignBottom

                    ProgressBar {
                        Layout.fillWidth: true
                        Material.accent: Material.color(Material.Lime, Material.Shade900)
                        value: 0.5
                    }

                    Text {
                        text: "50%"
                        font.pixelSize: control.isSubGoal ? Comp.Globals.fontSize.medium :
                                                            Comp.Globals.fontSize.large
                        color: Material.color(Material.Lime, Material.Shade900)
                    }
                }
            }
        }
    }

    background: Rectangle {
        radius: Material.SmallScale
        color: Comp.Globals.color.primary.shade3

        Rectangle {
            width: parent.width
            height: parent.height
            radius: parent.radius
            visible: enabled && (control.hovered || control.visualFocus)
            color: control.Material.rippleColor
        }

        Rectangle {
            width: parent.width
            height: parent.height
            radius: parent.radius
            visible: control.down
            color: control.Material.rippleColor
        }
    }
}
