import QtQuick
import QtQuick.Controls.Material

Button {
    anchors.right: parent.right
    anchors.rightMargin: 20
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 20

    Material.background: Material.color(Material.Lime, Material.Shade900)
    Material.elevation: 10
    Material.roundedScale: Material.SmallScale
}
