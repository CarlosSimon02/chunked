import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp
import components.inputs as Inpt
import "../../components" as MComp

Comp.Dialog {
    id: dialog

    property int itemId
    property Task task

    title: "Edit Task"
    width: 390
    height: 700
    padding: 0
    parent: Overlay.overlay
    anchors.centerIn: parent
    standardButtons: Dialog.Ok | Dialog.Cancel

    Material.accent: Comp.Globals.color.accent.shade1

    onAccepted: {
        dialog.task.name = taskName.text
        dialog.task.outcomes = outcomes.value
        dialog.task.dateTime = datePicker.chosenDateTime
        dialog.task.duration = durationPicker.duration

        dbAccess.updateTaskItem(dialog.task)
        listView.model.refresh()
    }

    Connections {
        target: backdrop
        function onTapped() {
            dialog.close()
        }
    }

    onAboutToShow: {
        backdrop.open()

        dialog.task = dbAccess.getTaskItem(dialog.itemId)
        taskName.text = dialog.task.name
        outcomes.value = dialog.task.outcomes
        datePicker.chosenDateTime = dialog.task.dateTime
        durationPicker.hour = dialog.task.duration / 60
        durationPicker.minute = dialog.task.duration % 60
    }

    onAboutToHide: {
        backdrop.close()
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent

        ColumnLayout {
            width: scrollView.width

            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                spacing: 20

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Task Name"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    Inpt.TextField {
                        id: taskName
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Outcomes"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    SpinBox {
                        id: outcomes
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        editable: true
                        from: 1
                        to: 99999
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Date and Time Frame"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    ColumnLayout {
                        spacing: 20

                        ListView {
                            id: navBar
                            Layout.fillWidth: true
                            Layout.preferredHeight: contentItem.childrenRect.height
                            spacing: 10
                            currentIndex: 0
                            delegate: Comp.NavBarDelegate {
                                width: (navBar.width - (navBar.spacing * 2)) / 3
                                highlighted: ListView.isCurrentItem
                                display: ItemDelegate.IconOnly
                                icon.source: model.icon
                                onClicked: navBar.currentIndex = model.index

                                ToolTip.visible: hovered
                                ToolTip.text: model.label
                            }

                            model: ListModel {
                                ListElement {
                                    icon: "qrc:/date_icon.svg"
                                    label: "Date"
                                }

                                ListElement {
                                    icon: "qrc:/time_icon.svg"
                                    label: "Time"
                                }

                                ListElement {
                                    icon: "qrc:/timer_icon.svg"
                                    label: "Duration"
                                }
                            }

                            orientation: ListView.Horizontal
                        }

                        StackLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 350
                            currentIndex: navBar.currentIndex

                            Comp.DatePicker {
                                id: datePicker
                            }

                            Page {
                                background: null
                                header: RowLayout {
                                    RowLayout {
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.bottomMargin: 10
                                        spacing: 30

                                        Text {
                                            text: "HH"
                                            font.pointSize: Comp.Globals.fontSize.superSmall
                                            font.weight: Font.Normal
                                            color: Comp.Globals.color.secondary.shade1
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        Text {
                                            text: "MM"
                                            font.pointSize: Comp.Globals.fontSize.superSmall
                                            font.weight: Font.Normal
                                            color: Comp.Globals.color.secondary.shade1
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                                Comp.TimePicker {
                                    id: timePicker
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    height: parent.height
                                    chosenDateTime: new Date(0,0,0,0,0,0)
                                    onChooseTime: datePicker.chosenDateTime.setHours(timePicker.chosenDateTime.getHours(),
                                                                                     timePicker.chosenDateTime.getMinutes())
                                }
                            }

                            Page {
                                background: null
                                header: RowLayout {
                                    RowLayout {
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.bottomMargin: 10
                                        spacing: 30

                                        Text {
                                            text: "HH"
                                            font.pointSize: Comp.Globals.fontSize.superSmall
                                            font.weight: Font.Normal
                                            color: Comp.Globals.color.secondary.shade1
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }

                                        Text {
                                            text: "MM"
                                            font.pointSize: Comp.Globals.fontSize.superSmall
                                            font.weight: Font.Normal
                                            color: Comp.Globals.color.secondary.shade1
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                                MComp.DurationPicker {
                                    id: durationPicker
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
