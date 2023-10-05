import QtQuick
import QtQuick.Controls.Material

import components as Comp
import "./components" as MComp

Item {
    id: item
    clip: true
    property bool itemsHasImage: true
    property bool isSubHabit: false
    property ScrollBar verticalScrollBar

    GridView {
        id: gridView
        width: contentWidth
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        topMargin: item.isSubGoal ? 8 : 10
        bottomMargin: topMargin
        contentWidth: Math.floor((item.parent.width - 30) / cellWidth) * cellWidth
        cellWidth: item.isSubHabit ? 310 : 350
        cellHeight: item.isSubHabit ? 230 : 260

        ScrollBar.vertical: item.verticalScrollBar

        delegate: Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            MComp.HabitItemDelegate {
                anchors.fill: parent
                anchors.margins: parent.GridView.view.topMargin
                isSubHabit: item.isSubHabit
                hasImage: item.itemsHasImage

                Material.background: Material.color(Material.Grey, Material.Shade900)
                Material.elevation: 0
                Material.roundedScale: Material.SmallScale

                onClicked: stackPageView.push("qrc:/common/views/goals_body/views/goal_info_view/GoalInfoView.qml")
            }
        }

        model: 10
    }

    Button {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        icon.source: "qrc:/create_icon.svg"
        text: "New Habit"

        Material.background: Material.color(Material.Lime, Material.Shade900)
        Material.elevation: 10
        Material.roundedScale: Material.SmallScale

        onClicked: stackPageView.push("qrc:/common/views/goals_body/views/create_edit_goal_view/CreateGoalView.qml")
    }
}
