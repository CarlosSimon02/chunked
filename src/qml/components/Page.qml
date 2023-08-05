import QtQuick 
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects


import components as Comp

Ctrl.Page {
    id: page
    property color backgroundColor: Comp.ColorScheme.primaryColor.regular
    clip: false

    background: Rectangle {
        color: page.backgroundColor
        radius: Units.commonRadius

        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 2
            verticalOffset: 2
            spread: 0.2
            radius: 12
            samples: 17
            color: Comp.ColorScheme.primaryColor.shadow
        }
    }
}
