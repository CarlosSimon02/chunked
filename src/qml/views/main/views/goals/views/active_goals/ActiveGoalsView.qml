import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp

Pane {
    background: null
    clip: false
    padding: 0

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

        ColumnLayout {
            width: scrollView.availableWidth

            GridView {
                id: gridView
                Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
                Layout.preferredHeight: contentHeight
                Layout.alignment: Qt.AlignHCenter
                cellWidth: 400
                cellHeight: 240

                delegate: Item {
                    id: item
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    Comp.GoalItemDelegate {
                        anchors.centerIn: parent
                        imageSource: model.imageSource
                        category: model.category
                        goalName: model.name
                        endDateTime: Date.fromLocaleString(Qt.locale(), model.endDateTime, "dd MMM yyyy hh:mm AP")
                        progressValue: model.progressValue
                        targetValue: model.targetValue
                        unit: model.progressUnit

                        onClicked: stackView.push(goalInfoView, {"goal": dbAccess.getGoalItem(model.itemId)})
                        Component.onCompleted: {
                            if(item.GridView.view.cellWidth < implicitWidth) item.GridView.view.cellWidth = implicitWidth + 20
                            if(item.GridView.view.cellHeight < implicitHeight) item.GridView.view.cellHeight = implicitHeight + 20
                        }
                    }
                }

                Connections {
                    target: createGoalPopup
                    function onSave() {gridView.model.refresh()}
                }

                Connections {
                    target: mainView.StackView
                    function onActivating() {gridView.model.refresh()}
                }

                model: dbAccess.createGoalsTableModel()
            }
        }
    }
}
