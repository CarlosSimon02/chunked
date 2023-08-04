import QtQuick
import QtQuick.Controls.Material.impl
import QtQuick.Controls as Ctrl

import components as Comp

Ctrl.Popup {
    padding: 20
    background: Rectangle {
        clip: false
        color: Comp.ColorScheme.primaryColor.regular
        radius: Units.commonRadius
        layer.enabled: true
        layer.effect: RoundedElevationEffect {
            elevation: 10
        }
    }
}
