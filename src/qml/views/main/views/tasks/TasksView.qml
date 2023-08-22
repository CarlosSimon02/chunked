import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import "./components" as Tasks

Comp.Page {
    signal goalAdded
    topPadding: -pageHeader.bottomPadding

    header: Comp.PageHeader {
        id: pageHeader
        height: 90

        Comp.Text {
            text: "Tasks"
            font.weight: Font.Bold
            font.pixelSize: 28
        }
    }

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

                Tasks.TextArea {
                    Layout.fillWidth: true
                    placeholderText: "Type your task here and press 'Enter' to save"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight
                    interactive: false
                    spacing: 8
                    delegate: Tasks.TaskItemDelegate {
                        width: ListView.view.width
                    }
                    model: 4
                }
            }
        }
    }
}
