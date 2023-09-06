import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "." as Pop

RowLayout {
    id: rowLayout

    property date chosenDateTime
    signal chooseTime
    property bool hasStartDateTime: false
    property date startDateTime

    Comp.ListView {
        id: hourListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenDateTime.getHours()
        clip: true
        spacing: 8
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Comp.Button {
            id: hourListViewDelegate
            width: 42
            horizontalPadding: 0
            text: (model.index).toString().padStart(2,"0")
            font.strikeout: !enabled
            visible: model.index < 24
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenDateTime.setHours(model.index)
                rowLayout.chooseTime()
            }

            Component.onCompleted: {
                time = rowLayout.chosenDateTime
                time.setHours(model.index)
                enabled = model.index < 24 && rowLayout.hasStartDateTime ? rowLayout.startDateTime <= time : true
            }

            Connections {
                target: rowLayout
                function onChosenDateTimeChanged() {
                    hourListViewDelegate.time = rowLayout.chosenDateTime
                    hourListViewDelegate.time.setHours(model.index)
                    hourListViewDelegate.enabled = model.index < 24 && rowLayout.hasStartDateTime ? rowLayout.startDateTime <= hourListViewDelegate.time : true
                }

                function onStartDateTimeChanged() {
                    hourListViewDelegate.enabled = model.index < 24 && rowLayout.hasStartDateTime ? rowLayout.startDateTime <= hourListViewDelegate.time : true
                }
            }
        }

        model: 32
    }

    Comp.ListView {
        id: minuteListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenDateTime.getMinutes()
        clip: true
        spacing: 8
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Comp.Button {
            id: minuteListViewDelegate
            width: 42
            horizontalPadding: 0
            text: model.index.toString().padStart(2,"0")
            font.strikeout: !enabled
            visible: model.index < 60
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenDateTime.setMinutes(model.index)
                rowLayout.chooseTime()
            }

            Component.onCompleted: {
                time = rowLayout.chosenDateTime
                time.setMinutes(model.index)
                enabled = model.index < 24 && rowLayout.hasStartDateTime ? rowLayout.startDateTime < time : true
            }

            Connections {
                target: rowLayout
                function onChosenDateTimeChanged() {
                    minuteListViewDelegate.time = rowLayout.chosenDateTime
                    minuteListViewDelegate.time.setMinutes(model.index)
                    minuteListViewDelegate.enabled = model.index < 60 && rowLayout.hasStartDateTime ? rowLayout.startDateTime < minuteListViewDelegate.time : true
                }

                function onStartDateTimeChanged() {
                    minuteListViewDelegate.enabled = model.index < 60 && rowLayout.hasStartDateTime ? rowLayout.startDateTime < minuteListViewDelegate.time : true
                }
            }
        }

        model: 68
    }
}
