import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import "./components" as CommonViews

Comp.ScrollView {
    id: scrollView
    anchors.fill: parent

    Pane {
        width: scrollView.availableWidth
        background: null
        padding: 30

        ColumnLayout {
            width: parent.width
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
                model: dbAccess.createTasksTableModel();

                Connections {
                    target: createTaskTextField
                    function onSave() {listView.model.select()}
                }
            }
        }
    }
}
