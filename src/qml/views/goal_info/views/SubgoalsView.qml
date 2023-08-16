import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import popups as Pop
import "../components" as GoalInfo

GoalInfo.ScrollView {
    id: scrollView
    contentWidth: availableWidth

    ColumnLayout {
        width: scrollView.availableWidth

        GridView {
            id: gridView
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
                    goalName: model.name
                    timeRemaining: "1d 2h remaining"
                    progressValue: model.progressValue
                    targetValue: model.targetValue
                    unit: model.progressUnit

                    onClicked: {
                        stackView.push(goalInfoView, {"goal": goalsDataAccess.load(model.itemId)})
                    }
                }
            }

            model: goalsDataAccess.createGoalsTableModel(scrollView.goal.itemId)

            Connections {
                target: createGoalPopup
                function onSave() {gridView.model.refresh()}
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
            createGoalPopup.parentGoal = scrollView.goal
            createGoalPopup.open()
        }

        Pop.CreateGoalPopup {
            id: createGoalPopup
        }
    }
}
