import QtQuick
import QtQuick.Controls.Material

import components as Comp

RoundButton {
    id: control
    padding: 10
    topInset: 0
    leftInset: 0
    rightInset: 0
    bottomInset: 0

    font.weight: highlighted ? Font.DemiBold : Font.Normal
    highlighted: ListView.isCurrentItem
    flat: false
    radius: Material.SmallScale
    font.capitalization: Font.MixedCase

    Material.background: highlighted ? Comp.Globals.color.secondary.shade1 :
                                       Comp.Globals.color.primary.shade3
}
