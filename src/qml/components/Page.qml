import QtQuick as Q
import QtQuick.Controls.Material.impl as Q
import QtQuick.Controls.Material as Q

import components as C

Q.Page {
    id: page
    property Q.color backgroundColor: ColorScheme.primaryColor.regular
    clip: false

    background: Q.Rectangle {
        color: page.backgroundColor
        radius: Units.commonRadius

        layer.enabled: true
        layer.effect: Q.ElevationEffect {
            elevation: 10
        }
    }
}
