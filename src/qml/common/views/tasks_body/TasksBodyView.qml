import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./components" as MComp
import "./views"

RowLayout {
    Material.accent: Comp.Globals.color.accent.shade1

    ListView {
        id: listView
        Layout.fillWidth: true
        Layout.fillHeight: true
        leftMargin: 30
        rightMargin: 30
        topMargin: 30
        bottomMargin: 30
        spacing: 10
        clip: true
        header: RowLayout {
            width: parent.width
            MComp.CreateTaskTextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                Layout.bottomMargin: 10
            }
        }

        ScrollBar.vertical: ScrollBar {
            parent: listView
            x: listView.width - width
            height: listView.height
        }

        delegate: MComp.TaskItemDelegate {
            width: ListView.view.width -
                   ListView.view.leftMargin -
                   ListView.view.rightMargin
            height: 45
        }

        model: 10
    }

    FilterView {
        Layout.topMargin: 30
        Layout.rightMargin: 30
        Layout.alignment: Qt.AlignTop
    }
}
