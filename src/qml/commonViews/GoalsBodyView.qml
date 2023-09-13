import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp
import popups as Pop

Comp.Pane {
    id: pane
    background: null
    padding: 0
    property int parentGoalId: 0
    signal refresh
    onRefresh: gridView.model.refresh()

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.maximumWidth: Number.POSITIVE_INFINITY
            Layout.margins: 20

            RowLayout {
                spacing: 15
                Comp.AccentButton {
                    Layout.preferredHeight: 40
                    horizontalPadding: 15
                    spacing: 5
                    icon.source: "qrc:/create_icon.svg"
                    icon.width: 15
                    icon.height: 15
                    text: "New Goal"
                    onClicked: {
                        createEditGoalPopup.parentGoalId = pane.parentGoalId
                        createEditGoalPopup.open()
                    }

                    Pop.CreateEditGoalPopup {
                        id: createEditGoalPopup
                    }
                }

                Comp.CollapsibleTextField {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 300
                    iconSource: "qrc:/search_icon.svg"
                    placeholderText: "Search goal"
                }

            }

            RowLayout {
                spacing: 15
                Layout.alignment: Qt.AlignRight

                Comp.CollapsibleTextField {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    iconSource: "qrc:/category_icon.svg"
                    placeholderText: "Search goal"
                }

                Comp.CollapsibleTextField {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    iconSource: "qrc:/status_icon.svg"
                    placeholderText: "Search goal"
                }
            }
        }

        GridView {
            id: gridView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            leftMargin: (parent.width - contentWidth) / 2
            contentWidth:(Math.floor(parent.width / cellWidth) * cellWidth)
            clip: true
            cellWidth: pane.parentGoalId ? 340 : 400

            TapHandler {
                onTapped: gridView.forceActiveFocus()
            }

            ScrollBar.vertical: Comp.ScrollBar {
                parent: gridView
                x: gridView.mirrored ? 0 : gridView.width - width
                height: gridView.availableHeight
                active: gridView.ScrollBar.horizontal.active
            }

            ScrollBar.horizontal: Comp.ScrollBar {
                parent: gridView
                y: gridView.height - height
                width: gridView.availableWidth
                active: gridView.ScrollBar.vertical.active
            }

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
                    subGoal: pane.parentGoalId

                    Component.onCompleted: {
                        if(item.GridView.view.cellHeight < implicitHeight)
                            item.GridView.view.cellHeight = implicitHeight + 20
                    }
                }
            }

            model: GoalsTableModel {
                parentGoalId: pane.parentGoalId
            }

            Connections {
                target: createEditGoalPopup
                function onSave() {pane.refresh()}
            }
        }
    }
}
