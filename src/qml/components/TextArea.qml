import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl
import QtQuick.Templates as T

import components as Comp

T.TextArea {
    id: textArea

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    leftPadding: 15
    rightPadding: 15
    topPadding: 15
    bottomPadding: 15
    wrapMode: TextArea.Wrap

    color: enabled ? Comp.ColorScheme.secondaryColor.regular : Comp.ColorScheme.secondaryColor.dark
    placeholderTextColor: textArea.palette.placeholderText
    selectionColor: textArea.palette.highlight
    selectedTextColor: textArea.palette.highlightedText

    property bool hasInvalidInput
    onTextChanged: if(hasInvalidInput) hasInvalidInput = false

    cursorDelegate: CursorDelegate {
        width: 1.5
        color: Comp.ColorScheme.secondaryColor.regular
    }

    background: Rectangle {
        implicitHeight: 52
        color: "transparent"
        border.width: 1
        border.color: textArea.hasInvalidInput ? "red" :
                                                 textArea.activeFocus ? Comp.ColorScheme.accentColor.regular :
                                                 Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Consts.commonRadius
    }

    PlaceholderText {
        id: placeholder
        x: textArea.leftPadding
        y: textArea.topPadding
        width: textArea.width - (textArea.leftPadding + textArea.rightPadding)
        height: textArea.height - (textArea.topPadding + textArea.bottomPadding)

        text: textArea.placeholderText
        font: textArea.font
        color: Comp.ColorScheme.secondaryColor.veryDark
        verticalAlignment: textArea.verticalAlignment
        visible: !textArea.length && !textArea.preeditText && (!textArea.activeFocus || textArea.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: textArea.renderType
    }
}
