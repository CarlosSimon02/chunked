import QtQuick
import QtQuick.Controls.Material
import app

import components as Comp
import components.buttons as Btn
import components.delegates as Dlg
import "./views/habit_info_drawer"
import "./views/create_edit_habit_dialog"

Item {
    id: habitItem
    clip: true

    signal dataChanged
    property bool itemsHasImage: true
    property int parentGoalId
    property ScrollBar verticalScrollBar

    GridView {
        id: gridView
        width: contentWidth
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        topMargin: habitItem.isSubGoal ? 8 : 10
        bottomMargin: topMargin
        contentWidth: Math.floor((habitItem.parent.width - 30) / cellWidth) * cellWidth
        cellWidth: habitItem.parentGoalId ? 310 : 350
        cellHeight: habitItem.parentGoalId ? 230 : 260

        ScrollBar.vertical: habitItem.verticalScrollBar

        delegate: Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Dlg.HabitItemDelegate {
                anchors.fill: parent
                anchors.margins: parent.GridView.view.topMargin
                hasParentGoal: habitItem.parentGoalId

                Material.background: Material.color(Material.Grey, Material.Shade900)
                Material.elevation: 0
                Material.roundedScale: Material.SmallScale

                onClicked: habitInfoDrawerView.open()
            }
        }

        model: HabitsTableModel {
            parentGoalId: habitItem.parentGoalId
        }
    }

    Btn.FloatingButton {
        icon.source: "qrc:/create_icon.svg"
        text: "New Habit"

        onClicked: createEditHabitDialogView.open()
    }

    CreateEditHabitDialogView {
        id: createEditHabitDialogView
    }

    HabitInfoDrawerView {
        id: habitInfoDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }
}
