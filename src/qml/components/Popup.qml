import QtQuick
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects

import components as Comp
import components.impl as Impl

Ctrl.Popup {
    padding: 10

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius

        layer.enabled: true
        layer.effect: Impl.DropShadow {}
    }
}
