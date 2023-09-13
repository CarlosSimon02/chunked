import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl
import QtQuick.Templates as T

import components as Comp

T.TextField {
    id: textField

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    leftPadding: 15
    rightPadding: 15
    verticalAlignment: TextField.AlignVCenter

    color: enabled ? Comp.ColorScheme.secondaryColor.regular : Comp.ColorScheme.secondaryColor.dark
    placeholderTextColor: textField.palette.placeholderText
    selectionColor: textField.palette.highlight
    selectedTextColor: textField.palette.highlightedText

    cursorDelegate: CursorDelegate {
        width: 1.5
        color: Comp.ColorScheme.secondaryColor.regular
    }

    background: Rectangle {
        implicitHeight: 52
        color: "transparent"
        border.width: 1
        border.color: textField.activeFocus ? Comp.ColorScheme.accentColor.regular :
                                             Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Consts.commonRadius
    }

    PlaceholderText {
        id: placeholder
        x: textField.leftPadding
        y: textField.topPadding
        width: textField.width - (textField.leftPadding + textField.rightPadding)
        height: textField.height - (textField.topPadding + textField.bottomPadding)

        text: textField.placeholderText
        font: textField.font
        color: Comp.ColorScheme.secondaryColor.veryDark
        verticalAlignment: textField.verticalAlignment
        visible: !textField.length && !textField.preeditText && (!textField.activeFocus || textField.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: textField.renderType
    }
}
