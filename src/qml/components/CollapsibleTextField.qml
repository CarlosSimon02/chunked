import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

RowLayout {
    spacing: -button.Layout.preferredWidth

    Comp.Button {
        id: button
        height: parent.height
        width: parent.height
        display: Button.IconOnly
        icon.color: Comp.ColorScheme.secondaryColor.veryDark
    }
    Comp.TextField {
        id: textField
        leftPadding: button.width + 15
        property alias iconSource: button.icon.source


    }
}


