import QtQuick
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects

import components as Comp
import components.impl as Impl

Ctrl.Dialog {
    id: dialog
    padding: 10
    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose
    parent: Ctrl.Overlay.overlay
    anchors.centerIn: parent

    Ctrl.Overlay.modal: Rectangle {
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
    }

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius

        layer.enabled: true
        layer.effect: Impl.DropShadow {}
    }

    header: Comp.Text {
        text: dialog.title
        font.pixelSize: 16
        font.bold: true
    }
}
