import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.PageView {
    title: "Home"
    clip: true
    padding: 20

    RowLayout {
        anchors.fill: parent
        height: parent.height
        spacing: 20

        Page {
            Layout.fillHeight: true
            padding: 10
            background: Rectangle {
                radius: Material.SmallScale
                color: Comp.Globals.color.primary.shade1
            }

            header: Frame {
                horizontalPadding: 10
//                height: 40
                bottomPadding: 10
                background: Item {
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        width: parent.width
                        height: 2
                        color: Comp.Globals.color.primary.shade2
                    }
                }

                RowLayout {
                    Text {
                        text: "Focus Goals"
                        color: Comp.Globals.color.secondary.shade2
                        font.pixelSize: Comp.Globals.fontSize.medium
                    }
                }
            }

            ListView {
                implicitWidth: 350
                height: parent.height
                spacing: 10
                clip: true

                delegate: Comp.GoalItemDelegate {
                    width: ListView.view.width
                    height: 210
                    hasImage: false
                }

                model: 3
            }
        }

        Page {
            Layout.fillWidth: true
            Layout.fillHeight: true
            padding: 0
            header: RowLayout {
                height: 30

                Text {
                    Layout.alignment: Qt.AlignTop
                    text: "Task for Today"
                    color: Comp.Globals.color.secondary.shade2
                    font.pixelSize: Comp.Globals.fontSize.medium
                }
            }
            ListView {
                anchors.fill: parent
                spacing: 10
                clip: true

                delegate: Comp.TaskItemDelegate {
                    width: ListView.view.width
                    date: "Today"
                    onClicked: taskInfoDrawerView.open()
                }

                model: 10
            }
        }

        Page {
            Layout.fillHeight: true
            padding: 0

            header: RowLayout {
                height: 30
                Text {
                    Layout.alignment: Qt.AlignTop
                    text: "Focus Goals"
                    color: Comp.Globals.color.secondary.shade2
                    font.pixelSize: Comp.Globals.fontSize.medium
                }
            }
            ListView {
                implicitWidth: 350
                height: parent.height
                spacing: 10
                clip: true

                delegate: Comp.HabitItemDelegate {
                    width: ListView.view.width
                    height: 250
                }

                model: 3
            }
        }

//        ListView {
//            Layout.preferredWidth: 350
//            Layout.fillHeight: true
//            topMargin: 20
//            bottomMargin: 20
//            spacing: 10

//            delegate: Comp.HabitItemDelegate {
//                width: ListView.view.width - 20
//                height: 250
//            }

//            model: 4
//        }
    }
}
