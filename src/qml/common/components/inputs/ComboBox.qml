import QtQuick
import QtQuick.Controls.Material as Ctrl
import QtQuick.Controls.Material.impl

import components as Comp

Ctrl.ComboBox {
    id: control
    topInset: 0
    bottomInset: 0

    popup.background: Rectangle {
        radius: 4
        color: Comp.Globals.color.primary.shade3

        layer.enabled: control.enabled
        layer.effect: RoundedElevationEffect {
            elevation: 4
            roundedScale: Ctrl.Material.ExtraSmallScale
        }
    }
}
