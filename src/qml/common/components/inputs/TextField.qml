import QtQuick
import QtQuick.Controls.Material as Ctrl
import QtQuick.Controls.Material.impl

//This TextField has capability for handling errors
Ctrl.TextField {
    id: control
    property bool hasError

    cursorDelegate: CursorDelegate {
        color: control.hasError ? "red" : control.Ctrl.Material.accent
    }

    FloatingPlaceholderText {
        id: placeholder
        x: control.leftPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        elide: Text.ElideRight
        renderType: control.renderType

        filled: control.Ctrl.Material.containerStyle === Ctrl.Material.Filled
        verticalPadding: control.Ctrl.Material.textFieldVerticalPadding
        controlHasActiveFocus: control.activeFocus
        controlHasText: control.length > 0
        controlImplicitBackgroundHeight: control.implicitBackgroundHeight
        controlHeight: control.height
    }

    background: MaterialTextContainer {
        implicitWidth: 120
        implicitHeight: control.Ctrl.Material.textFieldHeight

        filled: control.Ctrl.Material.containerStyle === Ctrl.Material.Filled
        fillColor: control.Ctrl.Material.textFieldFilledContainerColor
        outlineColor: control.hasError ? "red" : (enabled && control.hovered) ? control.Ctrl.Material.primaryTextColor : control.Ctrl.Material.hintTextColor
        focusedOutlineColor: control.hasError ? "red" : control.Ctrl.Material.accentColor
        // When the control's size is set larger than its implicit size, use whatever size is smaller
        // so that the gap isn't too big.
        placeholderTextWidth: Math.min(placeholder.width, placeholder.implicitWidth) * placeholder.scale
        controlHasActiveFocus: control.activeFocus
        controlHasText: control.length > 0
        placeholderHasText: placeholder.text.length > 0
        horizontalPadding: control.Ctrl.Material.textFieldHorizontalPadding
    }
}
