import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

T.ItemDelegate {
    id: control

    property bool isSubGoal: false
    property bool hasImage: true

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            opacity: 0.7
            visible: control.hasImage
            source: "file:C:/Users/Carlos Simon/Downloads/anime_guys_working_out_by_nwawalrus_dg0xaud-pre.jpg"
            sourceSize.width: {sourceSize.width = width}
            sourceSize.height: {sourceSize.height = height}
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: image.width
                    height: image.height

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: -Material.SmallScale

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: Material.SmallScale
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Material.SmallScale
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
