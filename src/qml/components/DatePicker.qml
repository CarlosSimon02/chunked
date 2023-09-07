import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

StackView {
    id: stackView
    implicitWidth: 350
    implicitHeight: 350

    clip: true

    property date chosenDateTime: new Date()
    property bool hasStartDateTime: false
    property date startDateTime
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
                    Layout.preferredWidth: implicitWidth
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

                month: stackView.chosenDateTime.getMonth()
                year: stackView.chosenDateTime.getFullYear()

                delegate: Comp.Button {
                    id: monthGridDelegate
                    text: model.day
                    opacity: monthGrid.month === model.month ? 1.0 : 0.3
                    highlighted: stackView.chosenDateTime.getDate() === model.date.getDate() &&
                             stackView.chosenDateTime.getMonth() === model.month &&
                             stackView.chosenDateTime.getFullYear() === model.year
                    foregroundColor: enabled ? highlighted ? Comp.ColorScheme.accentColor.regular : Comp.ColorScheme.secondaryColor.regular : "red"
                    backgroundColor: enabled ? highlighted ? Comp.Utils.setColorAlpha(foregroundColor, 0.1) : "transparent" : Comp.Utils.setColorAlpha(foregroundColor, 0.1)

                    onClicked: {
                        stackView.chosenDateTime.setFullYear(model.year, model.month, model.day)
                        stackView.chooseDate()
                    }

                    function setEnabled() {
                        model.date.setHours(stackView.chosenDateTime.getHours(),stackView.chosenDateTime.getMinutes())
                        enabled = stackView.hasStartDateTime ? stackView.startDateTime < model.date : true
                    }

                    Component.onCompleted: {
                        setEnabled()
                    }

                    Connections {
                        target: stackView
                        function onChosenDateTimeChanged() {
                            monthGridDelegate.setEnabled()
                        }

                        function onStartDateTimeChanged() {
                            monthGridDelegate.setEnabled()
                        }
                    }

                    Connections {
                        target: monthGrid
                        function onMonthChanged() {
                            monthGridDelegate.setEnabled()
                        }
                        function onYearChanged() {
                            monthGridDelegate.setEnabled()
                        }
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
                    text: monthGrid.year
                    onClicked: stackView.push(yearPicker)
                }

                GridView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: width / 3
                    cellHeight: height / 4

                    delegate: Comp.Button {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: stackView.months[model.index]
                        highlighted: model.index === monthGrid.month
                        backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"

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

                    property int startingYear: Math.floor(stackView.chosenDateTime.getFullYear() / 16) * 16

                    delegate: Comp.Button {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: gridView.startingYear + model.index
                        display: IconLabel.TextUnderIcon
                        highlighted: (gridView.startingYear + model.index) === monthGrid.year
                        backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"

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
