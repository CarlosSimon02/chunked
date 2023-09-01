import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import components.impl as Impl
import "./components" as CommonViews

Comp.Pane {
    background: null
    padding: 0
    clip: true

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: forceActiveFocus()
        }

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

                    MouseArea {
                        anchors.fill: parent
                        onClicked: forceActiveFocus()
                    }

                    delegate: CommonViews.TaskItemDelegate {
                        width: ListView.view.width

                        taskDone: model.done
                        name: model.name

                        onSetDone: model.done = taskDone
                        onClicked: {
                            drawerPane.open()
                            drawerPane.index = model.index
                        }
                    }

                    model: TasksTableModel {}

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
