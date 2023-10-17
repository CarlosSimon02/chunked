import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp
import components.buttons as Btn
import components.delegates as Dlg
import "./components" as MComp
import "./views/create_task"
import "./views/task_info_drawer"
import "./views/edit_task_dialog"

RowLayout {
    id: taskBodyRowLayout
    spacing: 0

    signal dataChanged
    property int parentGoalId: 0
    property int trackerType: 2

    Material.accent: Comp.Globals.color.accent.shade1

    ColumnLayout {
        Layout.margins: 0
        spacing: 15

        RowLayout {
            Layout.topMargin: 30
            Layout.leftMargin: 30
            Layout.rightMargin: 30
            spacing: 10

            MComp.CreateTaskTextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 45

                task.outcomes: createTaskView.outcomes
                task.dateTime: createTaskView.dateTime
                task.duration: createTaskView.duration
                task.parentGoalId: taskBodyRowLayout.parentGoalId

                onSave: {
                    listView.model.insertRecord(task)
                    taskBodyRowLayout.dataChanged()
                }
            }

            Comp.NavBarDelegate {
                Layout.preferredWidth: 45
                Layout.preferredHeight: 45
                icon.source: "qrc:/edit_icon.svg"
                visible: !createTaskScrollView.visible

                onClicked: createTaskDrawerView.open()
            }
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            leftMargin: 30
            rightMargin: 30
            spacing: 10
            clip: true

            section.property: "date"
            section.delegate: Label {
                topPadding: 10
                bottomPadding: 10
                required property string section
                text: Comp.Utils.getSectionTitleDate(Date.fromLocaleString(Qt.locale(),
                                                                           section,
                                                                           "yyyy-MM-dd"))
                color: Comp.Globals.color.secondary.shade2
                font.pixelSize: Comp.Globals.fontSize.small
            }

            ScrollBar.vertical: ScrollBar {
                parent: listView
                x: listView.width - width
                height: taskBodyRowLayout.height
            }

            delegate: Dlg.TaskItemDelegate {
                width: ListView.view.width -
                       ListView.view.leftMargin -
                       ListView.view.rightMargin

                trackerType: taskBodyRowLayout.trackerType
                onDoneChanged: {
                    model.done = done
                    dbAccess.updateParentGoalProgressValue(model.parentGoalId)
                    taskBodyRowLayout.dataChanged()
                }

                Component.onCompleted: {
                    itemId = model.itemId
                    done = model.done
                    outcomes = model.outcomes
                    taskName = model.name
                    dateTime = model.dateTime
                    duration = model.duration
                }
            }

            model: TasksTableModel {
                parentGoalId: taskBodyRowLayout.parentGoalId
            }

            add: Transition {
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnimation { property: "opacity"; from: 0.7; to: 1.0; duration: 200 }
                        NumberAnimation { property: "scale"; from: 0.7; to: 1.0; duration: 200 }
                    }

                    ScriptAction {
                        script: {
                            listView.model.refresh()
                            taskBodyRowLayout.dataChanged()
                        }
                    }
                }
            }

            remove: Transition {
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnimation { property: "opacity"; from: 1; to: 0.7; duration: 200 }
                        NumberAnimation { property: "scale"; from: 1; to: 0.7; duration: 200 }
                    }

                    ScriptAction {
                        script: {
                            listView.model.refresh()
                            taskBodyRowLayout.dataChanged()
                        }
                    }
                }
            }

            displaced: Transition {
                NumberAnimation { properties: "x,y"; duration: 200; easing.type: Easing.OutQuad }
                NumberAnimation { property: "opacity"; to: 1.0 }
                NumberAnimation { property: "scale"; to: 1.0 }
            }
        }
    }

    Rectangle {
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        color: Comp.Globals.color.secondary.shade1
        visible: createTaskScrollView.visible
    }

    ScrollView {
        id: createTaskScrollView
        Layout.preferredWidth: 380
        Layout.fillHeight: true
        Layout.maximumWidth: 380
        Layout.leftMargin: 30
        visible: !taskBodyRowLayout.parentGoalId && window.width > 1200

        CreateTaskView {
            id: createTaskView
            topPadding: 30
            rightPadding: 30
            width: createTaskScrollView.width
        }
    }

    TaskInfoDrawerView {
        id: taskInfoDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }

    CreateTaskDrawerView {
        id: createTaskDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }

    EditTaskDialogView {
        id: editTaskDialogView
    }
}
