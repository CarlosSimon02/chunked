import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Item {
    implicitWidth: 500
    implicitHeight: 520

    property alias startDateTimeText: startButton.text
    property alias endDateTimeText: endButton.text

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
                    property date chosenDate
                    text: chosenDate.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                    highlighted: true
                    border.width: 1
                    verticalPadding: 14

                    onClicked: {
                        highlighted = true
                        endButton.highlighted = false
                        swipeView.currentIndex = 0
                    }

                    Component.onCompleted: {
                        var date = new Date()
                        date.setHours(0,0)
                        chosenDate = date
                        startDatePicker.chosenDate = date
                        startTimePicker.chosenTime = date
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
                    property date chosenDate
                    text: chosenDate.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                    verticalPadding: 14
                    border.width: 1

                    onClicked: {
                        highlighted = true
                        startButton.highlighted = false
                        swipeView.currentIndex = 1
                    }

                    Component.onCompleted: {
                        var date = new Date()
                        date.setDate(date.getDate() + 1)
                        date.setHours(0,0)
                        chosenDate = date
                        endDatePicker.chosenDate = date
                        endTimePicker.chosenTime = date
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

                    onChooseDate: startButton.chosenDate.setFullYear(chosenDate.getFullYear(),
                                                                     chosenDate.getMonth(),
                                                                     chosenDate.getDate())
                }

                Comp.TimePicker {
                    id: startTimePicker
                    Layout.maximumHeight: startDatePicker.height

                    onChooseTime: startButton.chosenDate.setHours(chosenTime.getHours(),chosenTime.getMinutes())
                }
            }

            RowLayout {
                spacing: 60

                Comp.DatePicker {
                    id: endDatePicker
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop

                    onChooseDate: endButton.chosenDate.setFullYear(chosenDate.getFullYear(),
                                                                   chosenDate.getMonth(),
                                                                   chosenDate.getDate())
                }

                Comp.TimePicker {
                    id: endTimePicker
                    Layout.maximumHeight: endDatePicker.height

                    onChooseTime: endButton.chosenDate.setHours(chosenTime.getHours(),chosenTime.getMinutes())
                }
            }
        }
    }
}
