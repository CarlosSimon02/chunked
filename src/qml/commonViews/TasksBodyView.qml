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
    clip: true
    property int parentGoalId: 0

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

        Comp.ScrollViewPane {
            ColumnLayout {
                width: scrollView.availableWidth

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 1200
                    Layout.margins: 20
                    Layout.alignment: Qt.AlignHCenter
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
                                drawerPane.index = model.index
                            }
                        }

                        model: TasksTableModel {
                            parentGoalId: pane.parentGoalId
                        }

//                        Connections {
//                            target: createTaskTextField
//                            function onSave() {listView.model.refresh()}
//                        }
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
        visible: x <= parent.width + 20
        property bool opened: false
        property int index
        signal open
        onOpen: {
            opened = true
            nameText.text = listView.model.data("name", drawerPane.index)
        }

        background: Rectangle {
            color: Comp.ColorScheme.primaryColor.light
            radius: Comp.Consts.commonRadius
            layer.enabled: true
            layer.effect: Impl.DropShadow {}
        }

        ColumnLayout {
            anchors.fill: parent

            Comp.FieldColumnLayout {
                Comp.FieldLabel {
                    text: "Name"
                }

                Comp.TextArea {
                    Layout.fillWidth: true
                }
            }

            Comp.FieldColumnLayout {
                Comp.FieldLabel {
                    text: "Name"
                }

                Comp.TextArea {
                    Layout.fillWidth: true
                }
            }

            Comp.Text {
                id: nameText
            }

            Comp.Button {
                text: "Change Name to Fuck you"
                onClicked: listView.model.setData("name", drawerPane.index, "Fuck you")
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
