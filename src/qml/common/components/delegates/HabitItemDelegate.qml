import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn
import "./impl" as Impl

Impl.ItemDelegate {
    id: control

    property bool hasParentGoal
    property int itemId
    property alias habitName: habitName.text
    property date startDateTime
    property date endDateTime

    padding: 15

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
                    font.pixelSize: control.hasParentGoal ? Comp.Globals.fontSize.medium :
                                                        Comp.Globals.fontSize.large
                    wrapMode: Text.Wrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    color: "white"
                }

                Impl.MenuButton {
                    Layout.preferredHeight: 27
                    Layout.alignment: Qt.AlignTop
                }
            }

            ColumnLayout {
                spacing: 6

                Impl.ContentIconLabel {
                    id: timeStatus
                    icon.source: "qrc:/time_icon.svg"
                    text: Comp.Utils.getTimeStatus(control.startDateTime,
                                                 control.endDateTime,
                                                 control.done)
                    color: Comp.Globals.statusColors[Comp.Utils.getStatus(control.dateTime,
                                                    Comp.Utils.getEndDateTime(control.dateTime, control.duration),
                                                    control.done)]
                }

                Impl.ContentIconLabel {
                    id: category
                    spacing: 8
                    icon.source: "qrc:/category_icon.svg"
                    text: "Home"
                    visible: !control.hasParentGoal
                }

                Impl.ContentIconLabel {
                    icon.source: "qrc:/fire_icon.svg"
                    text: "8 days"
                }
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignBottom
            Layout.bottomMargin: -12
            spacing: 0

            Comp.ProgressBar {
                Layout.fillWidth: true
                value: 50
                target: 100
                fontPixelSize: Comp.Globals.fontSize.large
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
}
