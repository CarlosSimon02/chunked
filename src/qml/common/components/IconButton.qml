import QtQuick
import QtQuick.Controls.Material as Ctrl
import QtQuick.Controls.Material.impl

Ctrl.Button {
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

    Ctrl.Material.roundedScale: Ctrl.Material.SmallScale

    background: Rectangle {
        radius: control.Ctrl.Material.roundedScale === Ctrl.Material.FullScale ? height / 2 : control.Ctrl.Material.roundedScale
        color: control.Ctrl.Material.buttonColor(control.Ctrl.Material.theme, control.Ctrl.Material.background,
            control.Ctrl.Material.accent, control.enabled, control.flat, control.highlighted, control.checked)

        // The layer is disabled when the button color is transparent so you can do
        // Ctrl.Material.background: "transparent" and get a proper flat button without needing
        // to set Ctrl.Material.elevation as well
        layer.enabled: control.enabled && color.a > 0 && !control.flat
        layer.effect: RoundedElevationEffect {
            elevation: control.Ctrl.Material.elevation
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
            color: control.flat && control.highlighted ? control.Ctrl.Material.highlightedRippleColor : control.Ctrl.Material.rippleColor
        }
    }
}
