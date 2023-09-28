import QtQuick
import QtQuick.Controls

import components as Comp

Comp.Dialog {
    id: dialog
    title: "Select Date and Time"
    parent: Overlay.overlay
    anchors.centerIn: parent
    standardButtons: Dialog.Ok | Dialog.Cancel

    Connections {
        target: backdrop
        function onTapped() {
            dialog.close()
        }
    }

    onAboutToShow: {
        backdrop.open()
    }

    onAboutToHide: backdrop.close()
}
