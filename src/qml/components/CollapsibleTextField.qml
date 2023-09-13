import QtQuick
import QtQuick.Controls

import components as Comp

Comp.TextField {
    leftPadding: iconLabel.width + 6
    property alias iconSource: iconLabel.icon.source

    IconLabel {
        id: iconLabel
        height: parent.height
        leftPadding: 15
        icon.width: 20
        icon.height: 20
        icon.color: Comp.ColorScheme.secondaryColor.veryDark
        display: IconLabel.IconOnly
    }
}
