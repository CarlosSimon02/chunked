import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

StackView {
    id: stackView

    property date chosenDateTime: new Date()
    property date startDateTime
    property bool hasStartDateTime: false
    signal chooseDate
    readonly property var months: ["January","February","March","April","May",
    "June","July","August","September","October","November","December"]

    implicitWidth: 350
    implicitHeight: 350
    clip: true

    initialItem: Pane {
        background: null
        padding: 0

        ColumnLayout {
            anchors.fill: parent

            RowLayout {
                Layout.maximumWidth: Number.POSITIVE_INFINITY

                Text {
                    text: stackView.months[monthGrid.month] + " " + monthGrid.year
                    color: Comp.Globals.color.secondary.shade4
                    font.pixelSize: Comp.Globals.fontSize.large
                    font.weight: Font.DemiBold

                    MouseArea {
                        anchors.fill: parent
                        onClicked: stackView.push(yearPicker)
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 0

                    IconLabel {
                        icon.source: "qrc:/arrow_left_icon.svg"
                        icon.width: 24
                        icon.height: 24
                        icon.color: Comp.Globals.color.secondary.shade4

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                let prevMonth = monthGrid.month - 1
                                monthGrid.month = ((prevMonth % 12) + 12) % 12
                                monthGrid.year -= (((prevMonth % 12) + 12) % 12 === 11)
                            }
                        }
                    }

                    IconLabel {
                        icon.source: "qrc:/arrow_right_icon.svg"
                        icon.width: 24
                        icon.height: 24
                        icon.color: Comp.Globals.color.secondary.shade4

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                let nextMonth = monthGrid.month + 1
                                monthGrid.month = nextMonth % 12
                                monthGrid.year += (nextMonth % 12 === 0)
                            }
                        }
                    }
                }
            }

            DayOfWeekRow {
                id: dayOfWeekRow
                Layout.fillWidth: true
                font.pointSize: Comp.Globals.fontSize.superSmall
                font.weight: Font.Normal

                delegate: Text {
                    text: model.narrowName
                    font: dayOfWeekRow.font
                    color: Comp.Globals.color.secondary.shade1
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            MonthGrid {
                id: monthGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 2

                month: stackView.chosenDateTime.getMonth()
                year: stackView.chosenDateTime.getFullYear()

                delegate: RoundButton {
                    id: monthGridDelegate
                    topInset: 2
                    leftInset: 2
                    rightInset: 2
                    bottomInset: 2
                    flat: !highlighted
                    font.pixelSize: Comp.Globals.fontSize.medium
                    text: model.day
                    opacity: monthGrid.month === model.month ? 1.0 : 0.0
                    highlighted: stackView.chosenDateTime.getDate() === model.date.getDate() &&
                             stackView.chosenDateTime.getMonth() === model.month &&
                             stackView.chosenDateTime.getFullYear() === model.year

                    Material.accent: Comp.Globals.color.accent.shade1

                    onClicked: {
                        stackView.chosenDateTime.setFullYear(model.year, model.month, model.day)
                        stackView.chooseDate()
                    }

                    function setEnabled() {
                        var tempDateTime = model.date
                        tempDateTime.setHours(stackView.chosenDateTime.getHours(),stackView.chosenDateTime.getMinutes())
                        enabled = stackView.hasStartDateTime ? stackView.startDateTime < tempDateTime :
                                                               monthGrid.month === model.month
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
            padding: 0

            ColumnLayout {
                anchors.fill: parent

                Text {
                    text: monthGrid.year
                    color: Comp.Globals.color.secondary.shade4
                    font.pixelSize: Comp.Globals.fontSize.large
                    font.weight: Font.DemiBold

                    MouseArea {
                        anchors.fill: parent
                        onClicked: stackView.push(yearPicker)
                    }
                }

                GridView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: width / 3
                    cellHeight: height / 4
                    interactive: false

                    delegate: RoundButton {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: stackView.months[model.index]
                        font.pixelSize: Comp.Globals.fontSize.medium
                        highlighted: model.index === monthGrid.month
                        flat: !highlighted
                        radius: Material.SmallScale

                        Material.accent: Comp.Globals.color.accent.shade1

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
            padding: 0

            ColumnLayout {
                anchors.fill: parent

                RowLayout {
                    Layout.maximumWidth: Number.POSITIVE_INFINITY

                    Text {
                        text: (gridView.startingYear).toString() + "-" + (gridView.startingYear + 15).toString()
                        color: Comp.Globals.color.secondary.shade4
                        font.pixelSize: Comp.Globals.fontSize.large
                        font.weight: Font.DemiBold
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignRight
                        spacing: 0

                        IconLabel {
                            icon.source: "qrc:/arrow_left_icon.svg"
                            icon.width: 24
                            icon.height: 24
                            icon.color: Comp.Globals.color.secondary.shade4

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    gridView.startingYear -= 16
                                }
                            }
                        }

                        IconLabel {
                            icon.source: "qrc:/arrow_right_icon.svg"
                            icon.width: 24
                            icon.height: 24
                            icon.color: Comp.Globals.color.secondary.shade4

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    gridView.startingYear += 16
                                }
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
                    interactive: false

                    property int startingYear: Math.floor(stackView.chosenDateTime.getFullYear() / 16) * 16

                    delegate: RoundButton {
                        width: GridView.view.cellWidth
                        height: GridView.view.cellHeight
                        text: gridView.startingYear + model.index
                        highlighted: (gridView.startingYear + model.index) === monthGrid.year
                        flat: !highlighted
                        radius: Material.SmallScale
                        font.pixelSize: Comp.Globals.fontSize.medium

                        Material.accent: Comp.Globals.color.accent.shade1

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
