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

    layer.samples: 8
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: control.width
            height: control.height

            radius: control.Material.roundedScale
        }
    }

    background: Rectangle {
        color: control.Material.backgroundColor


    }
}
