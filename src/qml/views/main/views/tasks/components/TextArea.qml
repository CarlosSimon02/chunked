import QtQuick 2.15

import components as Comp
import components.impl as Impl

Comp.TextArea {
    id: textArea

    background: Rectangle {
        implicitHeight: 50
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius
        border.width: 1
        border.color: textArea.activeFocus ? Comp.ColorScheme.accentColor.regular :
                                             Comp.ColorScheme.secondaryColor.dark
    }
}
