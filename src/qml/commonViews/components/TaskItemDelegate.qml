import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Comp.ItemDelegate {
    id: itemDelegate
    implicitHeight: 50
    implicitWidth: 600
    horizontalPadding: 20
    backgroundColor: Comp.ColorScheme.primaryColor.light
    fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
    elevated: true
    font.pixelSize: 15
    font.weight: Font.Normal
    signal setDone

    property alias taskDone: checkBox.checkState
    property alias name: name.text

    contentItem: Item {
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter

            Comp.CheckBox {
                id: checkBox
                onClicked: itemDelegate.setDone()
            }

            Comp.Text {
                id: name
                font: itemDelegate.font
            }
        }
    }
}
