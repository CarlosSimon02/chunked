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

    QtObject {
        id: internal
        property bool sameDay: chosenTime.getFullYear() === startTime.getFullYear() &&
                               chosenTime.getMonth() === startTime.getMonth() &&
                               chosenTime.getDate() === startTime.getDate()
    }

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
            width: 42
            horizontalPadding: 0
            text: (model.index).toString().padStart(2,"0")
            font.strikeout: !enabled
            enabled: model.index < 24 &&
                     (rowLayout.hasStartTime ?
                         internal.sameDay ? rowLayout.startTime.getHours() <= model.index : true : true)
            visible: model.index < 24
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setHours(model.index)
                rowLayout.chooseTime()
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
            width: 42
            horizontalPadding: 0
            text: model.index.toString().padStart(2,"0")
            font.strikeout: !enabled
            enabled: model.index < 60 &&
                     (rowLayout.hasStartTime ?
                         internal.sameDay &&
                         chosenTime.getHours() >= startTime.getHours() ?
                         rowLayout.startTime.getMinutes() < model.index : true : true)
            visible: model.index < 60
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setMinutes(model.index)
                rowLayout.chooseTime()
            }
        }

        model: 68
    }
}
