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

                    delegate: CommonViews.TaskItemDelegate {
                        width: ListView.view.width
                        onClicked: {
                            drawerPane.visible = true
                        }

                    }

                    model: dbAccess.createTasksTableModel()

                    Connections {
                        target: createTaskTextField
                        function onSave() {listView.model.select()}
                    }
                }
            }
        }
    }

    Pane {
        id: dimOverlayPane
        anchors.fill: parent
        visible: drawerPane.visible

        background: Rectangle {
            color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
        }

        TapHandler {

        }
    }

    Pane {
        id: drawerPane
        anchors.verticalCenter: parent.verticalCenter
        x: parent.width + 20
        height: parent.height - 40
        width: 350
        visible: false
        property Task task

        background: Rectangle {
            color: Comp.ColorScheme.primaryColor.light
            radius: Comp.Consts.commonRadius
            layer.enabled: true
            layer.effect: Impl.DropShadow {}
        }

        Loader {

        }

        states: State {
            name: "opened"
            when: drawerPane.visible

            PropertyChanges {
                target: drawerPane
                x: parent.width - width - 20
            }

            AnchorChanges {
                target: menuButton
                anchors.horizontalCenter: undefined
                anchors.right: listView.right
            }
        }

        transitions: Transition {
            to: "opened"
            reversible: true

            NumberAnimation {
                target: drawerPane
                property: "width"
                duration: 500
                easing.type: Easing.OutQuad
            }

            AnchorAnimation {
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }
}
