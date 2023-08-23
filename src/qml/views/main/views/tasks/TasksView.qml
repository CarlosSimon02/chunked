import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import commonViews as View

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

    Views.TasksBodyView {
        anchors.fill: parent
    }

}
