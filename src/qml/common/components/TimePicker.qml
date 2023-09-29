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

    ListView {
        id: hourListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenDateTime.getHours()
        clip: true
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: RoundButton {
            id: hourListViewDelegate
            width: height
            topInset: 2
            leftInset: 2
            rightInset: 2
            bottomInset: 2
            text: (model.index).toString().padStart(2,"0")
            font.pixelSize: Comp.Globals.fontSize.medium
            visible: model.index < 24
            highlighted: ListView.isCurrentItem
            flat: !highlighted

            Material.accent: Comp.Globals.color.accent.shade1

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

    ListView {
        id: minuteListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenDateTime.getMinutes()
        clip: true
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: RoundButton {
            id: minuteListViewDelegate
            width: height
            topInset: 2
            leftInset: 2
            rightInset: 2
            bottomInset: 2
            font.pixelSize: Comp.Globals.fontSize.medium
            text: model.index.toString().padStart(2,"0")
            visible: model.index < 60
            highlighted: ListView.isCurrentItem
            flat: !highlighted

            Material.accent: Comp.Globals.color.accent.shade1

            property date time

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenDateTime.setMinutes(model.index)
                rowLayout.chooseTime()
            }

            Component.onCompleted: {
                time = rowLayout.chosenDateTime
                time.setMinutes(model.index)
                enabled = model.index < 24 && rowLayout.hasStartDateTime ?
                            rowLayout.startDateTime < time : true
            }

            Connections {
                target: rowLayout
                function onChosenDateTimeChanged() {
                    minuteListViewDelegate.time = rowLayout.chosenDateTime
                    minuteListViewDelegate.time.setMinutes(model.index)
                    minuteListViewDelegate.enabled = model.index < 60 && rowLayout.hasStartDateTime ?
                                rowLayout.startDateTime < minuteListViewDelegate.time : true
                }

                function onStartDateTimeChanged() {
                    minuteListViewDelegate.enabled = model.index < 60 && rowLayout.hasStartDateTime ?
                                rowLayout.startDateTime < minuteListViewDelegate.time : true
                }
            }
        }

        model: 68
    }
}
