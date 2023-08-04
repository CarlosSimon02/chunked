import QtQuick 
import QtQuick.Controls.Material.impl 
import QtQuick.Controls.Material 

import components as Comp

Page {
    id: page
    property color backgroundColor: ColorScheme.primaryColor.regular
    clip: false

    background: Rectangle {
        color: page.backgroundColor
        radius: Units.commonRadius

        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: 10
        }
    }
}
