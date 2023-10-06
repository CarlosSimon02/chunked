import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./components" as MComp
import "./views/filter"
import "./views/task_info_drawer"

RowLayout {
    id: rowLayout
    property bool isSubGoal: false
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

            Comp.IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                Layout.alignment: Qt.AlignVCenter
                Layout.bottomMargin: 10
                icon.source: "qrc:/filter_icon.svg"
                visible: !filterView.visible
                icon.width: 25
                icon.height: 25

                onClicked: filterDrawerView.open()
            }
        }

        section.property: "date"
        section.delegate: Label {
            topPadding: 10
            bottomPadding: 10
            required property string section
            text: section
            color: Comp.Globals.color.secondary.shade2
            font.pixelSize: Comp.Globals.fontSize.small
        }

        ScrollBar.vertical: ScrollBar {
            parent: listView
            x: listView.width - width
            height: listView.height
        }

        delegate: Comp.TaskItemDelegate {
            width: ListView.view.width -
                   ListView.view.leftMargin -
                   ListView.view.rightMargin
            date: "Today"
            onClicked: taskInfoDrawerView.open()
        }

        model: ListModel {
            ListElement {
                date: "Today"
            }

            ListElement {
                date: "Today"
            }

            ListElement {
                date: "Today"
            }

            ListElement {
                date: "Today"
            }
        }
    }

    FilterView {
        id: filterView
        Layout.topMargin: 30
        Layout.rightMargin: 30
        Layout.alignment: Qt.AlignTop
        visible: !rowLayout.isSubGoal && window.width > 1200
    }

    FilterDrawerView {
        id: filterDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }

    TaskInfoDrawerView {
        id: taskInfoDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }
}
