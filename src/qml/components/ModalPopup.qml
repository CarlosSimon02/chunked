import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import components as Comp

Comp.Popup {
    id: popup
    padding: 0
    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose
    parent: Overlay.overlay
    anchors.centerIn: parent

    Overlay.modal: Rectangle {
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
    }
}
