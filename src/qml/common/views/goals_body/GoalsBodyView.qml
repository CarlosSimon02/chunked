import QtQuick
import QtQuick.Controls.Material

import components as Comp
import "./components" as MComp

Item {
    id: item
    clip: true
    property bool itemsHasImage: true
    property bool isSubGoal: false
    property ScrollBar verticalScrollBar

    GridView {
        id: gridView
        width: contentWidth
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        topMargin: item.isSubGoal ? 8 : 15
        bottomMargin: topMargin
        contentWidth: Math.floor((item.parent.width - 30) / cellWidth) * cellWidth
        cellWidth: item.isSubGoal ? 310 : 350
        cellHeight: item.isSubGoal ? item.itemsHasImage ? 360 : 200 :
                                     item.itemsHasImage ? 425 : 240

        ScrollBar.vertical: item.verticalScrollBar

        delegate: Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            MComp.GoalItemDelegate {
                anchors.fill: parent
                anchors.margins: parent.GridView.view.topMargin
                isSubGoal: item.isSubGoal
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
        text: "New Goal"

        Material.background: Material.color(Material.Lime, Material.Shade900)
        Material.elevation: 10
        Material.roundedScale: Material.SmallScale

        onClicked: stackPageView.push("qrc:/common/views/goals_body/views/create_edit_goal_view/CreateGoalView.qml")
    }
}
