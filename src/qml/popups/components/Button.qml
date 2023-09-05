import QtQuick
import QtQuick.Controls

import components as Comp

Comp.Button {
    backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular,0.1) : "transparent"
}
