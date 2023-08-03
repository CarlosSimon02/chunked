import QtQuick as Q
import QtQuick.Controls.Material.impl as Q
import QtQuick.Controls.Material as Q

import components as C

Q.Pane {
    id: pane
    property Q.color backgroundColor: ColorScheme.primaryColor.light
    clip: false

    background: Q.Rectangle {
        clip: false
        color: pane.backgroundColor
        radius: Units.commonRadius

        layer.enabled: true
        layer.effect: Q.RoundedElevationEffect {
            elevation: 10
        }
    }
}
