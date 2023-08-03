import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Pane {
    id: pane
    implicitWidth: 200
    implicitHeight: 300

    property date selectedTime: new Date()
    signal selectTime

    RowLayout {
        anchors.fill: parent

        ListView {
            id: hourListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: parseInt(pane.selectedTime.toLocaleTimeString(Qt.locale, "hh AP").substring(0,2)) - 1
            clip: true

            delegate: ItemDelegate {
                width: hourListView.width
                text: (model.index + 1).toString().padStart(2,"0")
                highlighted: ListView.isCurrentItem
                display: ItemDelegate.TextUnderIcon
                enabled: model.index < 12
                visible: model.index < 12

                onClicked: {
                    ListView.view.currentIndex = model.index
                    ListView.view.positionViewAtIndex(model.index, ListView.Beginning)
                    pane.selectedTime.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())
                    pane.selectTime()
                }
            }

            model: 20
        }

        ListView {
            id: minuteListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: pane.selectedTime.getMinutes()
            clip: true

            delegate: ItemDelegate {
                width: minuteListView.width
                text: model.index.toString().padStart(2,"0")
                highlighted: ListView.isCurrentItem
                display: ItemDelegate.TextUnderIcon
                enabled: model.index < 60
                visible: model.index < 60

                onClicked: {
                    ListView.view.currentIndex = model.index
                    ListView.view.positionViewAtIndex(model.index, ListView.Beginning)
                    pane.selectedTime.setMinutes(model.index)
                    pane.selectTime()
                }
            }

            model: 69
        }

        ListView {
            id: amPmListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: Math.floor(pane.selectedTime.getHours() / 12)
            clip: true

            delegate: ItemDelegate {
                width: amPmListView.width
                text: model.ap
                highlighted: ListView.isCurrentItem
                enabled: model.index < 2
                visible: model.index < 2
                display: ItemDelegate.TextUnderIcon

                onClicked: {
                    ListView.view.currentIndex = model.index
                    ListView.view.positionViewAtIndex(model.index, ListView.Beginning)
                    pane.selectedTime.setHours(Date.fromLocaleTimeString(Qt.locale(), hourListView.currentItem.text + ":" + minuteListView.currentItem.text + " " + amPmListView.currentItem.text, "hh:mm AP").getHours())
                    pane.selectTime()
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
}
