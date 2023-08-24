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

            TextField {
                id: textArea
                Layout.fillWidth: true
                placeholderText: "Type your task here and press 'Enter' to save"
                wrapMode: TextArea.NoWrap
                property Task task: Task{}

                Keys.onReturnPressed: {
                    if (textArea.length > 0)
                    {
                        console.log("Fuck youuuuuuuuuuuuuuuuu")
                        task.name = textArea.text
                        dbAccess.saveTaskItem(task)
                        listView.model.select()
                    }
                }
            }

            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                interactive: false
                spacing: 8
                delegate: CommonViews.TaskItemDelegate {
                    width: ListView.view.width
                }
                model: dbAccess.createTasksTableModel();
            }
        }
    }
}
