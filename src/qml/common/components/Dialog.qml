import QtQuick
import QtQuick.Controls.Material as Ctrl

import components as Comp

//This dialog requires you to open and close backdrop if you want background to be non interactive
Ctrl.Dialog {
    id: control
    Ctrl.Material.roundedScale: Ctrl.Material.SmallScale
    Ctrl.Material.background: Comp.Globals.color.primary.shade3
    Ctrl.Overlay.modal: null
    topMargin: topBarView.height
    modal: false
    padding: 20

    header: Ctrl.Label {
        text: control.title
        visible: control.title
        elide: Ctrl.Label.ElideRight
        padding: 20
        bottomPadding: 0

        font.pixelSize: Comp.Globals.fontSize.large
    }

    footer: Ctrl.DialogButtonBox {
        Ctrl.Material.roundedScale: Ctrl.Material.SmallScale
        Ctrl.Material.accent: Comp.Globals.color.accent.shade1

        delegate: Ctrl.Button {
            flat: true

            Ctrl.Material.roundedScale: Ctrl.Material.SmallScale
        }
    }
}
