import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "." as Pop

Loader {
    id: loader

    property date currentDate: new Date()
    readonly property var months: ["January","February","March","April","May",
    "June","July","August","September","October","November","December"]

    sourceComponent: dayPicker

    Component {
        id: dayPicker

        Pane {
            implicitWidth: 350
            implicitHeight: 350
            background: null

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    Layout.maximumWidth: Number.POSITIVE_INFINITY

                    Comp.Button {
                        text: loader.months[monthGrid.month] + " " + monthGrid.year
                        display: Button.TextOnly

                        onClicked: loader.sourceComponent = yearPicker
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignRight
                        spacing: 0

                        Comp.Button {
                            icon.source: "qrc:/arrow_left_icon.svg"
                            display: Button.IconOnly

                            onClicked: {
                                let prevMonth = monthGrid.month - 1
                                monthGrid.month = ((prevMonth % 12) + 12) % 12
                                monthGrid.year -= (((prevMonth % 12) + 12) % 12 === 11)
                            }
                        }

                        Comp.Button {
                            icon.source: "qrc:/arrow_right_icon.svg"
                            display: Button.IconOnly

                            onClicked: {
                                let nextMonth = monthGrid.month + 1
                                monthGrid.month = nextMonth % 12
                                monthGrid.year += (nextMonth % 12 === 0)
                            }
                        }
                    }
                }

                DayOfWeekRow {
                    id: dayOfWeekRow
                    Layout.fillWidth: true
                    font.pointSize: 9
                    font.weight: Font.Normal

                    delegate: Comp.Text {
                        text: model.narrowName
                        font: dayOfWeekRow.font
                        color: Comp.ColorScheme.secondaryColor.veryDark
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                MonthGrid {
                    id: monthGrid
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    month: loader.currentDate.getMonth()
                    year: loader.currentDate.getFullYear()

                    delegate: Comp.Button {
                        text: model.day
                        highlighted: loader.currentDate.getDate() === model.date.getDate() &&
                                 loader.currentDate.getMonth() === model.month &&
                                 loader.currentDate.getFullYear() === model.year
                        foregroundColor: monthGrid.month === model.month ?
                                             highlighted ? Comp.ColorScheme.accentColor.regular :
                                                           Comp.ColorScheme.secondaryColor.regular :
                                             highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.2) :
                                                 Comp.Utils.setColorAlpha(Comp.ColorScheme.secondaryColor.regular,0.1)
                        backgroundColor: highlighted ? monthGrid.month === model.month ?
                                                           Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) :
                                                           Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.03) :
                                            "transparent"

                        onClicked: {
                            loader.currentDate.setFullYear(model.year, model.month, model.day)
                            loader.chooseDay()
                        }
                    }
                }
            }
        }
    }

    Component {
        id: monthPicker

        Pane {
            implicitWidth: 350
            implicitHeight: 350
            background: null

            ColumnLayout {
                anchors.fill: parent

                Comp.Button {
                    text: loader.currentDate.getFullYear().toString()
                    onClicked: loader.sourceComponent = yearPicker
                }

                GridView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: width / 3
                    cellHeight: height / 4

                    delegate: Pop.Button {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: loader.months[model.index]
                        highlighted: model.index === loader.currentDate.getMonth()

                        onClicked: {
                            loader.currentDate.setMonth(model.index)
                            loader.sourceComponent = dayPicker
                        }
                    }

                    model: 12
                }
            }
        }
    }

    Component {
        id: yearPicker

        Pane {
            implicitWidth: 350
            implicitHeight: 350
            background: null

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    Layout.maximumWidth: Number.POSITIVE_INFINITY

                    Comp.Button {
                        text: (gridView.startingYear).toString() + "-" + (gridView.startingYear + 15).toString()
                        display: Button.TextOnly
                        enabled: false
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignRight
                        spacing: 0

                        Comp.Button {
                            icon.source: "qrc:/arrow_left_icon.svg"
                            display: Button.IconOnly

                            onClicked: {
                                gridView.startingYear -= 16
                            }
                        }

                        Comp.Button {
                            icon.source: "qrc:/arrow_right_icon.svg"
                            display: Button.IconOnly

                            onClicked: {
                                gridView.startingYear += 16
                            }
                        }
                    }
                }

                GridView {
                    id: gridView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: width / 4
                    cellHeight: height / 4

                    property int startingYear: Math.floor(loader.currentDate.getFullYear() / 16) * 16

                    delegate: Pop.Button {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: gridView.startingYear + model.index
                        display: IconLabel.TextUnderIcon
                        highlighted: (gridView.startingYear + model.index) === loader.currentDate.getFullYear()

                        onClicked: {
                            loader.currentDate.setFullYear(gridView.startingYear + model.index)
                            loader.sourceComponent = monthPicker
                        }
                    }

                    model: 16
                }
            }
        }
    }
}
