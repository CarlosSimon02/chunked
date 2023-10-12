import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import components as Comp

Button {
    id: control
    implicitWidth: 40
    implicitHeight: 40
    padding: 0
    verticalPadding: 0
    leftPadding: 0
    rightPadding: 0
    leftInset: 0
    rightInset: 0
    topInset: 0
    bottomInset: 0
    flat: true
    icon.width: 30
    icon.height: 30

    Material.roundedScale: Material.SmallScale

    background: Rectangle {
        radius: control.Material.roundedScale === Material.FullScale ? height / 2 : control.Material.roundedScale
        color: control.Material.buttonColor(control.Material.theme, control.Material.background,
            control.Material.accent, control.enabled, control.flat, control.highlighted, control.checked)

        layer.enabled: control.enabled && color.a > 0 && !control.flat
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }

        Ripple {
            clip: true
            clipRadius: parent.radius
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.flat && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }
}
