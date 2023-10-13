import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn
import "../components" as MComp

ScrollView {
    id: scrollView
    contentHeight: columnLayout.height

    property alias startDateTime: startDateTimePicker.dateTime
    property alias endDateTime: endDateTimePicker.dateTime
    property bool editMode

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

    MouseArea {
        width: scrollView.width
        height: scrollView.height
        onClicked: { scrollView.focus = false}
    }

    ColumnLayout {
        id: columnLayout
        width: scrollView.width

        ColumnLayout {
            Layout.margins: 30
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Start Time"
                }

                RowLayout {
                    spacing: 15

                    TextField {
                        id: startTime
                        Layout.maximumWidth: 500
                        Layout.fillWidth: true

                        readOnly: true
                    }

                   Btn.PageHeaderButton {
                        Layout.preferredWidth: startTime.height
                        Layout.preferredHeight: startTime.height
                        flat: true
                        icon.source: "qrc:/date_time_icon.svg"
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

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "End Time"
                }

                RowLayout {
                    spacing: 15

                    TextField {
                        id: endTime
                        Layout.maximumWidth: 500
                        Layout.fillWidth: true
                        readOnly: true
                    }

                   Btn.PageHeaderButton {
                        Layout.preferredWidth: endTime.height
                        Layout.preferredHeight: endTime.height
                        flat: true
                        icon.source: "qrc:/date_time_icon.svg"
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
