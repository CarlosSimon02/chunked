import QtQuick
import QtQuick.Controls

import components as Comp

Button {
    padding: 0
    background: null
    icon.source: "qrc:/close_icon.svg"
    icon.width: 15
    icon.height: 15
    icon.color: down ? Comp.Globals.color.secondary.shade2 :
                       hovered ? Comp.Globals.color.secondary.shade4 :
                                 Comp.Globals.color.secondary.shade3
}
