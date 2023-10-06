import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.PageView {
    title: "Home"

    RowLayout {
        anchors.fill: parent

        ListView {
            Layout.fillHeight: true
            Layout.preferredWidth: 390
            leftMargin: 10
            rightMargin: 10
            topMargin: 10
            bottomMargin: 10
            spacing: 10

            delegate: Comp.GoalItemDelegate {
                width: ListView.view.width - 20
                height: 405
            }

            model: 3
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        ListView {
            Layout.fillHeight: true
        }
    }
}
