import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

RowLayout {
    id: rowLayout

    property date time
    signal chooseTime

    ListView {
        id: hourListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: parseInt(rowLayout.time.toLocaleTimeString(Qt.locale, "hh AP").substring(0,2)) - 1
        clip: true

        delegate: Comp.Button {
            width: 46
            text: (model.index + 1).toString().padStart(2,"0")
            enabled: model.index < 12
            visible: model.index < 12

            onClicked: {
                ListView.view.currentIndex = model.index
                ListView.view.positionViewAtIndex(model.index, ListView.Beginning)
                rowLayout.time.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())
                rowLayout.chooseTime()
            }
        }

        model: 20
    }

    ListView {
        id: minuteListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: rowLayout.time.getMinutes()
        clip: true

        delegate: Comp.Button {
            width: 46
            text: model.index.toString().padStart(2,"0")
            enabled: model.index < 60
            visible: model.index < 60

            onClicked: {
                ListView.view.currentIndex = model.index
                ListView.view.positionViewAtIndex(model.index, ListView.Beginning)
                rowLayout.time.setMinutes(model.index)
                rowLayout.chooseTime()
            }
        }

        model: 68
    }

    ListView {
        id: amPmListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: Math.floor(rowLayout.time.getHours() / 12)
        clip: true

        delegate: Comp.Button {
            width: 46
            text: model.ap
            enabled: model.index < 2
            visible: model.index < 2

            onClicked: {
                ListView.view.currentIndex = model.index
                ListView.view.positionViewAtIndex(model.index, ListView.Beginning)
                rowLayout.time.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())
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
        }
    }
}
