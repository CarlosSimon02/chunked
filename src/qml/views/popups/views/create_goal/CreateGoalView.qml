import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import "./components" as CreateGoal

Popup {
    id: popup
    width: 750
    height: 600
    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose
    padding: 20

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Units.commonRadius

        layer.enabled: true
        layer.effect: DropShadow {
            spread: 0.2
            radius: 10
            samples: 17
            color: Comp.ColorScheme.primaryColor.shadow
        }
    }

    Overlay.modal: Rectangle {
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        RowLayout {
            Layout.preferredWidth: Number.POSITIVE_INFINITY

            Comp.Text {
                text: "Create Goal"
                font.pixelSize: 24
                font.bold: true
            }

            Comp.Button {
                Layout.alignment: Qt.AlignRight
                icon.source: "qrc:/close_icon.svg"
                onClicked: popup.close()
            }
        }

        RowLayout {
            ListView {
                id: listView
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                currentIndex: 0
                highlightFollowsCurrentItem: false
                spacing: 6
                highlight: Rectangle {
                    height: listView.currentItem.height - 6
                    width: 1.5
                    color: Comp.ColorScheme.accentColor.regular
                    x: 0
                    y: listView.currentItem.y + 3

                    Behavior on y { SmoothedAnimation { velocity: 400 } }
                }

                delegate: Comp.Button {
                    required property string modelData
                    required property int index
                    horizontalPadding: 15
                    verticalPadding: 8

                    text: modelData
                    font.weight: Font.Normal
                    font.pixelSize: 12
                    highlighted: ListView.isCurrentItem
                    backgroundColor: "transparent"
                    enabled: index === 0

                    onClicked: ListView.view.currentIndex = index
                }

                model: ["Details", "Time Frame", "Progress Tracker", "Description"]
            }

            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: listView.currentIndex

                Comp.ScrollView {
                    ColumnLayout {
                        spacing: 25

                        ColumnLayout {
                            spacing: 12

                            Comp.Text {
                                text: "Goal Name"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: Comp.ColorScheme.secondaryColor.dark
                            }

                            CreateGoal.TextArea {
                                Layout.preferredWidth: 400
                            }
                        }

                        ColumnLayout {
                            spacing: 12

                            Comp.Text {
                                text: "Category"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: Comp.ColorScheme.secondaryColor.dark
                            }

                            CreateGoal.TextArea {
                                Layout.preferredWidth: 400
                            }
                        }

                        ColumnLayout {
                            spacing: 12

                            Comp.Text {
                                text: "Image"
                                font.pixelSize: 14
                                font.weight: Font.Medium
                                color: Comp.ColorScheme.secondaryColor.dark
                            }

                            CreateGoal.ImagePicker {
                                Layout.preferredWidth: 400
                                Layout.preferredHeight: Layout.preferredWidth * 9 / 16
                            }
                        }
                    }
                }

                Rectangle {
                    color: "blue"
                }

                Rectangle {
                    color: "green"
                }

                Rectangle {
                    color: "violet"
                }
            }

        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 10

            Comp.Button {
                Layout.preferredWidth: 80
                text: "Back"
                border.width: 1
                enabled: listView.currentIndex > 0
                onClicked: listView.currentIndex -= 1
            }

            Comp.AccentButton {
                Layout.preferredWidth: 80
                text: listView.currentIndex === listView.count - 1 ? "Save" : "Next"

                onClicked: if(listView.currentIndex < listView.count - 1) {
                               listView.currentIndex += 1
                               listView.currentItem.enabled = true
                           }
            }
        }
    }

//    property Goal goal: Goal {
//        name: nameTextArea.control.text
//        imageSource: imagePicker.imageSource.toString()
//        category: categoryComboBox.control.displayText
//        startDateTime: timeFramePicker.startDateTime
//        endDateTime: timeFramePicker.endDateTime
//        progressTracker: progressTrackerComboBox.control.displayText
//        progressValue: parseInt(progressValueTextArea.control.text)
//        targetValue: parseInt(targetValueTextArea.control.text)
//        progressUnit: progressUnitTextArea.control.text
//        mission: missionTextArea.control.text
//        vision: visionTextArea.control.text
//        obstacles: obstaclesTextArea.control.text
//        resources: resourcesTextArea.control.text
//    }

//    ColumnLayout {
//        anchors.fill: parent
//        spacing: 50

//        RowLayout {
//            Button {
//                text: "Back"
//                onClicked: popup.close()
//            }

//           Comp.PageTitleText{
//                text: "Create Goal"
//            }
//        }

//        ScrollView {
//            Layout.fillWidth: true
//            Layout.fillHeight: true

//            ColumnLayout {
//                width: parent.availableWidth
//                spacing: 30

//               Comp.ImagePicker {
//                    id: imagePicker
//                    label: "Image"
//                }

//               Comp.TextField {
//                    id: nameTextArea
//                    label: "Goal Name"
//                }

//               Comp.ComboBox {
//                    id: categoryComboBox
//                    label: "Category"
//                    control.model: ["Home","Personal","Work"]
//                }

//                ColumnLayout {
//                    TabBar {
//                        id: tabBar

//                        TabButton {
//                            text: "Mission"
//                            width: implicitWidth
//                        }
//                        TabButton {
//                            text: "Vision"
//                            width: implicitWidth
//                        }
//                        TabButton {
//                            text: "Obstacles"
//                            width: implicitWidth
//                        }
//                        TabButton {
//                            text: "Resources"
//                            width: implicitWidth
//                        }
//                    }

//                    StackLayout {
//                        Layout.preferredWidth: 300
//                        Layout.preferredHeight: 200
//                        currentIndex: tabBar.currentIndex

//                       Comp.TextArea {
//                            id: missionTextArea
//                            placeholderText: "Mission"
//                        }
//                       Comp.TextArea {
//                            id: visionTextArea
//                            placeholderText: "Vision"
//                        }
//                       Comp.TextArea {
//                            id: obstaclesTextArea
//                            placeholderText: "Obstacles"
//                        }
//                       Comp.TextArea {
//                            id: resourcesTextArea
//                            placeholderText: "Resources"
//                        }
//                    }
//                }

//               Comp.ComboBox {
//                    id: progressTrackerComboBox
//                    label: "Track Progress by"
//                    control.model: [
//                        "Total number of completed tasks",
//                        "Total outcome from all tasks",
//                        "Total progress from all subgoals",
//                        "Total number of completed subgoals",
//                        "Manually updating current progress"
//                    ]

//                    control.onActivated: index => {
//                       switch(index) {
//                           case 0:
//                           progressValueTextArea.control.text = 0
//                           progressValueTextArea.enabled = false
//                           targetValueTextArea.control.text = 0
//                           targetValueTextArea.enabled = false
//                           progressUnitTextArea.control.text = "task/s"
//                           progressUnitTextArea.enabled = true
//                           break
//                           case 1:
//                           progressValueTextArea.control.text = 0
//                           progressValueTextArea.enabled = false
//                           targetValueTextArea.control.text = 0
//                           targetValueTextArea.enabled = false
//                           progressUnitTextArea.control.text = "outcome/s"
//                           progressUnitTextArea.enabled = true
//                           break
//                           case 2:
//                           progressValueTextArea.control.text = 0
//                           progressValueTextArea.enabled = false
//                           targetValueTextArea.control.text = 0
//                           targetValueTextArea.enabled = false
//                           progressUnitTextArea.control.text = "subgoals' progress"
//                           progressUnitTextArea.enabled = false
//                           break
//                           case 3:
//                           progressValueTextArea.control.text = 0
//                           progressValueTextArea.enabled = false
//                           targetValueTextArea.control.text = 0
//                           targetValueTextArea.enabled = false
//                           progressUnitTextArea.control.text = "subgoal/s"
//                           progressUnitTextArea.enabled = true
//                           break
//                           case 4:
//                           progressValueTextArea.control.text = 0
//                           progressValueTextArea.enabled = true
//                           targetValueTextArea.control.text = 0
//                           targetValueTextArea.enabled = true
//                           progressUnitTextArea.control.text = ""
//                           progressUnitTextArea.enabled = true
//                           break
//                       }
//                   }
//                }

//               Comp.TextField {
//                    id: progressValueTextArea
//                    label: "Progress"
//                    control.text: "0"
//                    enabled: false
//                }

//               Comp.TextField {
//                    id: targetValueTextArea
//                    label: "Target"
//                    control.text: "0"
//                    enabled: false
//                }

//               Comp.TextField {
//                    id: progressUnitTextArea
//                    label: "Unit"
//                    control.text: "task/s"
//                }

//               Comp.TimeFramePicker {
//                    id: timeFramePicker
//                    label: "Time Frame"
//                }

//                RowLayout {
//                    Button {
//                        text: "Cancel"
//                    }

//                    Button {
//                        text: "Save"
//                        onClicked: {
//                            dbAccess.saveData(goal)
//                            popup.close()
//                            bodyView.goalAdded()
//                        }
//                    }
//                }
//            }
//        }
//    }
}
