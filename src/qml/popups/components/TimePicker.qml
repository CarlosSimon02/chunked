import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "." as Pop

RowLayout {
    id: rowLayout

    property date chosenTime
    signal chooseTime

    ListView {
        id: hourListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: parseInt(rowLayout.chosenTime.toLocaleTimeString(Qt.locale, "hh AP").substring(0,2)) - 1
        clip: true
        spacing: 8

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Pop.Button {
            width: 36
            horizontalPadding: 0
            text: (model.index + 1).toString().padStart(2,"0")
            enabled: model.index < 12
            visible: model.index < 12
            highlighted: ListView.isCurrentItem

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())
                rowLayout.chooseTime()
            }
        }

        model: 20
    }

    ListView {
        id: minuteListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.chosenTime.getMinutes()
        clip: true
        spacing: 8

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Pop.Button {
            width: 36
            horizontalPadding: 0
            text: model.index.toString().padStart(2,"0")
            enabled: model.index < 60
            visible: model.index < 60
            highlighted: ListView.isCurrentItem

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setMinutes(model.index)
                rowLayout.chooseTime()
            }
        }

        model: 68
    }

    ListView {
        id: amPmListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: Math.floor(rowLayout.chosenTime.getHours() / 12)
        clip: true
        spacing: 8

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Beginning)

        delegate: Pop.Button {
            width: 36
            horizontalPadding: 0
            text: model.ap
            enabled: model.index < 2
            visible: model.index < 2
            highlighted: ListView.isCurrentItem

            onClicked: {
                ListView.view.currentIndex = model.index
                rowLayout.chosenTime.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())
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
