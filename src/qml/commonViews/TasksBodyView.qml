import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import components.impl as Impl
import "./components" as CommonViews

Comp.Pane {
    id: pane
    background: null
    padding: 0
    property int parentGoalId: 0
    onParentGoalIdChanged: listView.isOutcomeVisible = dbAccess.getValue("goals","progressTracker", parentGoalId) === 2

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

        Comp.ScrollViewPane {
            implicitWidth: scrollView.width
            padding: 20

            ColumnLayout {
                width: Math.min(parent.width, 1200)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                CommonViews.CreateTaskTextField {
                    id: createTaskTextField
                    Layout.fillWidth: true
                    task.parentGoalId: pane.parentGoalId

                    onSave: {
                        listView.model.insertTask(task)
                    }
                }

                Comp.ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight
                    spacing: 8
                    currentIndex: -1
                    property bool isOutcomeVisible: false

                    displaced: Transition {
                        NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutBounce }

                        // ensure opacity and scale values return to 1.0
                        NumberAnimation { property: "opacity"; to: 1.0 }
                        NumberAnimation { property: "scale"; to: 1.0 }
                    }

                    delegate: CommonViews.TaskItemDelegate {
                        id: taskItemDelegate
                        width: ListView.view.width
                        taskDone: model.done
                        name: model.name
                        outcome: model.outcome
                        isOutcomeVisible: ListView.view.isOutcomeVisible

                        property bool added

                        states: State {
                            name: "added"; when: taskItemDelegate.added
                            PropertyChanges { target: taskItemDelegate; scale: 1; opacity: 1 }
                        }

                        transitions: Transition {
                            to: "added"
                            reversible: true

                            NumberAnimation { property: "opacity"; from: 0; duration: 400 }
                            NumberAnimation { property: "scale"; from: 0.7; duration: 400 }
                        }

                        ListView.onAdd: added = true
                        onSetDone: model.done = taskDone
                        onClicked: {
                            drawerPane.open()
                            nameTextArea.text = model.name
                            timeFrameTextArea.text = model.startDateTime + " - " + model.endDateTime
                            outcomeSpinBox.value = model.outcome
                            actualDurationSpinBox.value = model.actualDuration
                            notesTextArea.text = model.notes
                        }
                    }

                    model: TasksTableModel {
                        parentGoalId: pane.parentGoalId
                    }
                }
            }
        }
    }

    Pane {
        id: dimOverlayPane
        anchors.fill: parent
        visible: drawerPane.opened

        background: Rectangle {
            color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
        }

        TapHandler {
            onTapped: drawerPane.opened = false
        }
    }

    Pane {
        id: drawerPane
        anchors.verticalCenter: parent.verticalCenter
        x: parent.width + 20
        height: parent.height - 40
        width: 350
        padding: 0
        visible: x <= parent.width + 20
        property bool opened: false
        property int index
        signal open

        onOpen: opened = true

        background: Rectangle {
            color: Comp.ColorScheme.primaryColor.light
            radius: Comp.Consts.commonRadius
            layer.enabled: true
            layer.effect: Impl.DropShadow {}
        }

        Comp.ScrollView {
            id: drawerScrollView
            anchors.fill: parent

            Comp.ScrollViewPane {
                implicitWidth: drawerScrollView.width
                height: Math.max(implicitHeight,parent.parent.height)
                background: null
                padding: 20

                ColumnLayout {
                    width: parent.width
                    spacing: 25

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Name"
                        }

                        Comp.TextArea {
                            id: nameTextArea
                            Layout.fillWidth: true
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Time Frame"
                        }

                        Comp.TextArea {
                            id: timeFrameTextArea
                            Layout.fillWidth: true

                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Outcome"
                        }

                        Comp.SpinBox {
                            id: outcomeSpinBox
                            Layout.fillWidth: true
                            value: 1
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Actual Duration (in minutes)"
                        }

                        Comp.SpinBox {
                            id: actualDurationSpinBox
                            Layout.fillWidth: true
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Notes"
                        }

                        Comp.TextArea {
                            id: notesTextArea
                            Layout.fillWidth: true
                            Layout.preferredHeight: 104
                        }
                    }
                }
            }
        }



        states: State {
            name: "opened"
            when: drawerPane.opened

            PropertyChanges {
                target: drawerPane
                x: parent.width - width - 20
            }
        }

        transitions: Transition {
            to: "opened"
            reversible: true

            NumberAnimation {
                target: drawerPane
                property: "x"
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }
}
