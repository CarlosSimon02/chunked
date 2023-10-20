import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp
import components.inputs as Inpt
import components.buttons as Btn

Comp.ItemCreateEditDialog {
    id: dialog

    signal checkError
    property int itemId: 0
    property Task task
    property bool hasError

    title: itemId ? "Edit Habit" : "Create Habit"
    width: 390
    height: 700

    onCancel: dialog.close()

    onSave: {
        checkError()

        if(!dialog.hasError) {
            dialog.task.name = habitName.text
            dialog.task.outcomes = outcomes.value
            dialog.task.dateTime = datePicker.chosenDateTime
            dialog.task.duration = durationPicker.duration

            dbAccess.updateTaskItem(dialog.task)
            listView.model.refresh()
            habitItem.dataChanged()
            dialog.close()
        }
        else habitName.focus = true
    }


    onAboutToShow: {
        dialog.task = dbAccess.getTaskItem(dialog.itemId)
        habitName.text = dialog.task.name
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
                        text: "Habit Name"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    Inpt.TextField {
                        id: habitName
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45

                        onTextChanged: {
                            hasError = false
                            dialog.hasError = false
                        }

                        Connections {
                            target: dialog
                            function onCheckError() {
                                if(habitName.length <= 0) {
                                    dialog.hasError = true
                                    habitName.hasError = true
                                    habitNameError.text = "This field is required and cannot be empty"
                                    scrollView.ScrollBar.vertical.position = 0.0
                                }
                            }
                        }
                    }

                    Text {
                        id: habitNameError
                        visible: habitName.hasError
                        verticalAlignment: Text.AlignBottom
                        color: "red"
                        font.pixelSize: Comp.Globals.fontSize.small
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Category"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    Inpt.ComboBox {
                        id: category
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Frequency"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    Inpt.ComboBox {
                        id: frequency
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Start Time"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    RowLayout {
                        spacing: 15

                        TextField {
                            id: startTime
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 45
                            Layout.fillWidth: true

                            readOnly: true
                        }

                       Btn.PageHeaderButton {
                            Layout.preferredWidth: startTime.height
                            Layout.preferredHeight: startTime.height
                            flat: true
                            icon.source: "qrc:/date_time_icon.svg"
                            icon.width: 24
                            icon.height: 24
                            icon.color: Comp.Globals.color.secondary.shade1

                            Material.roundedScale: Material.SmallScale

                            onClicked: startDateTimePicker.open()

                            Comp.DateTimePickerDialog {
                                id: startDateTimePicker

                                onAccepted: {
                                    startTime.text = dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                    if(startDateTimePicker.dateTime > endDateTimePicker.dateTime) {
                                        endDateTimePicker.dateTime = startDateTimePicker.dateTime
                                        endDateTimePicker.dateTime.setDate(endDateTimePicker.dateTime.getDate() + 1)
                                        endTime.text = endDateTimePicker.dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                    }
                                }

                                onRejected: {
                                    startDateTimePicker.dateTime = Date.fromLocaleString(Qt.locale(), startTime.text, "dd MMM yyyy hh:mm AP")
                                }
                            }
                        }
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "End Time"
                        font.pixelSize: Comp.Globals.fontSize.medium
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    RowLayout {
                        spacing: 15

                        TextField {
                            id: endTime
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 45
                            Layout.fillWidth: true
                            readOnly: true
                        }

                       Btn.PageHeaderButton {
                            Layout.preferredWidth: endTime.height
                            Layout.preferredHeight: endTime.height
                            flat: true
                            icon.source: "qrc:/date_time_icon.svg"
                            icon.width: 24
                            icon.height: 24
                            icon.color: Comp.Globals.color.secondary.shade1

                            Material.roundedScale: Material.SmallScale

                            onClicked: endDateTimePicker.open()

                            Comp.DateTimePickerDialog {
                                id: endDateTimePicker
                                hasStartDateTime: true
                                startDateTime: startDateTimePicker.dateTime

                                onAccepted: {
                                    endTime.text = dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                }

                                onRejected: {
                                    endDateTimePicker.dateTime = Date.fromLocaleString(Qt.locale(), endTime.text, "dd MMM yyyy hh:mm AP")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if(!scrollView.editMode) {
            startDateTimePicker.dateTime = new Date()
            startDateTimePicker.dateTime.setHours(0,0)
            endDateTimePicker.dateTime = startDateTimePicker.dateTime
            endDateTimePicker.dateTime.setDate(endDateTimePicker.dateTime.getDate() + 1)
        }

        startTime.text = startDateTimePicker.dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
        endTime.text = endDateTimePicker.dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
    }
}
