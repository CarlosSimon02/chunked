import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./impl" as Impl

Impl.ItemDelegate {
    id: control

    property alias done: checkBox.checked
    property int outcomes
    property alias taskName: taskName.text
    property date dateTime
    property int duration

    horizontalPadding: 10
    verticalPadding: text.lineCount > 1 ? 5 : 0

    onClicked: taskInfoDrawerView.open()
    onDateTimeChanged: {
        let tempDate = control.dateTime
        tempDate.setMinutes(tempDate.getMinutes() + control.duration)
        timeStatus.text = Comp.Utils.getTimeStatus(control.dateTime,
                                       tempDate,
                                       control.done)
        timeStatus.color =  Comp.Globals.statusColors[Comp.Utils.getStatus(control.dateTime,
                                        tempDate,
                                        control.done)]
    }

    onDurationChanged: {
        let tempDate = control.dateTime
        tempDate.setMinutes(tempDate.getMinutes() + control.duration)
        timeStatus.text = Comp.Utils.getTimeStatus(control.dateTime,
                                       tempDate,
                                       control.done)
        timeStatus.color =  Comp.Globals.statusColors[Comp.Utils.getStatus(control.dateTime,
                                        tempDate,
                                        control.done)]
    }

    contentItem: RowLayout {
        spacing: 20

        RowLayout {
            CheckBox {
                id: checkBox
            }

            //visible only if tracker is outcome base
            Label {
                Layout.preferredHeight: 30
                Layout.preferredWidth: 30
                text: control.outcomes
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                visible: false
                background: Rectangle {
                    color: Comp.Globals.color.primary.shade2
                    radius: Material.SmallScale
                }
            }

            Text {
                id: taskName
                Layout.fillWidth: true
                maximumLineCount: 2
                color: Comp.Globals.color.secondary.shade4
                elide: Text.ElideRight
                font.pixelSize: Comp.Globals.fontSize.medium
                wrapMode: Text.Wrap
            }
        }

        RowLayout {
            Text {
                id: timeStatus
                font.pixelSize: Comp.Globals.fontSize.small
                visible: control.width > 600
            }

            Impl.MenuButton {
                Layout.preferredHeight: 27
                Layout.alignment: Qt.AlignTop

                onClicked: menu.open()

                Menu {
                    id: menu
                    Material.background: Material.color(Material.Grey, Material.Shade900)
                    Material.elevation: 15

                    MenuItem {
                        text: qsTr("Open")
                        onTriggered: {
                            taskInfoDrawerView.open()
                        }

                        Material.accent: Material.color(Material.Lime, Material.Shade900)
                    }

                    MenuItem {
                        text: qsTr("Edit")
                        onTriggered: {
                            editTaskDialogView.open()
                        }

                        Material.accent: Material.color(Material.Lime, Material.Shade900)
                    }

                    MenuItem {
                        text: qsTr("Delete")
                        onTriggered: {
                                listView.model.removeRow(model.index)
                        }

                        Material.foreground: Material.Red
                    }
                }
            }
        }
    }
}
