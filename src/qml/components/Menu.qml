import QtQuick
import QtQuick.Controls as Ctrl

import components as Comp
import components.impl as Impl

Ctrl.Menu {
    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius

        layer.enabled: true
        layer.effect: Impl.DropShadow {}
    }
}
