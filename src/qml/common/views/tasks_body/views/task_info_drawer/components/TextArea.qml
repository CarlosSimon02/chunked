import QtQuick
import QtQuick.Controls.Material as Ctrl

import components as Comp

Ctrl.TextArea {
    id: control
    topPadding: 0
    leftPadding: 0
    rightPadding: 0
    color: Comp.Globals.color.secondary.shade3
    font.pixelSize: Comp.Globals.fontSize.medium
    wrapMode: Ctrl.TextArea.Wrap

    background: Item {
        Rectangle {
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            visible: control.focus
            color: Comp.Globals.color.accent.shade1
        }
    }
}
