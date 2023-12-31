import QtQuick 
import QtQuick.Controls.Material as Ctrl
import QtQuick.Controls.Material.impl

import components as Comp

Ctrl.ItemDelegate {
    id: control
    implicitWidth: 50
    implicitHeight: 50
    padding: 0
    horizontalPadding: 15
    icon.width: 18
    icon.height: 18
    font.pixelSize: Comp.Globals.fontSize.medium

    Ctrl.Material.foreground: Comp.Globals.color.secondary.shade2
    Ctrl.Material.roundedScale: Ctrl.Material.SmallScale

    background: Rectangle {
        implicitHeight: control.Ctrl.Material.delegateHeight
        radius: control.Ctrl.Material.roundedScale === Ctrl.Material.FullScale ? height / 2 : control.Ctrl.Material.roundedScale
        color: control.highlighted ? control.Ctrl.Material.listHighlightColor : "transparent"

        Ripple {
            width: parent.width
            height: parent.height
            clipRadius: parent.radius
            clip: visible
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.Ctrl.Material.rippleColor
        }
    }
}
