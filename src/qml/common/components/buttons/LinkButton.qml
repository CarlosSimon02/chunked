import QtQuick
import QtQuick.Controls.Basic

import components as Comp

Button {
    padding: 0
    horizontalPadding: 0
    background: null
    icon.width: 15
    icon.height: 15
    icon.color: down ? Comp.Globals.color.secondary.shade3 :
                       hovered ? Comp.Globals.color.secondary.shade4 :
                                 Comp.Globals.color.secondary.shade2
}
