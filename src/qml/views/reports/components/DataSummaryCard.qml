import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Frame {
    implicitWidth: 300
    horizontalPadding: 20
    property alias iconSource: icon.icon.source
    property alias data: data.text
    property alias label: label.text

    background: Rectangle {
        color: Comp.Globals.color.primary.shade3
        radius: Material.SmallScale
    }

    RowLayout {
        width: parent.width

        IconLabel {
            id: icon
            icon.width: 30
            icon.height: 30
            icon.color: Comp.Globals.color.accent.shade1
        }

        ColumnLayout {
            spacing: 0

            Text {
                id: data
                Layout.fillWidth: true
                font.pixelSize: Comp.Globals.fontSize.large
                font.weight: Font.Bold
                color: "white"
                horizontalAlignment: Text.AlignRight
            }

            Text {
                id: label
                Layout.fillWidth: true
                font.pixelSize: Comp.Globals.fontSize.small
                font.weight: Font.DemiBold
                color: Comp.Globals.color.secondary.shade2
                horizontalAlignment: Text.AlignRight
            }
        }
    }
}
