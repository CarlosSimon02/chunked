import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "." as Pop

RowLayout {
    id: rowLayout

    property date chosenTime
    signal chooseTime
    property bool hasStartTime: false
    property date startTime

    Comp.ListView {
        id: hourListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenTime.getHours()
        clip: true
        spacing: 8
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Comp.Button {
            id: hourDelegate
            width: 42
            horizontalPadding: 0
            text: (model.index).toString().padStart(2,"0")
            font.strikeout: !enabled
            enabled: model.index < 24 ||
                     (rowLayout.hasStartTime ?
                         time < rowLayout.startTime : true)
            visible: model.index < 24
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time

            Component.onCompleted: {
                time = rowLayout.chosenTime
                time.setHours(model.index)
            }

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setHours(model.index)
                rowLayout.chooseTime()
            }

            Connections {
                target: rowLayout
                function onChosenTimeChanged() {
                    hourDelegate.time = rowLayout.chosenTime
                    hourDelegate.time.setHours(model.index)
                     console.log("run")
                }
            }
        }

        model: 32
    }

    Comp.ListView {
        id: minuteListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenTime.getMinutes()
        clip: true
        spacing: 8
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Comp.Button {
            id: minuteDelegate
            width: 42
            horizontalPadding: 0
            text: model.index.toString().padStart(2,"0")
            font.strikeout: !enabled
            enabled: model.index < 60 ||
                     (rowLayout.hasStartTime ?
                         time < rowLayout.startTime : true)
            visible: model.index < 60
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time

            Component.onCompleted: {
                time = rowLayout.chosenTime
                time.setMinutes(model.index)
            }

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setMinutes(model.index)
                rowLayout.chooseTime()
            }

            Connections {
                target: rowLayout
                function onChosenTimeChanged() {
                    minuteDelegate.time = rowLayout.chosenTime
                    minuteDelegate.time.setMinutes(model.index)
                    console.log("run")
                }
            }
        }

        model: 68
    }
}
