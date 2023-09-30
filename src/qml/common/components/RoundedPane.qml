import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

Pane {
    id: control

    Material.roundedScale: Material.SmallScale
    Material.background: Comp.Globals.color.primary.shade3
    clip: true

    background: Rectangle {
        color: Comp.Globals.color.primary.shade2
        radius: Material.SmallScale
    }
}
