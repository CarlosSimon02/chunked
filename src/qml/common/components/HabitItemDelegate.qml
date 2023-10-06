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

    padding: 15
    property bool isSubHabit: false
    property bool hasImage: true

    contentItem: ColumnLayout {
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            spacing: 15

            RowLayout {
                spacing: 8

                Text {
                    id: habitName
                    text: "No Fap for Six Months Everyday and Every Work"
                    Layout.fillWidth: true
                    font.weight: Font.Medium
                    font.pixelSize: control.isSubHabit ? Comp.Globals.fontSize.medium :
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
                    visible: !control.isSubHabit
                }

                ContentIconLabel {
                    icon.source: "qrc:/fire_icon.svg"
                    text: "8 days"
                }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: -12
            spacing: 0

            RowLayout {
                RowLayout {
                    ProgressBar {
                        Layout.fillWidth: true
                        Material.accent: Material.color(Material.Lime, Material.Shade900)
                        value: 0.5
                    }

                    Text {
                        text: "50%"
                        font.pixelSize: control.isSubHabit ? Comp.Globals.fontSize.medium :
                                                            Comp.Globals.fontSize.large
                        color: Material.color(Material.Lime, Material.Shade900)
                    }
                }
            }

            RowLayout {
                Repeater {
                    delegate: CheckBox {
                        Layout.fillWidth: true
                        Material.accent: Comp.Globals.color.accent.shade1
                        ToolTip.text: "Tuesday, 11 Sep 2023"
                        ToolTip.visible: hovered
                    }

                    model: 7
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
