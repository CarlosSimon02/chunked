import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    horizontalPadding: 10

    property bool isSubGoal: false
    property bool hasImage: true

    contentItem: RowLayout {

        RowLayout {
            CheckBox {

            }

            Text {
                Layout.fillWidth: true
                text: "This is my sample task"
                color: Comp.Globals.color.secondary.shade3
                font.pixelSize: Comp.Globals.fontSize.medium
            }
        }

        Text {
            text: "1h 40m remaining"
            font.pixelSize: Comp.Globals.fontSize.small
            color: "green"
        }
    }

    background: Rectangle {
        radius: Material.SmallScale
        color: Comp.Globals.color.primary.shade3

        Rectangle {
            width: parent.width
            height: parent.height
            radius: parent.radius
            visible: enabled && (control.hovered || control.visualFocus)
            color: control.Material.rippleColor
        }

        Rectangle {
            width: parent.width
            height: parent.height
            radius: parent.radius
            visible: control.down
            color: control.Material.rippleColor
        }
    }
}
