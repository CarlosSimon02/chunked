import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import "./components" as Pop

Comp.ModalPopup {
    id: createGoalPopup
    width: 750
    height: 630

    property Goal parentGoal: null
    signal save

    Loader {
        anchors.fill: parent
        sourceComponent: createGoalPopup.opened ? content : null
    }

    Component {
        id: content

        ColumnLayout {
            id: columnLayout
            spacing: 20

            property Goal goal: Goal {
                name: goalNameTextArea.text
                imageSource: imagePicker.source.toString()
                category: categoryComboBox.displayText
                startDateTime: startButton.chosenDate
                endDateTime: endButton.chosenDate
                progressTracker: progressTrackerComboBox.currentIndex
                progressValue: parseInt(progressValueTextArea.text)
                targetValue: parseInt(targetValueTextArea.text)
                progressUnit: progressUnitTextArea.text
                mission: missionTextArea.text
                vision: visionTextArea.text
                obstacles: obstaclesTextArea.text
                resources: resourcesTextArea.text
                parentGoalId: parentGoalIdComBoBox.itemId
            }

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
                    onClicked: createGoalPopup.close()
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
                        Pop.ColumnLayout {
                            Pop.FieldColumnLayout {
                                spacing: 12

                                Pop.FieldLabel {
                                    text: "Goal Name"
                                }

                                Pop.TextArea {
                                    id: goalNameTextArea
                                    Layout.preferredWidth: 400
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Category"
                                }

                                Pop.ComboBox {
                                    id: categoryComboBox
                                    Layout.preferredWidth: 400
                                    model: ["Home","Personal","Work"]
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Image"
                                }

                                Pop.ImagePicker {
                                    id: imagePicker
                                    Layout.preferredWidth: 400
                                    Layout.preferredHeight: Layout.preferredWidth * 9 / 16
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Parent Goal"
                                }

                                Pop.TreeViewComboBox {
                                    id: parentGoalIdComBoBox
                                    Layout.preferredWidth: 400
                                    itemId: createGoalPopup.parentGoal ? createGoalPopup.parentGoal.itemId : 0
                                    displayText: createGoalPopup.parentGoal ? createGoalPopup.parentGoal.name : "None(Top Level)"
                                    model: GoalNamesTreeViewModel {}
                                }
                            }
                        }
                    }

                    Pop.ColumnLayout {
                        spacing: 40

                        RowLayout {
                            spacing: 15

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Start"
                                }

                                Comp.Button {
                                    id: startButton
                                    Layout.fillWidth: true
                                    property date chosenDate
                                    text: chosenDate.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                    highlighted: true
                                    border.width: 1.5
                                    verticalPadding: 14

                                    onClicked: {
                                        highlighted = true
                                        endButton.highlighted = false
                                        swipeView.currentIndex = 0
                                    }

                                    Component.onCompleted: {
                                        var date = new Date()
                                        date.setHours(0,0)
                                        chosenDate = date
                                        startDatePicker.chosenDate = date
                                        startTimePicker.chosenTime = date
                                    }
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "End"
                                }

                                Comp.Button {
                                    id: endButton
                                    Layout.fillWidth: true
                                    property date chosenDate
                                    text: chosenDate.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                    verticalPadding: 14
                                    border.width: 1.5

                                    onClicked: {
                                        highlighted = true
                                        startButton.highlighted = false
                                        swipeView.currentIndex = 1
                                    }

                                    Component.onCompleted: {
                                        var date = new Date()
                                        date.setDate(date.getDate() + 1)
                                        date.setHours(0,0)
                                        chosenDate = date
                                        endDatePicker.chosenDate = date
                                        endTimePicker.chosenTime = date
                                    }
                                }
                            }
                        }

                        SwipeView {
                            id: swipeView
                            Layout.fillWidth: true
                            currentIndex: 0
                            clip: true

                            RowLayout {
                                spacing: 60

                                Pop.DatePicker {
                                    id: startDatePicker
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignTop

                                    onChooseDate: startButton.chosenDate.setDate(chosenDate.getDate())
                                }


                                Pop.TimePicker {
                                    id: startTimePicker
                                    Layout.maximumHeight: startDatePicker.height

                                    onChooseTime: startButton.chosenDate.setHours(chosenTime.getHours(),chosenTime.getMinutes())
                                }
                            }

                            RowLayout {
                                spacing: 60

                                Pop.DatePicker {
                                    id: endDatePicker
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignTop

                                    onChooseDate: endButton.chosenDate.setDate(chosenDate.getDate())
                                }

                                Pop.TimePicker {
                                    id: endTimePicker
                                    Layout.maximumHeight: endDatePicker.height

                                    onChooseTime: endButton.chosenDate.setHours(chosenTime.getHours(),chosenTime.getMinutes())
                                }
                            }
                        }
                    }

                    Pop.ColumnLayout {
                        Pop.FieldColumnLayout {
                            Pop.FieldLabel {
                                text: "Progress Tracker"
                            }

                            Pop.ComboBox {
                                id: progressTrackerComboBox
                                Layout.preferredWidth: 400
                                model: Comp.Consts.goalProgressTrackers

                                onActivated: index => {
                                   switch(index) {
                                       case 0:
                                       progressValueTextArea.text = 0
                                       progressValueTextArea.enabled = false
                                       targetValueTextArea.text = 0
                                       targetValueTextArea.enabled = false
                                       progressUnitTextArea.text = "task/s"
                                       progressUnitTextArea.enabled = true
                                       break
                                       case 1:
                                       progressValueTextArea.text = 0
                                       progressValueTextArea.enabled = false
                                       targetValueTextArea.text = 0
                                       targetValueTextArea.enabled = false
                                       progressUnitTextArea.text = "outcome/s"
                                       progressUnitTextArea.enabled = true
                                       break
                                       case 2:
                                       progressValueTextArea.text = 0
                                       progressValueTextArea.enabled = false
                                       targetValueTextArea.text = 0
                                       targetValueTextArea.enabled = false
                                       progressUnitTextArea.text = "subgoals' progress"
                                       progressUnitTextArea.enabled = false
                                       break
                                       case 3:
                                       progressValueTextArea.text = 0
                                       progressValueTextArea.enabled = false
                                       targetValueTextArea.text = 0
                                       targetValueTextArea.enabled = false
                                       progressUnitTextArea.text = "subgoal/s"
                                       progressUnitTextArea.enabled = true
                                       break
                                       case 4:
                                       progressValueTextArea.text = 0
                                       progressValueTextArea.enabled = true
                                       targetValueTextArea.text = 0
                                       targetValueTextArea.enabled = true
                                       progressUnitTextArea.text = ""
                                       progressUnitTextArea.enabled = true
                                       break
                                   }
                               }
                            }
                        }

                        Pop.FieldColumnLayout {
                            Pop.FieldLabel {
                                text: "Unit"
                            }

                            Pop.TextArea {
                                id: progressUnitTextArea
                                Layout.preferredWidth: 400
                                placeholderText: "e.g., book/s, project/s, item/s"
                                text: "task/s"
                                wrapMode: TextArea.NoWrap
                            }
                        }

                        Pop.FieldColumnLayout {
                            Pop.FieldLabel {
                                text: "Target"
                            }

                            Pop.TextArea {
                                id: targetValueTextArea
                                Layout.preferredWidth: 200
                                text: "0"
                                enabled: false
                                wrapMode: TextArea.NoWrap
                                horizontalAlignment: TextEdit.AlignRight
                            }
                        }

                        Pop.FieldColumnLayout {
                            Pop.FieldLabel {
                                text: "Current Progress"
                            }

                            Pop.TextArea {
                                id: progressValueTextArea
                                Layout.preferredWidth: 200
                                text: "0"
                                enabled: false
                                wrapMode: TextArea.NoWrap
                                horizontalAlignment: TextEdit.AlignRight
                            }
                        }
                    }

                    Comp.ScrollView {
                        Pop.ColumnLayout {
                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Mission"
                                }

                                Pop.TextArea {
                                    id: missionTextArea
                                    Layout.preferredWidth: 400
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    id: visionTextArea
                                    text: "Vision"
                                }

                                Pop.TextArea {
                                    Layout.preferredWidth: 400
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Obstacles"
                                }

                                Pop.TextArea {
                                    id: obstaclesTextArea
                                    Layout.preferredWidth: 400
                                }
                            }

                            Pop.FieldColumnLayout {
                                Pop.FieldLabel {
                                    text: "Resources"
                                }

                                Pop.TextArea {
                                    id: resourcesTextArea
                                    Layout.preferredWidth: 400
                                }
                            }
                        }
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

                    onClicked: {
                        if(listView.currentIndex < listView.count - 1) {
                           listView.currentIndex += 1
                           listView.currentItem.enabled = true
                        }
                        else {
                            dbAccess.save(columnLayout.goal)
                            createGoalPopup.save()
                            createGoalPopup.close()
                        }
                    }
                }
            }
        }
    }
}
