import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import components.impl as Impl
import "./components" as CommonViews

Pane {
    background: null
    padding: 0
    clip: true

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

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
                }

                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight
                    interactive: false
                    spacing: 8
                    verticalLayoutDirection: ListView.BottomToTop

                    delegate: CommonViews.TaskItemDelegate {
                        width: ListView.view.width

                        taskDone: model.done
                        name: model.name

                        Component {
                            id: popupContent

                            ColumnLayout {
                                Comp.Text {
                                    text: model.name
                                }

                                Comp.CheckBox {
                                    checkState: model.done
                                }

                                Comp.Text {
                                    text: model.startDateTime
                                }

                                Comp.Text {
                                    text: model.endDateTime
                                }

                                Comp.Text {
                                    text: model.actualDuration.toString()
                                }

                                Comp.Text {
                                    text: model.outcome.toString()
                                }

                                Comp.Text {
                                    text: model.notes
                                }
                            }
                        }

                        onSetDone: model.done = taskDone
                        onClicked: {
                            drawerPane.opened = true
                            loader.sourceComponent = popupContent
                        }
                    }

                    model: dbAccess.createTasksTableModel()

                    Connections {
                        target: createTaskTextField
                        function onSave() {listView.model.refresh()}
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
        property Task task

        background: Rectangle {
            color: Comp.ColorScheme.primaryColor.light
            radius: Comp.Consts.commonRadius
            layer.enabled: true
            layer.effect: Impl.DropShadow {}
        }

        Loader {
            id: loader
            anchors.fill: parent
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
