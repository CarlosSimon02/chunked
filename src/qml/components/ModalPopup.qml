import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import components as Comp

Popup {
    padding: 20
    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose
    parent: Overlay.overlay
    anchors.centerIn: parent

    Overlay.modal: Rectangle {
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
    }

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Units.commonRadius

        layer.enabled: true
        layer.effect: DropShadow {
            spread: 0.2
            radius: 10
            samples: 17
            color: Comp.ColorScheme.primaryColor.shadow
        }
    }
}
