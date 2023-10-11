import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

//use of displaying data in infoViews
RowLayout {
    id: rowLayout
    property alias iconSource: iconLabel.icon.source
    property string label: iconLabel.ToolTip.text
    property alias value: value.text
    property alias color: value.color

    spacing: 20

    IconLabel {
        id: iconLabel
        Layout.alignment: Qt.AlignTop
        display: IconLabel.IconOnly
        icon.source: iconSource
        icon.width: 18
        icon.height: 18
        icon.color: Comp.Globals.color.secondary.shade2

        HoverHandler {
            id: hover
        }

        ToolTip.visible: hover.hovered
        ToolTip.text: rowLayout.label
    }

    Text {
        id: value
        Layout.fillWidth: true
        Layout.preferredWidth: implicitWidth
        text: model.value
        font.pixelSize: Comp.Globals.fontSize.medium
        color: model.color
        wrapMode: Text.Wrap
    }
}
