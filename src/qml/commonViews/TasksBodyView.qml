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

    ColumnLayout {
        anchors.fill: parent

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            Layout.margins: pane.parentGoalId ? 0 : 20

            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                CommonViews.CreateTaskTextField {
                    id: createTaskTextField
                    Layout.fillWidth: true
                    task.parentGoalId: pane.parentGoalId

                    onSave: {
                        listView.model.insertTask(task)
                    }
                }

                Comp.TextField {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 300
                    iconSource: "qrc:/search_icon.svg"
                    placeholderText: "Search task"
                }

                Comp.ComboBox {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    iconSource: "qrc:/status_icon.svg"
                    model: ["All", "Pending", "Active", "Done", "Unfinished"]
                }

                Comp.Button {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    icon.source: "qrc:/filter_icon.svg"
                    border.width: 1
                    foregroundColor: Comp.ColorScheme.secondaryColor.dark
                }

                Comp.Button {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    icon.source: "qrc:/option_icon.svg"
                    border.width: 1
                    foregroundColor: Comp.ColorScheme.secondaryColor.dark
                }
            }
        }

        Comp.ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8
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
                startDateTime: Date.fromLocaleString(locale, model.startDateTime, "dd MMM yyyy hh:mm AP")
                endDateTime: Date.fromLocaleString(locale, model.endDateTime, "dd MMM yyyy hh:mm AP")

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
                    doneCheckBox.checked = model.done
                    timeFrameText.text = model.startDateTime + " -\n" + model.endDateTime
                    dateTimeFramePicker.initStartDateTime = Date.fromLocaleString(locale, model.startDateTime, "dd MMM yyyy hh:mm AP")
                    dateTimeFramePicker.initEndDateTime = Date.fromLocaleString(locale, model.endDateTime, "dd MMM yyyy hh:mm AP")
                    nameTextArea.text = model.name
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

            Comp.Page {
                implicitWidth: drawerScrollView.width
                height: Math.max(implicitHeight,parent.parent.height)
                background: null
                padding: 20

                header: ColumnLayout {
                    spacing: 10

                    RowLayout {
                        Layout.margins: 20
                        Layout.bottomMargin: 10
                        Comp.CheckBox {
                            id: doneCheckBox
                            onCheckedChanged: listView.model.setData("done", drawerPane.index, checked)
                        }

                        Comp.Text {
                            id: timeFrameText
                            Layout.fillWidth: true
                            color: Comp.ColorScheme.secondaryColor.veryDark
                        }

                        Comp.Button {
                            Layout.preferredWidth: 36
                            Layout.preferredHeight: 36
                            icon.source: "qrc:/calendar_icon.svg"
                            icon.width: 20
                            icon.height: 20
                            onClicked: dateTimeFramePickerPopup.open()

                            Comp.Popup {
                                id: dateTimeFramePickerPopup
                                x: parent.width - width
                                padding: 25

                                Comp.DateTimeFramePicker {
                                    id: dateTimeFramePicker

                                    onStartDateTimeTextChanged: {
                                        listView.model.setData("startDateTime", drawerPane.index, startDateTimeText)
                                        timeFrameText.text = startDateTimeText + " -\n" + endDateTimeText
                                    }

                                    onEndDateTimeTextChanged: {
                                        listView.model.setData("endDateTime", drawerPane.index, endDateTimeText)
                                        timeFrameText.text = startDateTimeText + " -\n" + endDateTimeText
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                        color: Comp.ColorScheme.secondaryColor.veryDark
                    }
                }

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
                            onTextChanged: listView.model.setData("name", drawerPane.index, text)
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
                            onValueChanged: listView.model.setData("outcome", drawerPane.index, value)
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Actual Duration (in minutes)"
                        }

                        Comp.SpinBox {
                            id: actualDurationSpinBox
                            Layout.fillWidth: true
                            onValueChanged: listView.model.setData("actualDuration", drawerPane.index, value)
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
                            onTextChanged: listView.model.setData("notes", drawerPane.index, text)
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
