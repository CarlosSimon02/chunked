import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import commonViews as View

Comp.Page {
    topPadding: -pageHeader.bottomPadding

    View.TasksBodyView {
        anchors.fill: parent
    }
}
