import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.delegates as Dlg
import "./components" as MComp

Comp.PageView {
    title: "Home"
    clip: true
    padding: 15

    Material.accent: Comp.Globals.color.accent.shade1

    RowLayout {
        anchors.fill: parent
        height: parent.height
        spacing: 15

        MComp.Page {
            Layout.fillHeight: true
            title: "Focus Goal"

            ListView {
                implicitWidth: 350
                height: parent.height
                spacing: 10
                clip: true

                delegate: Dlg.GoalItemDelegate {
                    width: ListView.view.width
                    height: 210
                    hasImage: false
                }

                model: 3
            }
        }

        MComp.Page {
            Layout.fillHeight: true
            Layout.fillWidth: true
            title: "Tasks for Today"

            ListView {
                anchors.fill: parent
                spacing: 10
                clip: true

                delegate: Dlg.TaskItemDelegate {
                    width: ListView.view.width
                    date: "Today"
                    onClicked: taskInfoDrawerView.open()
                }

                model: 10
            }
        }

        MComp.Page {
            Layout.fillHeight: true
            padding: 10
            title: "Check Your Habits"

            ListView {
                implicitWidth: 350
                height: parent.height
                spacing: 10
                clip: true

                delegate: Dlg.HabitItemDelegate {
                    width: ListView.view.width
                    height: 250
                }

                model: 3
            }
        }
    }
}
