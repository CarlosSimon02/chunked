import QtQuick
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects

import components as Comp

Ctrl.Pane {
    id: pane
    property color backgroundColor: ColorScheme.primaryColor.light
    property bool elevated: false
    focusPolicy: Qt.ClickFocus
    clip: true

    background: Rectangle {
        color: pane.backgroundColor
        radius: Consts.commonRadius

        layer.enabled: pane.elevated
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
