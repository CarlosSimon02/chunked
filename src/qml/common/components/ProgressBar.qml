import QtQuick
import QtQuick.Controls.Material as Ctrl
import QtQuick.Layouts

import components as Comp

RowLayout {
    id: rowLayout

    property int value: 0
    property int target: 0
    property alias fontPixelSize: text.font.pixelSize

    implicitWidth: 300
    implicitHeight: 50

    Ctrl.ProgressBar {
        id: progressBar
        Layout.fillWidth: true
        Ctrl.Material.accent: Ctrl.Material.color(Ctrl.Material.Lime, Ctrl.Material.Shade900)
        value: rowLayout.target ? rowLayout.value / rowLayout.target : 0
    }

    Text {
        id: text
        text: rowLayout.target ? Math.floor((rowLayout.value / rowLayout.target) * 100) + "%" : "??"
        font.pixelSize: rowLayout.fontPixelSize
        color: Ctrl.Material.color(Ctrl.Material.Lime, Ctrl.Material.Shade900)
    }
}
