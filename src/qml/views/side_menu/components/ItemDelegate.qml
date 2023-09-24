import QtQuick 
import QtQuick.Controls.Material as Ctrl

Ctrl.ItemDelegate {
    id: iconLabelItemDelegate
    implicitWidth: 50
    implicitHeight: 50
    padding: 0
    horizontalPadding: 15
    icon.width: 18
    icon.height: 18

    Ctrl.Material.foreground: Ctrl.Material.color(Ctrl.Material.Grey, Ctrl.Material.Shade400)
    Ctrl.Material.roundedScale: Ctrl.Material.SmallScale
}
