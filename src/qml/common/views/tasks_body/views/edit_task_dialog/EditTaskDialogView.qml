import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp
import components.inputs as Inpt
import "../../components" as MComp

Comp.ItemCreateEditDialog {
    id: dialog

    signal checkError
    property int itemId
    property Task task
    property bool hasError

    title: "Edit Task"
    width: 390
    height: 700

    onCancel: dialog.close()

    onSave: {
        checkError()

        if(!dialog.hasError) {
            dialog.task.name = taskName.text
            dialog.task.outcomes = outcomes.value
            dialog.task.dateTime = datePicker.chosenDateTime
            dialog.task.duration = durationPicker.duration

            dbAccess.updateTaskItem(dialog.task)
            listView.model.refresh()
            taskBodyRowLayout.dataChanged()
            dialog.close()
        }
        else taskName.focus = true
    }


    onAboutToShow: {
        dialog.task = dbAccess.getTaskItem(dialog.itemId)
        taskName.text = dialog.task.name
        outcomes.value = dialog.task.outcomes
        datePicker.chosenDateTime = dialog.task.dateTime
        durationPicker.hour = dialog.task.duration / 60
        durationPicker.minute = dialog.task.duration % 60
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
                        Layout.maximumWidth: 500
                        Layout.fillWidth: true

                        onTextChanged: {
                            hasError = false
                            dialog.hasError = false
                        }

                        Connections {
                            target: dialog
                            function onCheckError() {
                                if(taskName.length <= 0) {
                                    dialog.hasError = true
                                    taskName.hasError = true
                                    taskNameError.text = "This field is required and cannot be empty"
                                    scrollView.ScrollBar.vertical.position = 0.0
                                }
                            }
                        }
                    }

                    Text {
                        id: taskNameError
                        visible: taskName.hasError
                        verticalAlignment: Text.AlignBottom
                        color: "red"
                        font.pixelSize: Comp.Globals.fontSize.small
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
