import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
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
                        onClicked: drawer.open()
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

//    Rectangle {
//        id: dimOverlayRect
//        anchors.fill: parent
//        color: "red"
//    }

//    Pane {
//        id: drawerPane
//    }
}
