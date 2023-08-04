import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import body.components as B

Pane {
    signal goalAdded
    property alias model: gridView.model
    background: null
    clip: true

    ColumnLayout {
        anchors.fill: parent  

        GridView {
            id: gridView
            Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            cellWidth: 420
            cellHeight: 510

            delegate: Item {
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                B.GoalItemDelegate {
                    anchors.centerIn: parent
//                    imageSource: model.imageSource
//                    category: model.category
//                    goalName: model.name
//                    timeRemaining: "1d 3h remaining"
//                    progressBar.value: model.progressValue
//                    progressBar.to: model.targetValue
//                    unit: model.progressUnit
                    onClicked: {
                        popups.goalInfoView.open()
                        popups.goalInfoView.goal.id = model.id
                    }
                }
            }

            model: GoalsTableModel {
                id: goalsTableModel
            }
        }
    }
}
