import QtQuick
import QtQuick.Controls.Material as Ctrl
import QtQuick.Layouts

import components as Comp

Ctrl.Page {
    id: page
    padding: 10
    background: Rectangle {
//        radius: Ctrl.Material.SmallScale
//        color: Comp.Globals.color.primary.shade1
        color: "transparent"
        border.width: 2
        border.color: Comp.Globals.color.primary.shade3
        radius: Ctrl.Material.SmallScale
    }

    header: Ctrl.Frame {
        horizontalPadding: 10
        bottomPadding: 10
        background: Item {
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                width: parent.width
                height: 2
                color: Comp.Globals.color.primary.shade3
            }
        }

        RowLayout {
            Text {
                text: page.title
                color: Comp.Globals.color.secondary.shade2
                font.pixelSize: Comp.Globals.fontSize.medium
            }
        }
    }
}
