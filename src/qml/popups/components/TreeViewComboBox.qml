import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import app

import "." as Pop
import components as Comp

Pop.ComboBox {
    id: comboBox
    delegate: null

    popup: T.Popup {
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

        background: Rectangle {
            color: Comp.ColorScheme.primaryColor.light
            radius: Comp.Units.commonRadius

            layer.enabled: true
            layer.effect: DropShadow {
                spread: 0.2
                radius: 10
                samples: 17
                color: Comp.ColorScheme.primaryColor.shadow
            }
        }

        TreeView {
            id: treeView
            width: parent.width
            height: Math.min(400, 40*rows)
            model: comboBox.model
            clip: true
            delegate: Item {
                implicitWidth: itemDelegate.implicitWidth + x
                implicitHeight: 40
                id: item
                readonly property real indent: 20
                required property TreeView treeView
                required property bool isTreeNode
                required property bool expanded
                required property int hasChildren
                required property int depth

                Comp.ItemDelegate {
                    id: itemDelegate

                    x: item.indent * item.depth

                    contentItem: RowLayout {
                        Comp.Button {
                            text: "C"
                            verticalPadding: 0
                            onClicked: treeView.expand(model.row)
                        }

                        Text {
                            text: model.goalName
                            font: itemDelegate.font
                            color: itemDelegate.foregroundColor
                        }

                        Text {
                            text: model.id
                            font: itemDelegate.font
                            color: itemDelegate.foregroundColor
                        }
                    }
                }
            }

            ScrollBar.vertical: Comp.ScrollBar {
                parent: treeView
                x: treeView.mirrored ? 0 : treeView.width - width
                height: treeView.availableHeight
                active: treeView.ScrollBar.horizontal.active
            }

            ScrollBar.horizontal: Comp.ScrollBar {
                parent: treeView
                y: treeView.height - height
                width: treeView.availableWidth
                active: treeView.ScrollBar.vertical.active
            }
        }
    }
}
