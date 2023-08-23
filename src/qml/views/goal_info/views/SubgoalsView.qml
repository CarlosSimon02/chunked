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

            delegate: Item {
                id: item
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                Comp.GoalItemDelegate {
                    anchors.centerIn: parent
                    subGoal: true
                    itemId: model.itemId
                    imageSource: model.imageSource
                    category: model.category
                    goalName: model.name
                    startDateTime: Date.fromLocaleString(Qt.locale(), model.startDateTime, "dd MMM yyyy hh:mm AP")
                    endDateTime: Date.fromLocaleString(Qt.locale(), model.endDateTime, "dd MMM yyyy hh:mm AP")
                    progressValue: model.progressValue
                    targetValue: model.targetValue
                    unit: model.progressUnit

                    Component.onCompleted: {
                        if(item.GridView.view.cellWidth < implicitWidth)
                            item.GridView.view.cellWidth = implicitWidth + 20
                        if(item.GridView.view.cellHeight < implicitHeight)
                            item.GridView.view.cellHeight = implicitHeight + 20
                    }
                }
            }

            model: dbAccess.createGoalsTableModel(scrollView.goal.itemId)

            Connections {
                target: createGoalPopup
                function onSave() {gridView.model.refresh()}
            }

            Connections {
                target: page.StackView
                function onActivating() {gridView.model.refresh()}
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
            createGoalPopup.parentGoalId = scrollView.goal.itemId
            createGoalPopup.open()
        }

        Pop.CreateGoalPopup {
            id: createGoalPopup
        }
    }
}
