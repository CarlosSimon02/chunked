import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import "./components" as Pop

Comp.ModalPopup {
    id: modalPopup
    width: 750
    height: 630

    property int parentGoalId: 0
    property int itemId: 0
    signal save

    Comp.Pane {
        anchors.fill: parent
        background: null
        padding: 20

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent
            spacing: 20

            Component.onCompleted: {
                if(modalPopup.itemId) {
                    let tempGoal = dbAccess.getGoalItem(modalPopup.itemId)

                    goalNameTextArea.text = tempGoal.name
                    imagePicker.source = tempGoal.imageSource
                    categoryComboBox.displayText = tempGoal.category
                    dateTimeFramePicker.startDateTimeText = tempGoal.startDateTime
                    dateTimeFramePicker.endDateTimeText = tempGoal.endDateTime
                    progressTrackerComboBox.currentIndex = tempGoal.progressTracker
                    progressValueTextArea.text = tempGoal.progressValue
                    targetValueTextArea.text = tempGoal.targetValue
                    progressUnitTextArea.text = tempGoal.progressUnit
                    missionTextArea.text = tempGoal.mission
                    visionTextArea.text = tempGoal.vision
                    obstaclesTextArea.text = tempGoal.obstacles
                    resourcesTextArea.text = tempGoal.resources
                    parentGoalIdComBoBox.itemId = tempGoal.parentGoalId
                }
            }

            property Goal goal: Goal {
                itemId: modalPopup.itemId
                name: goalNameTextArea.text
                imageSource: imagePicker.source.toString()
                category: categoryComboBox.displayText
                startDateTime: dateTimeFramePicker.startDateTimeText
                endDateTime: dateTimeFramePicker.endDateTimeText
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
                    text: modalPopup.itemId ? "Edit Goal" : "Create Goal"
                    font.pixelSize: 24
                    font.bold: true
                }

                Comp.Button {
                    Layout.alignment: Qt.AlignRight
                    icon.source: "qrc:/close_icon.svg"
                    onClicked: modalPopup.close()
                }
            }

            RowLayout {
                Comp.ListView {
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

                                Text {
                                    id: goalNameTextAreaError
                                    text: "This field is required and cannot be empty"
                                    color: "red"
                                    visible: false
                                    font.pixelSize: 12

                                    Connections {
                                        target: goalNameTextArea
                                        function onTextChanged() {goalNameTextAreaError.visible = false}
                                    }
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
                                    enabled: !modalPopup.parentGoalId
                                    displayText: if(modalPopup.parentGoalId)
                                                     return dbAccess.getValue("goals",
                                                                              "category",
                                                                              modalPopup.parentGoalId)
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
                            Label {
                                Layout.bottomMargin: 10
                                padding: 10
                                text: "*Note: You can only choose parent goal which progress tracker depends on goals."
                                wrapMode: Label.Wrap
                                font.pixelSize: 11
                                color: "darkgoldenrod"
                                background: Rectangle {
                                    radius: Comp.Consts.commonRadius
                                    color: Comp.Utils.setColorAlpha(note.color, 0.05)
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Parent Goal"
                                }

                                Comp.GoalNamesTreeViewComboBox {
                                    id: parentGoalIdComBoBox
                                    Layout.preferredWidth: 400
                                    onItemIdChanged: {
                                        modalPopup.parentGoalId = itemId
                                        displayText = modalPopup.parentGoal ? dbAccess.getValue("goals","name", modalPopup.parentGoalId) :
                                                                                   "None(Top Level)"
                                    }

                                    Component.onCompleted: {
                                        itemId =  modalPopup.parentGoalId
                                        displayText = modalPopup.parentGoalId ? dbAccess.getValue("goals","name", modalPopup.parentGoalId) :
                                                                                     "None(Top Level)"
                                    }
                                }
                            }
                        }
                    }

                    Comp.DateTimeFramePicker {
                        id: dateTimeFramePicker
                    }

                    Comp.ScrollView {
                        Pop.ColumnLayout {
                            Comp.FieldColumnLayout {
                                Label {
                                    id: note
                                    Layout.bottomMargin: 10
                                    padding: 10
                                    text: "*Note: Changing the progress tracker will result to deletion of child items"
                                    font.pixelSize: 12
                                    color: "darkgoldenrod"
                                    visible: modalPopup.itemId
                                    background: Rectangle {
                                        radius: Comp.Consts.commonRadius
                                        color: Comp.Utils.setColorAlpha(note.color, 0.05)
                                    }
                                }

                                Comp.FieldLabel {
                                    text: "Progress Tracker"
                                }

                                Comp.ComboBox {
                                    id: progressTrackerComboBox
                                    Layout.preferredWidth: 400
                                    model: Comp.Consts.goalProgressTrackers

                                    onActivated: index => {
                                        progressValueTextArea.enabled = false
                                        targetValueTextArea.enabled = false
                                        progressValueTextArea.text = 0
                                        targetValueTextArea.text = 0

                                        switch(index) {
                                            case 0: progressUnitTextArea.text = "goals' progress"; break;
                                            case 1: progressUnitTextArea.text = "goals"; break;
                                            case 2: progressUnitTextArea.text = "outcomes"; break;
                                            case 3: progressUnitTextArea.text = "tasks"; break;
                                            case 4: progressUnitTextArea.text = "habits' progress"; break;
                                            case 5: progressUnitTextArea.text = "habits"; break;
                                            case 6:
                                            progressUnitTextArea.text = "";
                                            progressValueTextArea.enabled = true
                                            targetValueTextArea.enabled = true
                                            break;
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
                                    placeholderText: "plural form (e.g., books, projects, items)"
                                    text: "goals' progress"
                                    wrapMode: TextArea.NoWrap
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Target"
                                }

                                Comp.TextField {
                                    id: targetValueTextArea
                                    Layout.preferredWidth: 200
                                    text: "0"
                                    enabled: false
                                    horizontalAlignment: TextEdit.AlignRight
                                    validator: RegularExpressionValidator { regularExpression: /[0-9]+\.[0-9]+/ }
                                    onEditingFinished: if(text === "") text = "0"
                                }
                            }

                            Comp.FieldColumnLayout {
                                Comp.FieldLabel {
                                    text: "Current Progress"
                                }

                                Comp.TextField {
                                    id: progressValueTextArea
                                    Layout.preferredWidth: 200
                                    text: "0"
                                    enabled: false
                                    horizontalAlignment: TextEdit.AlignRight

                                    validator: DoubleValidator {
                                        bottom: 0
                                        top: parseInt(targetValueTextArea.text)
                                    }

                                    onTextChanged: {
                                        if(!acceptableInput)
                                            progressValueTextArea.text = progressValueTextArea.text.substring(1)
                                    }
                                    onEditingFinished: if(text === "") text = "0"
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
                           if(goalNameTextArea.length === 0) {
                               goalNameTextArea.hasInvalidInput = true
                               goalNameTextAreaError.visible = true
                           }
                           else {
                               listView.currentIndex += 1
                               listView.currentItem.enabled = true
                           }
                        }
                        else {
                            if(columnLayout.goal.itemId)
                                dbAccess.updateGoalItem(columnLayout.goal)
                            else
                                dbAccess.saveGoalItem(columnLayout.goal)
                            modalPopup.save()
                            modalPopup.close()
                        }
                    }
                }
            }
        }
    }
}
