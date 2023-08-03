import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Pane {
    id: pane
    implicitWidth: 300
    implicitHeight: 300

    readonly property var months: ["January","February","March","April","May","June","July","August","September","October","November","December"]
    property date selectedDate: new Date()
    signal selectDate

    Loader {
        id: loader
        anchors.fill: parent
        clip: true

        sourceComponent: dayPicker

        Component {
            id: dayPicker

            Page {
                topPadding: 10

                header: Pane {
                    padding: 0

                    RowLayout {
                        width: parent.width
                        Button {
                            text: pane.months[monthGrid.month] + " " + monthGrid.year.toString()
                            onClicked: loader.sourceComponent = yearPicker
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignRight

                            Button {
                                text: "prev"
                                onClicked: {
                                    monthGrid.year = monthGrid.year + Math.floor((monthGrid.month - 1)/12)
                                    monthGrid.month = (((monthGrid.month - 1) % 12) + 12) % 12
                                }
                            }

                            Button {
                                text: "next"
                                onClicked: {
                                    monthGrid.year = monthGrid.year + Math.floor((monthGrid.month + 1)/12)
                                    monthGrid.month = (monthGrid.month + 1) % 12
                                }
                            }
                        }
                    }
                }

                ColumnLayout {
                    anchors.fill: parent

                    DayOfWeekRow {
                        Layout.fillWidth: true
                    }

                    MonthGrid {
                        id: monthGrid
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        month: pane.selectedDate.getMonth()
                        year: pane.selectedDate.getFullYear()

                        delegate: ItemDelegate {
                            height: 28
                            display: IconLabel.TextUnderIcon
                            highlighted: model.date.getDate() === pane.selectedDate.getDate() &&
                                         model.month === pane.selectedDate.getMonth() &&
                                         model.year === pane.selectedDate.getFullYear()
                            text: model.day
                            opacity: model.month === monthGrid.month
                            enabled: model.month === monthGrid.month

                            onClicked: {
                                pane.selectedDate.setFullYear(model.year,model.month,model.day)
                                pane.selectDate()
                            }
                        }
                    }
                }
            }
        }

        Component {
            id: monthPicker

            Page {
                topPadding: 10

                header: Pane {
                    padding: 0

                    Button {
                        text: pane.selectedDate.getFullYear().toString()
                        onClicked: loader.sourceComponent = yearPicker
                    }
                }

                GridView {
                    anchors.fill: parent
                    cellWidth: width / 3
                    cellHeight: height / 4

                    delegate: ItemDelegate {
                        width: parent.width / 3
                        height: parent.height / 4
                        text: pane.months[model.index]
                        display: IconLabel.TextUnderIcon
                        highlighted: model.index === pane.selectedDate.getMonth()

                        onClicked: {
                            pane.selectedDate.setMonth(model.index)
                            loader.sourceComponent = dayPicker
                        }
                    }

                    model: 12
                }
            }
        }

        Component {
            id: yearPicker

            Page {
                id: yearPickerPage
                topPadding: 10

                property int gridStartingYear: Math.floor(pane.selectedDate.getFullYear() / 16) * 16

                header: Pane {
                    padding: 0

                    RowLayout {
                        width: parent.width

                        Button {
                            text: (yearPickerPage.gridStartingYear).toString() + "-" + (yearPickerPage.gridStartingYear + 15).toString()
                        }
                    }
                }

                GridView {
                    anchors.fill: parent
                    cellWidth: width / 4
                    cellHeight: height / 4

                    delegate: ItemDelegate {
                        width: parent.width / 4
                        height: parent.height / 4
                        text: yearPickerPage.gridStartingYear + model.index
                        display: IconLabel.TextUnderIcon
                        highlighted: (yearPickerPage.gridStartingYear + model.index) === pane.selectedDate.getFullYear()

                        onClicked: {
                            pane.selectedDate.setFullYear(yearPickerPage.gridStartingYear + model.index)
                            loader.sourceComponent = monthPicker
                        }
                    }

                    model: 16
                }
            }
        }
    }
}


