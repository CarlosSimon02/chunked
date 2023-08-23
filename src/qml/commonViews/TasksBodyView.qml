import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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

            CommonViews.TextArea {
                Layout.fillWidth: true
                placeholderText: "Type your task here and press 'Enter' to save"
            }

            ListView {
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                interactive: false
                spacing: 8
                delegate: CommonViews.TaskItemDelegate {
                    width: ListView.view.width
                }
                model: 4
            }
        }
    }
}
