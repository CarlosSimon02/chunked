import QtQuick
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects

import components as Comp

Ctrl.Pane {
    id: pane
    property color backgroundColor: ColorScheme.primaryColor.light

    background: Rectangle {
        clip: false
        color: pane.backgroundColor
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
