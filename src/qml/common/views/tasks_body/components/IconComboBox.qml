import QtQuick
import QtQuick.Controls.Material

import components as Comp
import components.inputs as Inpt

Inpt.ComboBox {
    implicitHeight: 45
    leftPadding: 26

    property alias icon: iconLabel.icon

    IconLabel {
        id: iconLabel
        anchors.left: parent.left
        anchors.leftMargin: 12
        height: parent.height
        icon.width: 20
        icon.height: 20
        icon.color: Comp.Globals.color.secondary.shade1
    }
}
