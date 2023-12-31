import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import app

import components as Comp

ComboBox {
    id: comboBox

    enum TrackerType {
        Goals,
        Tasks,
        Habits
    }

    property int itemId: 0
    property int trackerType: GoalNamesTreeViewComboBox.TrackerType.Goals

    delegate: null
    topInset: 0
    bottomInset: 0

    model: GoalNamesTreeViewModel {}

    popup: Popup {
        y: comboBox.height
        width: comboBox.width
        height: contentItem.childrenRect.height + topPadding + bottomPadding
        transformOrigin: Item.Top
        topMargin: 12
        bottomMargin: 12
        padding: 10

        enter: Transition {
            NumberAnimation { property: "scale"; from: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            NumberAnimation { property: "scale"; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        TreeView {
            id: treeView
            width: parent.width
            height: Math.min(400, 40*rows)
            model: comboBox.model
            clip: true

            delegate: Item {
                id: item

                property alias goalName: goalName.text
                readonly property real indent: 20
                required property TreeView treeView
                required property bool expanded
                required property int hasChildren
                required property int depth

                implicitWidth: itemDelegate.implicitWidth + itemDelegate.x
                implicitHeight: 40

                ItemDelegate {
                    id: itemDelegate
                    verticalPadding: 0
                    height: 40
                    x: item.indent * item.depth
                    highlighted: comboBox.itemId === model.id
                    font.strikeout: !enabled
                    enabled: {
                        if(model.id === 0) return true
                        else if((model.progressTracker === 0 || model.progressTracker === 1) && comboBox.trackerType === 0) return true
                        else if((model.progressTracker === 2 || model.progressTracker === 3) && comboBox.trackerType === 1) return true
                        else if((model.progressTracker === 4 || model.progressTracker === 5) && comboBox.trackerType === 2) return true
                        return false
                    }

                    onClicked: {
                        comboBox.itemId = model.id
                        comboBox.displayText = model.goalName
                        comboBox.popup.close()
                    }

                    contentItem: RowLayout {
                        Button {
                            padding: 4
                            icon.source: item.expanded ? "qrc:/dropdown_open_icon.svg" : "qrc:/dropdown_close_icon.svg"
                            icon.width: 12
                            icon.height: 12
                            visible: item.hasChildren
                            onClicked: treeView.toggleExpanded(model.row)
                        }

                        Text {
                            id: goalName
                            text: model.goalName
                            font: itemDelegate.font
                            color: "white"
                        }
                    }

                    Component.onCompleted: {
                        if(comboBox.itemId === model.id) {
                            comboBox.displayText = model.goalName
                        }
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                parent: treeView
                x: treeView.mirrored ? 0 : treeView.width - width
                height: treeView.availableHeight
                active: treeView.ScrollBar.horizontal.active
            }

            ScrollBar.horizontal: ScrollBar {
                parent: treeView
                y: treeView.height - height
                width: treeView.availableWidth
                active: treeView.ScrollBar.vertical.active
            }
        }
    }
}
