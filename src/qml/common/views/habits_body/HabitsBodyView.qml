import QtQuick
import QtQuick.Controls.Material
import app

import components as Comp
import components.buttons as Btn
import components.delegates as Dlg
import "./views/habit_info_drawer"

Item {
    id: item
    clip: true
    property bool itemsHasImage: true
    property int parentGoalId
    property ScrollBar verticalScrollBar

    GridView {
        id: gridView
        width: contentWidth
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        topMargin: item.isSubGoal ? 8 : 10
        bottomMargin: topMargin
        contentWidth: Math.floor((item.parent.width - 30) / cellWidth) * cellWidth
        cellWidth: item.parentGoalId ? 310 : 350
        cellHeight: item.parentGoalId ? 230 : 260

        ScrollBar.vertical: item.verticalScrollBar

        delegate: Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Dlg.HabitItemDelegate {
                anchors.fill: parent
                anchors.margins: parent.GridView.view.topMargin
                hasParentGoal: item.parentGoalId

                Material.background: Material.color(Material.Grey, Material.Shade900)
                Material.elevation: 0
                Material.roundedScale: Material.SmallScale

                onClicked: habitInfoDrawerView.open()
            }
        }

        model: HabitsTableModel {
            parentGoalId: item.parentGoalId
        }
    }

    Btn.FloatingButton {
        icon.source: "qrc:/create_icon.svg"
        text: "New Habit"

        onClicked: stackPageView.push("qrc:/common/views/habits_body/views/create_edit_habit/CreateEditHabitView.qml")
    }

    HabitInfoDrawerView {
        id: habitInfoDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }
}
