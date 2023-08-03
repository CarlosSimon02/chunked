import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as App

ColumnLayout {
    property alias label: label.text
    property alias startDateTime: startDateTimeButton.date
    property alias endDateTime: endDateTimeButton.date

    Text {
        id: label
    }

    TabBar {
        id: tabBar

        TabButton {
            id: startDateTimeButton
            property date date: new Date()

            contentItem: ColumnLayout {
                Text {
                    text: "Start"
                }

                Text {
                    text: startDateTimeButton.date.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                }
            }
        }

        TabButton {
            id: endDateTimeButton
            property date date: new Date()

            contentItem: ColumnLayout {
                Text {
                    text: "End"
                }

                Text {
                    text: endDateTimeButton.date.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                }
            }
        }
    }

    SwipeView {
        Layout.preferredWidth: 500
        Layout.preferredHeight: 300
        currentIndex: tabBar.currentIndex
        clip: true
        interactive: false

        Pane {
            RowLayout {
                anchors.fill: parent

                App.DatePicker {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    selectedDate: startDateTimeButton.date
                    onSelectDate: {
                        startDateTimeButton.date = selectedDate
                    }
                }

                App.TimePicker {
                    Layout.fillHeight: true
                    selectedTime: startDateTimeButton.date
                    onSelectTime: {
                        startDateTimeButton.date.setTime(selectedTime.getTime())
                    }
                }
            }
        }

        Pane {
            RowLayout {
                anchors.fill: parent

                App.DatePicker {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    selectedDate: endDateTimeButton.date
                    onSelectDate: {
                        endDateTimeButton.date = selectedDate
                    }
                }

                App.TimePicker {
                    Layout.fillHeight: true
                    selectedTime: endDateTimeButton.date
                    onSelectTime: {
                        endDateTimeButton.date.setTime(selectedTime.getTime())
                    }
                }
            }
        }
    }
}
