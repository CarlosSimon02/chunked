import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Item {
    implicitWidth: 500
    implicitHeight: 520

    property alias startDateTimeText: startButton.text
    property alias endDateTimeText: endButton.text

    function reset() {
        var date = new Date()
        date.setHours(0,0)
        startButton.chosenDateTime = date
        startDatePicker.chosenDateTime = date
        startTimePicker.chosenDateTime = date

        date.setDate(date.getDate() + 1)
        endButton.chosenDateTime = date
        endDatePicker.chosenDateTime = date
        endTimePicker.chosenDateTime = date

        swipeView.currentIndex = 0
    }

    Component.onCompleted: reset()

    ColumnLayout {
        anchors.fill: parent
        spacing: 40

        RowLayout {
            Layout.leftMargin: 2
            spacing: 15

            Comp.FieldColumnLayout {
                Comp.FieldLabel {
                    text: "Start"
                }

                Comp.Button {
                    id: startButton
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    property date chosenDateTime
                    text: chosenDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                    highlighted: true
                    border.width: 1
                    verticalPadding: 14

                    onClicked: {
                        highlighted = true
                        endButton.highlighted = false
                        swipeView.currentIndex = 0
                    }
                }
            }

            Comp.FieldColumnLayout {
                Comp.FieldLabel {
                    text: "End"
                }

                Comp.Button {
                    id: endButton
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    property date chosenDateTime
                    text: chosenDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                    verticalPadding: 14
                    border.width: 1

                    onClicked: {
                        highlighted = true
                        startButton.highlighted = false
                        swipeView.currentIndex = 1
                    }
                }
            }
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.leftMargin: 2
            currentIndex: 0
            clip: true

            RowLayout {
                spacing: 60

                Comp.DatePicker {
                    id: startDatePicker
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop

                    onChooseDate: {
                        startButton.chosenDateTime = chosenDateTime
                        startTimePicker.chosenDateTime = chosenDateTime

                        if(startButton.chosenDateTime >= endButton.chosenDateTime)
                        {
                            endButton.chosenDateTime = startButton.chosenDateTime
                            endButton.chosenDateTime.setMinutes(endButton.chosenDateTime.getMinutes() + 1)
                            endDatePicker.chosenDateTime = endButton.chosenDateTime
                            endTimePicker.chosenDateTime = endButton.chosenDateTime
                        }
                    }
                }

                Comp.TimePicker {
                    id: startTimePicker
                    Layout.maximumHeight: startDatePicker.height

                    onChooseTime: {
                        startButton.chosenDateTime = chosenDateTime
                        startDatePicker.chosenDateTime = chosenDateTime

                        if(startButton.chosenDateTime >= endButton.chosenDateTime)
                        {
                            endButton.chosenDateTime = startButton.chosenDateTime
                            endButton.chosenDateTime.setMinutes(endButton.chosenDateTime.getMinutes() + 1)
                            endDatePicker.chosenDateTime = endButton.chosenDateTime
                            endTimePicker.chosenDateTime = endButton.chosenDateTime
                        }
                    }
                }
            }

            RowLayout {
                spacing: 60

                Comp.DatePicker {
                    id: endDatePicker
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop
                    hasStartDateTime: true
                    startDateTime: startDatePicker.chosenDateTime

                    onChooseDate: {
                        endButton.chosenDateTime = chosenDateTime
                        endTimePicker.chosenDateTime = chosenDateTime

                        if(startButton.chosenDateTime >= endButton.chosenDateTime)
                        {
                            endButton.chosenDateTime = startButton.chosenDateTime
                            endButton.chosenDateTime.setMinutes(endButton.chosenDateTime.getMinutes() + 1)
                            endDatePicker.chosenDateTime = endButton.chosenDateTime
                            endTimePicker.chosenDateTime = endButton.chosenDateTime
                        }
                    }
                }

                Comp.TimePicker {
                    id: endTimePicker
                    Layout.maximumHeight: endDatePicker.height
                    hasStartDateTime: true
                    startDateTime: startDatePicker.chosenDateTime

                    onChooseTime: {
                        endButton.chosenDateTime = chosenDateTime
                        endTimePicker.chosenDateTime = chosenDateTime
                    }
                }
            }
        }
    }
}
