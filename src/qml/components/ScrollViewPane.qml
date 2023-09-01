import QtQuick

import components as Comp

Comp.Pane {
    implicitWidth: parent.width
    height: Math.max(implicitHeight,parent.parent.height)
    padding: 0
}
