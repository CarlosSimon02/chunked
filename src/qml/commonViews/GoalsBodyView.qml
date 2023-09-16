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

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.maximumWidth: Number.POSITIVE_INFINITY
            Layout.margins: 20
            Layout.leftMargin: pane.parentGoalId ? 0 : 20
            Layout.rightMargin: pane.parentGoalId ? 0 : 20

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

                Comp.TextField {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 300
                    iconSource: "qrc:/search_icon.svg"
                    placeholderText: "Search goal"
                }

            }

            RowLayout {
                spacing: 15
                Layout.alignment: Qt.AlignRight

                Comp.ComboBox {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    visible: !pane.parentGoalId
                    iconSource: "qrc:/category_icon.svg"
                    model: ["All", "Personal", "Home", "Work"]
                }

                Comp.ComboBox {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    iconSource: "qrc:/status_icon.svg"
                    model: ["All", "Pending", "Active", "Done", "Unfinished"]
                }

                Comp.Button {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    icon.source: "qrc:/filter_icon.svg"
                    border.width: 1
                    foregroundColor: Comp.ColorScheme.secondaryColor.dark
                }

                Comp.Button {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    icon.source: "qrc:/option_icon.svg"
                    border.width: 1
                    foregroundColor: Comp.ColorScheme.secondaryColor.dark
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

            add: Transition {
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 400 }
                        NumberAnimation { property: "scale"; from: 0.7; to: 1; duration: 400 }
                    }
                }
            }

//            remove: Transition {
//                id: sampleTrans
//                SequentialAnimation {
//                    PropertyAction { target: sampleTrans; property: "ViewTransition.item.GridView.delayRemove"; value: true }
//                    ParallelAnimation {
//                        NumberAnimation { property: "opacity"; to: 0; duration: 400 }
//                        NumberAnimation { property: "scale"; to: 0.7; duration: 400 }
//                    }
//                    PropertyAction { target: sampleTrans; property: "ViewTransition.item.GridView.delayRemove"; value: false }
//                    ScriptAction {
//                        script: {
////                            gridView.model.testRemove(sampleTrans.ViewTransition.index);
//                            gridView.model.refresh()
//                        }
//                    }
//                }
//            }

            displaced: Transition {

                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnimation { properties: "x,y"; duration: 400; easing.type: Easing.OutQuad }

                        // ensure opacity and scale values return to 1.0
                        NumberAnimation { property: "opacity"; to: 1.0 }
                        NumberAnimation { property: "scale"; to: 1.0 }
                    }

                    ScriptAction {
                        script: {
                            gridView.model.submitRemoveRow()
                        }
                    }
                }
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

                GridView.onRemove: remAnim.running = true

                SequentialAnimation {
                    id: remAnim
                    PropertyAction { target: item; property: "GridView.delayRemove"; value: true }
                    ParallelAnimation {
                        NumberAnimation {target: item; property: "opacity"; to: 1; duration: 200 }
                        NumberAnimation {target: item; property: "scale"; to: 0.7; duration: 200 }
                    }
                    PropertyAction { target: item; property: "GridView.delayRemove"; value: false }
                }

                Comp.GoalItemDelegate {
                    id: goalItemDelegate
                    property int someIndex
                    anchors.centerIn: parent
                    itemId: model.itemId
                    imageSource: model.imageSource
                    category: model.category
                    goalName: model.name
                    startDateTime: Date.fromLocaleString(Qt.locale(),
                                                         model.startDateTime,
                                                         "dd MMM yyyy hh:mm AP")
                    endDateTime: Date.fromLocaleString(Qt.locale(),
                                                     model.endDateTime,
                                                     "dd MMM yyyy hh:mm AP")
                    progressValue: model.progressValue
                    targetValue: model.targetValue
                    unit: model.progressUnit
                    subGoal: pane.parentGoalId

                    Component.onCompleted: {
                        if(item.GridView.view.cellHeight < implicitHeight)
                            item.GridView.view.cellHeight = implicitHeight + 20
//                        else if(item.GridView.view.cellHeight > implicitHeight || gridView.count === 1) {
//                            item.GridView.view.cellHeight = implicitHeight + 20
//                        }

                        someIndex = model.index
                    }
                }
            }

            model: GoalsTableModel {
                parentGoalId: pane.parentGoalId
            }

            TapHandler {
                onTapped: gridView.forceActiveFocus()
            }

            Connections {
                target: createEditGoalPopup
                function onSave() {pane.refresh()}
            }
        }
    }
}
