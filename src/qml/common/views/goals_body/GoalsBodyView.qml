import QtQuick
import QtQuick.Controls.Material
import app

import components as Comp
import components.buttons as Btn
import components.delegates as Dlg

Item {
    id: item

    property alias model: gridView.model
    property int parentGoalId: 0
    property bool itemsHasImage: true
    property ScrollBar verticalScrollBar

    clip: true

    GridView {
        id: gridView
        width: contentWidth
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        topMargin: item.parentGoalId ? 8 : 10
        bottomMargin: topMargin
        contentWidth: Math.floor((item.parent.width - 30) / cellWidth) * cellWidth
        cellWidth: item.parentGoalId ? 310 : 350
        cellHeight: item.parentGoalId ? item.itemsHasImage ? 360 : 200 :
                                     item.itemsHasImage ? 425 : 240

        ScrollBar.vertical: item.verticalScrollBar

        delegate: Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Dlg.GoalItemDelegate {
                anchors.fill: parent
                anchors.margins: parent.GridView.view.topMargin
                isSubGoal: item.parentGoalId
                hasImage: item.itemsHasImage

                Material.background: Material.color(Material.Grey, Material.Shade900)
                Material.elevation: 0
                Material.roundedScale: Material.SmallScale

                Component.onCompleted: {
                    itemId = model.itemId
                    imageSource = model.imageSource
                    goalName = model.name
                    startDateTime = Date.fromLocaleString(Qt.locale(),
                                                         model.startDateTime,
                                                         "yyyy-MM-dd hh:mm:ss")
                    endDateTime = Date.fromLocaleString(Qt.locale(),
                                                       model.endDateTime,
                                                       "yyyy-MM-dd hh:mm:ss")
                    category = model.category
                    progressValue = model.progressValue
                    targetValue = model.targetValue
                    unit = model.progressUnit
                }
            }
        }

        model: GoalsTableModel {
            parentGoalId: item.parentGoalId
        }

        Connections {
            target: initPageView.StackView
            function onActivating() {
                gridView.model.refresh()
            }
        }
    }

    Btn.FloatingButton {
        icon.source: "qrc:/create_icon.svg"
        text: "New Goal"

        onClicked: stackPageView.push("qrc:/common/views/goals_body/views/create_edit_goal/CreateGoalView.qml",
                                      {"parentGoalId": item.parentGoalId})
    }
}
