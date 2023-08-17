import QtQuick
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects

import components as Comp

Ctrl.Popup {
    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius

        layer.enabled: true
        layer.effect: DropShadow {
            spread: 0.2
            radius: 10
            samples: 17
            color: Comp.ColorScheme.primaryColor.shadow
        }
    }
}
