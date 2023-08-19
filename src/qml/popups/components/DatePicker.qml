import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "." as Pop

StackView {
    id: stackView
    implicitWidth: 350
    implicitHeight: 350
    clip: true

    property date chosenDate: new Date()
    signal chooseDate
    readonly property var months: ["January","February","March","April","May",
    "June","July","August","September","October","November","December"]

    initialItem: Pane {
        background: null

        ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.maximumWidth: Number.POSITIVE_INFINITY

                Comp.Button {
                    text: stackView.months[monthGrid.month] + " " + monthGrid.year
                    display: Button.TextOnly

                    onClicked: stackView.push(yearPicker)
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

                month: stackView.chosenDate.getMonth()
                year: stackView.chosenDate.getFullYear()

                delegate: Comp.Button {
                    text: model.day
                    highlighted: stackView.chosenDate.getDate() === model.date.getDate() &&
                             stackView.chosenDate.getMonth() === model.month &&
                             stackView.chosenDate.getFullYear() === model.year
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
                        stackView.chosenDate.setFullYear(model.year, model.month,model.day)
                        console.log(model.day)
                        console.log(model.month)
                        console.log(model.year)
                        console.log(stackView.chosenDate.getDate())
                        console.log(stackView.chosenDate.getMonth())
                        console.log(stackView.chosenDate.getFullYear())
                        stackView.chooseDate()
                    }
                }
            }
        }
    }

    Component {
        id: monthPicker

        Pane {
            background: null

            ColumnLayout {
                anchors.fill: parent

                Comp.Button {
                    text: stackView.chosenDate.getFullYear().toString()
                    onClicked: stackView.sourceComponent = yearPicker
                }

                GridView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: width / 3
                    cellHeight: height / 4

                    delegate: Pop.Button {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: stackView.months[model.index]
                        highlighted: model.index === stackView.chosenDate.getMonth()

                        onClicked: {
                            monthGrid.month = model.index
                            stackView.pop()
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

                    property int startingYear: Math.floor(stackView.chosenDate.getFullYear() / 16) * 16

                    delegate: Pop.Button {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: gridView.startingYear + model.index
                        display: IconLabel.TextUnderIcon
                        highlighted: (gridView.startingYear + model.index) === stackView.chosenDate.getFullYear()

                        onClicked: {
                            monthGrid.year = gridView.startingYear + model.index
                            stackView.replace(monthPicker)
                        }
                    }

                    model: 16
                }
            }
        }
    }
}
