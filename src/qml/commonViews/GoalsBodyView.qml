import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import popups as Pop

Comp.ScrollView {
    id: scrollView
    property int parentGoalId: 0
    property alias gridView: gridView

    ColumnLayout {
        width: scrollView.availableWidth

        GridView {
            id: gridView
            Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
            Layout.preferredHeight: contentHeight
            Layout.alignment: Qt.AlignHCenter

            delegate: Item {
                id: item
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                Comp.GoalItemDelegate {
                    anchors.centerIn: parent
                    itemId: model.itemId
                    imageSource: model.imageSource
                    category: model.category
                    goalName: model.name
                    startDateTime: Date.fromLocaleString(Qt.locale(), model.startDateTime, "dd MMM yyyy hh:mm AP")
                    endDateTime: Date.fromLocaleString(Qt.locale(), model.endDateTime, "dd MMM yyyy hh:mm AP")
                    progressValue: model.progressValue
                    targetValue: model.targetValue
                    unit: model.progressUnit
                    subGoal: scrollView.parentGoalId

                    Component.onCompleted: {
                        if(item.GridView.view.cellWidth < implicitWidth)
                            item.GridView.view.cellWidth = implicitWidth + 20
                        if(item.GridView.view.cellHeight < implicitHeight)
                            item.GridView.view.cellHeight = implicitHeight + 20
                    }
                }
            }

            model: dbAccess.createGoalsTableModel(scrollView.parentGoalId)

            Connections {
                target: createGoalPopup
                function onSave() {gridView.model.select()}
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
            createGoalPopup.parentGoalId = scrollView.parentGoalId
            createGoalPopup.open()
        }

        Pop.CreateGoalPopup {
            id: createGoalPopup
        }
    }
}
