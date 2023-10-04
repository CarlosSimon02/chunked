import QtQuick
import QtQuick.Controls.Material

import components as Comp
import views.habits_body

Comp.PageView {
    title: "Habits"

    HabitsBodyView {
        anchors.fill: parent
    }
}
