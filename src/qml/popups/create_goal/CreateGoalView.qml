import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as App

Popup {
    id: popup
    width: applicationWindow.width
    height: applicationWindow.height

    property Goal goal: Goal {
        name: nameTextArea.control.text
        imageSource: imagePicker.imageSource.toString()
        category: categoryComboBox.control.displayText
        startDateTime: timeFramePicker.startDateTime
        endDateTime: timeFramePicker.endDateTime
        progressTracker: progressTrackerComboBox.control.displayText
        progressValue: parseInt(progressValueTextArea.control.text)
        targetValue: parseInt(targetValueTextArea.control.text)
        progressUnit: progressUnitTextArea.control.text
        mission: missionTextArea.control.text
        vision: visionTextArea.control.text
        obstacles: obstaclesTextArea.control.text
        resources: resourcesTextArea.control.text
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 50

        RowLayout {
            Button {
                text: "Back"
                onClicked: popup.close()
            }

            App.PageHeaderTitle {
                text: "Create Goal"
            }
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                width: parent.availableWidth
                spacing: 30

                App.ImagePicker {
                    id: imagePicker
                    label: "Image"
                }

                App.TextField {
                    id: nameTextArea
                    label: "Goal Name"
                }

                App.ComboBox {
                    id: categoryComboBox
                    label: "Category"
                    control.model: ["Home","Personal","Work"]
                }

                ColumnLayout {
                    TabBar {
                        id: tabBar

                        TabButton {
                            text: "Mission"
                            width: implicitWidth
                        }
                        TabButton {
                            text: "Vision"
                            width: implicitWidth
                        }
                        TabButton {
                            text: "Obstacles"
                            width: implicitWidth
                        }
                        TabButton {
                            text: "Resources"
                            width: implicitWidth
                        }
                    }

                    StackLayout {
                        Layout.preferredWidth: 300
                        Layout.preferredHeight: 200
                        currentIndex: tabBar.currentIndex

                        App.TextArea {
                            id: missionTextArea
                            placeholderText: "Mission"
                        }
                        App.TextArea {
                            id: visionTextArea
                            placeholderText: "Vision"
                        }
                        App.TextArea {
                            id: obstaclesTextArea
                            placeholderText: "Obstacles"
                        }
                        App.TextArea {
                            id: resourcesTextArea
                            placeholderText: "Resources"
                        }
                    }
                }

                App.ComboBox {
                    id: progressTrackerComboBox
                    label: "Track Progress by"
                    control.model: [
                        "Total number of completed tasks",
                        "Total outcome from all tasks",
                        "Total progress from all subgoals",
                        "Total number of completed subgoals",
                        "Manually updating current progress"
                    ]

                    control.onActivated: index => {
                       switch(index) {
                           case 0:
                           progressValueTextArea.control.text = 0
                           progressValueTextArea.enabled = false
                           targetValueTextArea.control.text = 0
                           targetValueTextArea.enabled = false
                           progressUnitTextArea.control.text = "task/s"
                           progressUnitTextArea.enabled = true
                           break
                           case 1:
                           progressValueTextArea.control.text = 0
                           progressValueTextArea.enabled = false
                           targetValueTextArea.control.text = 0
                           targetValueTextArea.enabled = false
                           progressUnitTextArea.control.text = "outcome/s"
                           progressUnitTextArea.enabled = true
                           break
                           case 2:
                           progressValueTextArea.control.text = 0
                           progressValueTextArea.enabled = false
                           targetValueTextArea.control.text = 0
                           targetValueTextArea.enabled = false
                           progressUnitTextArea.control.text = "subgoals' progress"
                           progressUnitTextArea.enabled = false
                           break
                           case 3:
                           progressValueTextArea.control.text = 0
                           progressValueTextArea.enabled = false
                           targetValueTextArea.control.text = 0
                           targetValueTextArea.enabled = false
                           progressUnitTextArea.control.text = "subgoal/s"
                           progressUnitTextArea.enabled = true
                           break
                           case 4:
                           progressValueTextArea.control.text = 0
                           progressValueTextArea.enabled = true
                           targetValueTextArea.control.text = 0
                           targetValueTextArea.enabled = true
                           progressUnitTextArea.control.text = ""
                           progressUnitTextArea.enabled = true
                           break
                       }
                   }
                }

                App.TextField {
                    id: progressValueTextArea
                    label: "Progress"
                    control.text: "0"
                    enabled: false
                }

                App.TextField {
                    id: targetValueTextArea
                    label: "Target"
                    control.text: "0"
                    enabled: false
                }

                App.TextField {
                    id: progressUnitTextArea
                    label: "Unit"
                    control.text: "task/s"
                }

                App.TimeFramePicker {
                    id: timeFramePicker
                    label: "Time Frame"
                }

                RowLayout {
                    Button {
                        text: "Cancel"
                    }

                    Button {
                        text: "Save"
                        onClicked: {
                            dbAccess.saveData(goal)
                            popup.close()
                            bodyView.goalAdded()
                        }
                    }
                }
            }
        }
    }
}
