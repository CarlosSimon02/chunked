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
        currentIndex: parseInt(rowLayout.chosenTime.toLocaleTimeString(Qt.locale, "hh AP").substring(0,2)) - 1
        clip: true
        spacing: 8
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Comp.Button {
            width: 36
            horizontalPadding: 0
            text: (model.index + 1).toString().padStart(2,"0")
            font.strikeout: !enabled
            enabled: model.index < 12 || time < rowLayout.chosenTime
            visible: model.index < 12
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time: rowLayout.chosenTime

            Component.onCompleted: time.setHours(Date.fromLocaleTimeString(Qt.locale(), text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setHours(time.getHours())
                rowLayout.chooseTime()
            }
        }

        model: 20
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
            width: 36
            horizontalPadding: 0
            text: model.index.toString().padStart(2,"0")
            font.strikeout: !enabled
            enabled: model.index < 60 || time < rowLayout.chosenTime
            visible: model.index < 60
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time: rowLayout.chosenTime
            Component.onCompleted: time.setMinutes(model.index)

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setMinutes(model.index)
                rowLayout.chooseTime()
            }
        }

        model: 68
    }

    Comp.ListView {
        id: amPmListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: Math.floor(rowLayout.chosenTime.getHours() / 12)
        clip: true
        spacing: 8
        interactive: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Comp.Button {
            width: 36
            horizontalPadding: 0
            text: model.ap
            font.strikeout: !enabled
            enabled: model.index < 2 || time < rowLayout.chosenTime
            visible: model.index < 2
            highlighted: ListView.isCurrentItem
            backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
            property date time: rowLayout.chosenTime
            Component.onCompleted: time.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + model.ap, "hh:mm AP").getHours())

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setHours()
                rowLayout.chooseTime()
            }
        }

        model: ListModel {
            ListElement {ap: "AM"}
            ListElement {ap: "PM"}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
            ListElement {ap: ""}
        }
    }
}
