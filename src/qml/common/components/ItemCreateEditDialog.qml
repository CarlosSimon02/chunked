import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp

Comp.Dialog {
    id: dialog
    parent: Overlay.overlay
    anchors.centerIn: parent
    padding: 0

    signal cancel
    signal save

    Material.accent: Comp.Globals.color.accent.shade1

    footer: RowLayout {
        RowLayout {
            Layout.margins: 10
            Layout.alignment: Qt.AlignRight

            Button {
                text: "Cancel"
                Material.foreground: Comp.Globals.color.accent.shade1
                Material.roundedScale: Material.SmallScale
                flat: true
                onClicked: dialog.cancel()
            }

            Button {
                text: "Save"
                Material.foreground: Comp.Globals.color.accent.shade1
                Material.roundedScale: Material.SmallScale
                flat: true
                onClicked: dialog.save()
            }
        }
    }

    Connections {
        target: backdrop
        function onTapped() {
            dialog.close()
        }
    }

    onAboutToShow: {
        backdrop.open()
    }

    onAboutToHide: {
        backdrop.close()
    }
}
