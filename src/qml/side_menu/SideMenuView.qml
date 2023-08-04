import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 

import components as Comp
import "./components" as SideMenu

Comp.Pane {
    id: subWindowPane
    padding: 8
    property int currentIndex: listView.currentIndex

    Column {
        spacing: 50

        SideMenu.MenuButton {
            id: menuButton
            anchors.horizontalCenter: listView.horizontalCenter
        }

        ListView {
            id: listView
            width: 40
            height: contentItem.childrenRect.height
            interactive: false
            spacing: 10

            delegate: SideMenu.ItemDelegate {
                width: listView.width
                highlighted: ListView.isCurrentItem
                text: label
                icon.source: iconSource
                opened: menuButton.highlighted
                onClicked: listView.currentIndex = model.index
            }

            model: ListModel {
                ListElement {
                    label: "Home"
                    iconSource: "qrc:/home_icon.svg"
                }

                ListElement {
                    label: "Goals"
                    iconSource: "qrc:/goals_icon.svg"
                }

                ListElement {
                    label: "Tasks"
                    iconSource: "qrc:/tasks_icon.svg"
                }

                ListElement {
                    label: "Habits"
                    iconSource: "qrc:/habits_icon.svg"
                }

                ListElement {
                    label: "Vision Board"
                    iconSource: "qrc:/vision_board_icon.svg"
                }

                ListElement {
                    label: "Journal"
                    iconSource: "qrc:/journal_icon.svg"
                }

                ListElement {
                    label: "Reports"
                    iconSource: "qrc:/reports_icon.svg"
                }

                ListElement {
                    label: "Settings"
                    iconSource: "qrc:/settings_icon.svg"
                }
            }
        }

        states: State {
            name: "opened"
            when: menuButton.highlighted

            PropertyChanges {
                target: listView
                width: 170
            }

            AnchorChanges {
                target: menuButton
                anchors.horizontalCenter: undefined
                anchors.right: listView.right
            }
        }

        transitions: Transition {
            to: "opened"
            reversible: true

            NumberAnimation {
                target: listView
                property: "width"
                duration: 500
                easing.type: Easing.OutQuad
            }

            AnchorAnimation {
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }
}
