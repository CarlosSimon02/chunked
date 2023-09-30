import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
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

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            opacity: 0.7
            visible: control.height >= 300
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

            Text {
                id: goalName
                text: "To Become a Freaking Software Engineer"
                Layout.fillWidth: true
                font.weight: Font.Medium
                font.pixelSize: Comp.Globals.fontSize.large
                wrapMode: Text.Wrap
                maximumLineCount: 2
                elide: Text.ElideRight
                color: "white"
            }

            ColumnLayout {
                spacing: 6

                ContentIconLabel {
                    id: timeRemaining
                    icon.source: "qrc:/time_icon.svg"
                    text: "1h 2m remaining"
                }

                ContentIconLabel {
                    id: category
                    spacing: 8
                    icon.source: "qrc:/category_icon.svg"
                    text: "Home"
                }

                ContentIconLabel {
                    icon.source: "qrc:/status_icon.svg"
                    text: "Active"
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
                        font.pixelSize: Comp.Globals.fontSize.large
                        color: Material.color(Material.Lime, Material.Shade900)
                    }
                }
            }
        }
    }

    Pane {
        padding: 0
        x: -((width / 2)+5)
        background: Rectangle {
            color: Material.color(Material.Lime, Material.Shade900)
            radius: Material.SmallScale
        }
        visible: control.hovered || hovered

        ColumnLayout {
            spacing: 0

            Comp.IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                icon.source: "qrc:/three_dots_icon.svg"
                icon.width: 16
                icon.height: 16
            }

            Comp.IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                icon.source: "qrc:/delete_icon.svg"
                icon.width: 16
                icon.height: 16
            }

            Comp.IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                icon.source: "qrc:/create_icon.svg"
                icon.width: 16
                icon.height: 16
            }

            Comp.IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                icon.source: "qrc:/minus_icon.svg"
                icon.width: 16
                icon.height: 16
            }
        }
    }

    background: Rectangle {
        radius: control.Material.roundedScale === Material.FullScale ? height / 2 : control.Material.roundedScale
        color: control.Material.buttonColor(control.Material.theme, control.Material.background,
            control.Material.accent, control.enabled, control.flat, control.highlighted, control.checked)

        layer.enabled: control.enabled && color.a > 0 && !control.flat
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }

        Ripple {
            clip: true
            clipRadius: parent.radius
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.flat && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }
}
