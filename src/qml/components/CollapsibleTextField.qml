import QtQuick
import QtQuick.Controls

import components as Comp

Comp.TextField {
    leftPadding: iconLabel.width
    property alias iconSource: iconLabel.icon.source

    IconLabel {
        id: iconLabel
        x: 0
        y: 0
        height: parent.height
        width: parent.height
        icon.width: 20
        icon.height: 20
        icon.color: Comp.ColorScheme.secondaryColor.veryDark
        display: IconLabel.IconOnly
    }
}
