import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import body.components as Body

Pane {
    signal goalAdded
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
                cellWidth: 420
                cellHeight: 510

                delegate: Item {
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    Body.GoalItemDelegate {
                        anchors.centerIn: parent
                        imageSource: model.imageSource
                        category: model.category
                        goalName: model.name
                        timeRemaining: "1d 3h remaining"
                        progressValue: model.progressValue
                        targetValue: model.targetValue
                        unit: model.progressUnit
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
}
