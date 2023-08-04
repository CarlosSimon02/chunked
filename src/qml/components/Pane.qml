import QtQuick
import QtQuick.Controls.Material.impl
import QtQuick.Controls.Material

import components as Comp

Pane {
    id: pane
    property color backgroundColor: ColorScheme.primaryColor.light
    clip: false

    background: Rectangle {
        clip: false
        color: pane.backgroundColor
        radius: Units.commonRadius

        layer.enabled: true
        layer.effect: RoundedElevationEffect {
            elevation: 10
        }
    }
}
