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

            TapHandler {
                onTapped: gridView.forceActiveFocus()
            }

            remove: Transition {
                ParallelAnimation {
                    NumberAnimation { property: "opacity"; to: 0; duration: 1000 }
                    NumberAnimation { properties: "x,y"; to: 100; duration: 1000 }
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

//                SequentialAnimation {
//                       id: removeAnimation
//                       PropertyAction { target: item; property: "GridView.delayRemove"; value: true }
//                       NumberAnimation { target: item; property: "scale"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
//                       PropertyAction { target: item; property: "GridView.delayRemove"; value: false }
//                }
//                GridView.onRemove: removeAnimation.start()

                Comp.GoalItemDelegate {
                    anchors.centerIn: parent
                    itemId: model.itemId ? model.itemId : 0
                    imageSource: model.imageSource ? model.imageSource : ""
                    category: model.category ? model.category : ""
                    goalName: model.name ? model.name : ""
                    startDateTime: Date.fromLocaleString(Qt.locale(), model.startDateTime, "dd MMM yyyy hh:mm AP")
                    endDateTime: Date.fromLocaleString(Qt.locale(), model.endDateTime, "dd MMM yyyy hh:mm AP")
                    progressValue: model.progressValue ? model.progressValue : 0
                    targetValue: model.targetValue ? model.targetValue : 0
                    unit: model.progressUnit ? model.progressUnit : ""
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
