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

    property int parentGoalId: 0
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
                startDateTime: startButton.text
                endDateTime: endButton.text
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

                    model: ["Details", "Parent Goal", "Time Frame", "Progress Tracker", "Description"]
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: listView.currentIndex

                    Comp.ScrollView {
                        Pop.ColumnLayout {
                            Comp.FieldColumnLayout {
                                spacing: 12

                                Comp.FieldLabel {
                                    text: "Goal Name"
                                }

                                Comp.TextArea {
                                    id: goalNameTextArea
                                    Layout.preferredWidth: 400
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Category"
                                }

                                Comp.ComboBox {
                                    id: categoryComboBox
                                    Layout.preferredWidth: 400
                                    model: ["Home","Personal","Work"]
                                    enabled: !createGoalPopup.parentGoalId
                                    displayText: if(createGoalPopup.parentGoalId)
                                                     return dbAccess.getValue("goals",
                                                                              "category",
                                                                              createGoalPopup.parentGoalId)
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Image"
                                }

                                Pop.ImagePicker {
                                    id: imagePicker
                                    Layout.preferredWidth: 400
                                    Layout.preferredHeight: Layout.preferredWidth * 9 / 16
                                }
                            }
                        }
                    }

                    Comp.ScrollView {
                        Pop.ColumnLayout {
                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Parent Goal"
                                }

                                Pop.TreeViewComboBox {
                                    id: parentGoalIdComBoBox
                                    Layout.preferredWidth: 400
                                    model: GoalNamesTreeViewModel {}
                                    onItemIdChanged: {
                                        createGoalPopup.parentGoalId = itemId
                                        displayText = createGoalPopup.parentGoal ? dbAccess.getValue("goals","name", createGoalPopup.parentGoalId) :
                                                                                   "None(Top Level)"
                                    }

                                    Component.onCompleted: {
                                        itemId =  createGoalPopup.parentGoalId
                                        displayText = createGoalPopup.parentGoalId ? dbAccess.getValue("goals","name", createGoalPopup.parentGoalId) :
                                                                                     "None(Top Level)"
                                    }
                                }
                            }
                        }
                    }

                    Pop.ColumnLayout {
                        spacing: 40

                        RowLayout {
                            Layout.leftMargin: 2
                            spacing: 15

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Start"
                                }

                                Comp.Button {
                                    id: startButton
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 52
                                    property date chosenDate
                                    text: chosenDate.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                    highlighted: true
                                    border.width: 1
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

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "End"
                                }

                                Comp.Button {
                                    id: endButton
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 52
                                    property date chosenDate
                                    text: chosenDate.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                    verticalPadding: 14
                                    border.width: 1

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
                            Layout.leftMargin: 2
                            currentIndex: 0
                            clip: true

                            RowLayout {
                                spacing: 60

                                Pop.DatePicker {
                                    id: startDatePicker
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignTop

                                    onChooseDate: startButton.chosenDate.setFullYear(chosenDate.getFullYear(),
                                                                                     chosenDate.getMonth(),
                                                                                     chosenDate.getDate())
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

                                    onChooseDate: endButton.chosenDate.setFullYear(chosenDate.getFullYear(),
                                                                                   chosenDate.getMonth(),
                                                                                   chosenDate.getDate())
                                }

                                Pop.TimePicker {
                                    id: endTimePicker
                                    Layout.maximumHeight: endDatePicker.height

                                    onChooseTime: endButton.chosenDate.setHours(chosenTime.getHours(),chosenTime.getMinutes())
                                }
                            }
                        }
                    }

                    Comp.ScrollView {
                        Pop.ColumnLayout {
                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Progress Tracker"
                                }

                                Comp.ComboBox {
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

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Unit"
                                }

                                Comp.TextArea {
                                    id: progressUnitTextArea
                                    Layout.preferredWidth: 400
                                    placeholderText: "e.g., book/s, project/s, item/s"
                                    text: "task/s"
                                    wrapMode: TextArea.NoWrap
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Target"
                                }

                                Comp.TextArea {
                                    id: targetValueTextArea
                                    Layout.preferredWidth: 200
                                    text: "0"
                                    enabled: false
                                    wrapMode: TextArea.NoWrap
                                    horizontalAlignment: TextEdit.AlignRight
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Current Progress"
                                }

                                Comp.TextArea {
                                    id: progressValueTextArea
                                    Layout.preferredWidth: 200
                                    text: "0"
                                    enabled: false
                                    wrapMode: TextArea.NoWrap
                                    horizontalAlignment: TextEdit.AlignRight
                                }
                            }
                        }
                    }

                    Comp.ScrollView {
                        Pop.ColumnLayout {
                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Mission"
                                }

                                Comp.TextArea {
                                    id: missionTextArea
                                    Layout.preferredWidth: 400
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    id: visionTextArea
                                    text: "Vision"
                                }

                                Comp.TextArea {
                                    Layout.preferredWidth: 400
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Obstacles"
                                }

                                Comp.TextArea {
                                    id: obstaclesTextArea
                                    Layout.preferredWidth: 400
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Resources"
                                }

                                Comp.TextArea {
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
                            dbAccess.saveGoalItem(columnLayout.goal)
                            createGoalPopup.save()
                            createGoalPopup.close()
                        }
                    }
                }
            }
        }
    }
}
