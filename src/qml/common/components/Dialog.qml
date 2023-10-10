import QtQuick
import QtQuick.Controls.Material as Ctrl

import components as Comp

//This dialog requires you to open and close backdrop if you want background to be non interactive
//Use lazy loading as much as possible when using dialog
Ctrl.Dialog {
    id: control
    margins: 10
    topMargin: topBarView.height + 10
    modal: false
    padding: 20

    Ctrl.Material.roundedScale: Ctrl.Material.SmallScale
    Ctrl.Material.background: Comp.Globals.color.primary.shade3
    Ctrl.Overlay.modal: null

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
            font.pixelSize: Comp.Globals.fontSize.medium
        }
    }
}
