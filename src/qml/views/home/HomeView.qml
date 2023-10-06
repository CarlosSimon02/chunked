import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.PageView {
    title: "Home"
    clip: true

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        spacing: 0

        ListView {
            Layout.fillHeight: true
            Layout.preferredWidth: 350
            leftMargin: 20
            rightMargin: 20
            topMargin: 20
            bottomMargin: 20
            spacing: 20
            clip: true

            delegate: Comp.GoalItemDelegate {
                width: ListView.view.width - 40
                height: 390
            }

            model: 3
        }

        ListView {
//            Layout.fillWidth: true
            Layout.preferredWidth: 500
            Layout.fillHeight: true
            rightMargin: 20
            topMargin: 20
            bottomMargin: 20
            spacing: 10
            clip: true

            delegate: Comp.TaskItemDelegate {
                width: ListView.view.width -
                       ListView.view.leftMargin -
                       ListView.view.rightMargin
                date: "Today"
                onClicked: taskInfoDrawerView.open()
            }

            model: 10
        }

        ListView {
            Layout.preferredWidth: 350
            Layout.fillHeight: true
            topMargin: 20
            bottomMargin: 20
            spacing: 10

            delegate: Comp.HabitItemDelegate {
                width: ListView.view.width - 20
                height: 260
            }

            model: 4
        }
    }
}
