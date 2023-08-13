import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import popups as Pop
import "../components" as GoalInfo

Comp.ScrollView {
    id: scrollView
    contentWidth: availableWidth
    property int goalId
    property string goalName

    ColumnLayout {
        width: scrollView.availableWidth

        GridView {
            Layout.preferredHeight: contentHeight
            Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            cellWidth: 330
            cellHeight: 390

            delegate: Item {
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                GoalInfo.SubgoalItemDelegate {
                    anchors.centerIn: parent
                    imageSource: model.imageSource
                    goalName: model.goalName
                    timeRemaining: model.timeRemaining
                    progressValue: model.progressValue
                    targetValue: model.progressTarget
                    unit: model.unit
                }
            }

            Connections {
                target: createGoalPopup
                function onSave() {goalsTableModel.refresh()}
            }

            model: GoalsTableModel {
                id: goalsTableModel
                parentGoalId: goalId
            }
        }
    }

    Comp.AccentButton {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 30
        anchors.rightMargin: 30
        padding: 10
        icon.source: "qrc:/create_icon.svg"
        onClicked: {
            createGoalPopup.parentGoalId = goalId
            createGoalPopup.parentGoalName = goalName
            createGoalPopup.open()
        }

        Pop.CreateGoalPopup {
            id: createGoalPopup
        }
    }
}
