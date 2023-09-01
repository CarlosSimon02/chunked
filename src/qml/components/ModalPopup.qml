import QtQuick
import QtQuick.Controls

import components as Comp

Comp.Popup {
    padding: 20
    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose
    parent: Overlay.overlay
    anchors.centerIn: parent

    Overlay.modal: Rectangle {
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }
}
