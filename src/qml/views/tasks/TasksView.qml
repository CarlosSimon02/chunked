import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import views.tasks_body

Comp.PageView {
    title: "Tasks"

    TasksBodyView {
        anchors.fill: parent
    }
}
