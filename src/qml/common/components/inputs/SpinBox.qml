import QtQuick
import QtQuick.Controls.Material as Ctrl
import QtQuick.Controls.Material.impl

import components as Comp

Ctrl.SpinBox {
    id: control
    property bool hasError

    Ctrl.Material.accent: Comp.Globals.color.accent.shade1

    background: MaterialTextContainer {
        implicitWidth: 120
        implicitHeight: control.Ctrl.Material.textFieldHeight

        filled: false
        fillColor: control.Ctrl.Material.textFieldFilledContainerColor
        outlineColor: control.hasError ? "red" : (enabled && control.hovered) ? control.Ctrl.Material.primaryTextColor : control.Ctrl.Material.hintTextColor
        focusedOutlineColor: control.hasError ? "red" : control.Ctrl.Material.accentColor
        // When the control's size is set larger than its implicit size, use whatever size is smaller
        // so that the gap isn't too big.
        controlHasActiveFocus: control.activeFocus
        horizontalPadding: control.Ctrl.Material.textFieldHorizontalPadding
    }
}
