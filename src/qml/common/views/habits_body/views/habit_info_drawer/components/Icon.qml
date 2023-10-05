import QtQuick
import QtQuick.Controls.Material

import components as Comp

IconLabel {
    icon.width: 18
    icon.height: 18
    icon.color: Comp.Globals.color.secondary.shade2
    display: IconLabel.IconOnly

    HoverHandler {
        id: hover
    }

    ToolTip.visible: hover.hovered
}
