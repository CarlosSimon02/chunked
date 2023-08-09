import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

ColumnLayout {
    id: columnLayout

    property date day: new Date()
    signal chooseDay
    signal yearPickerViewButtonClicked
    readonly property var months: ["January","February","March","April","May",
    "June","July","August","September","October","November","December"]

    RowLayout {
        Comp.Button {
            text: columnLayout.months[monthGrid.month] + " " + monthGrid.year
            display: Button.TextOnly

            onClicked: columnLayout.yearPickerViewButtonClicked()
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight

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
        font.bold: true

        delegate: Comp.Text {
            text: model.narrowName
            font: dayOfWeekRow.font
            color: Comp.ColorScheme.secondaryColor.dark
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    MonthGrid {
        id: monthGrid
        Layout.fillWidth: true

        month: columnLayout.day.getMonth()
        year: columnLayout.day.getFullYear()

        delegate: Comp.Button {
            text: model.day
            display: AbstractButton.TextUnderIcon
            highlighted: columnLayout.day.getDate() === model.date.getDate() &&
                     columnLayout.day.getMonth() === model.month &&
                     columnLayout.day.getFullYear() === model.year

            onClicked: {
                columnLayout.day.setFullYear(model.year, model.month, model.day)
                columnLayout.chooseDay()
            }
        }
    }
}
