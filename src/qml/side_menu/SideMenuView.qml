import QtQuick as Q
import QtQuick.Controls as Q
import QtQuick.Layouts as Q

import components as C
import "./components" as SideMenu

C.Pane {
    id: subWindowPane
    padding: 8
    property int currentIndex: listView.currentIndex

    Q.Column {
        spacing: 50

        SideMenu.MenuButton {
            id: menuButton
            anchors.horizontalCenter: listView.horizontalCenter
        }

        Q.ListView {
            id: listView
            width: 40
            height: contentItem.childrenRect.height
            interactive: false
            spacing: 10

            delegate: SideMenu.ItemDelegate {
                width: listView.width
                highlighted: Q.ListView.isCurrentItem
                text: label
                icon.source: iconSource
                opened: menuButton.highlighted
                onClicked: listView.currentIndex = model.index
            }

            model: Q.ListModel {
                Q.ListElement {
                    label: "Home"
                    iconSource: "qrc:/home_icon.svg"
                }

                Q.ListElement {
                    label: "Goals"
                    iconSource: "qrc:/goals_icon.svg"
                }

                Q.ListElement {
                    label: "Tasks"
                    iconSource: "qrc:/tasks_icon.svg"
                }

                Q.ListElement {
                    label: "Habits"
                    iconSource: "qrc:/habits_icon.svg"
                }

                Q.ListElement {
                    label: "Vision Board"
                    iconSource: "qrc:/vision_board_icon.svg"
                }

                Q.ListElement {
                    label: "Journal"
                    iconSource: "qrc:/journal_icon.svg"
                }

                Q.ListElement {
                    label: "Reports"
                    iconSource: "qrc:/reports_icon.svg"
                }

                Q.ListElement {
                    label: "Settings"
                    iconSource: "qrc:/settings_icon.svg"
                }
            }
        }

        states: Q.State {
            name: "opened"
            when: menuButton.highlighted

            Q.PropertyChanges {
                target: listView
                width: 170
            }

            Q.AnchorChanges {
                target: menuButton
                anchors.horizontalCenter: undefined
                anchors.right: listView.right
            }
        }

        transitions: Q.Transition {
            to: "opened"
            reversible: true

            Q.NumberAnimation {
                target: listView
                property: "width"
                duration: 500
                easing.type: Q.Easing.OutQuad
            }

            Q.AnchorAnimation {
                duration: 500
                easing.type: Q.Easing.OutQuad
            }
        }
    }
}
