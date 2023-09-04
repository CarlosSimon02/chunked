import QtQuick
import QtQuick.Controls as Ctrl
import Qt5Compat.GraphicalEffects

import components as Comp
import components.impl as Impl

Ctrl.Dialog {
    id: dialog
    implicitWidth: 300
    padding: 20
    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose
    parent: Ctrl.Overlay.overlay
    anchors.centerIn: parent

    property alias contentText: contentText.text

    Ctrl.Overlay.modal: Rectangle {
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.dark, 0.3)
    }

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius

        layer.enabled: true
        layer.effect: Impl.DropShadow {}
    }

    header: Ctrl.Label {
        text: dialog.title
        wrapMode: Ctrl.Label.Wrap
        font.pixelSize: 18
        font.bold: true
        padding: dialog.padding
        bottomPadding: 6
        color: Comp.ColorScheme.secondaryColor.regular
    }

    Comp.Text {
        id: contentText
        width: dialog.availableWidth
        wrapMode: Text.Wrap
    }

    footer: Ctrl.DialogButtonBox {
        padding: dialog.padding
        topPadding: 0
        alignment: Qt.AlignRight
        background: null

        delegate: Comp.Button {
            implicitWidth: 80
            property bool isAccent: Ctrl.DialogButtonBox.buttonRole === Ctrl.DialogButtonBox.AcceptRole ||
                                    Ctrl.DialogButtonBox.buttonRole === Ctrl.DialogButtonBox.YesRole ||
                                    Ctrl.DialogButtonBox.buttonRole === Ctrl.DialogButtonBox.ApplyRole
            foregroundColor: isAccent ? Comp.ColorScheme.secondaryColor.regular : Comp.ColorScheme.secondaryColor.regular
            backgroundColor: isAccent ? Comp.ColorScheme.accentColor.dark : "transparent"
            fadeEffectColor: isAccent ? "black" : Comp.ColorScheme.secondaryColor.regular
            border.width: isAccent ? 0 : 1
        }
    }
}
