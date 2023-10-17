import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "." as Pop

RowLayout {
    id: rowLayout

    //in minutes
    property int duration: (hourListView.currentIndex * 60) + minuteListView.currentIndex
    property alias hour: hourListView.currentIndex
    property alias minute: minuteListView.currentIndex

    ListView {
        id: hourListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: 1
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

            onClicked: {
                ListView.view.currentIndex = model.index
            }
        }

        model: 32
    }

    ListView {
        id: minuteListView
        Layout.preferredWidth: contentItem.childrenRect.width
        Layout.fillHeight: true
        currentIndex: 0
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

            onClicked: {
                ListView.view.currentIndex = model.index
            }
        }

        model: 68
    }
}
