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
    property int itemId: 0
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
                        Comp.ScrollViewPane {
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
                    }

                    Comp.ScrollView {
                        Comp.ScrollViewPane {
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
                    }

                    Comp.DateTimeFramePicker {
                        id: dateTimeFramePicker
                    }

                    Comp.ScrollView {
                        Comp.ScrollViewPane {
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
                    }

                    Comp.ScrollView {
                        Comp.ScrollViewPane {
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
