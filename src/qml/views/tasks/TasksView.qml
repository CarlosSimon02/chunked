import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.PageView {
    title: "Tasks"

    RowLayout {
        anchors.fill: parent

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            delegate: CheckDelegate {
                width: ListView.view.width
                text: "Sample task"
            }

            model: 10
        }
    }
}
