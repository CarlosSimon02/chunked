import QtQuick as Q
import QtQuick.Controls


import components as Comp

Q.ListView {
    id: listView
    interactive: true
    clip: true

    Q.TapHandler {
        onTapped: listView.forceActiveFocus()
    }

    ScrollBar.vertical: Comp.ScrollBar {
        parent: listView
        x: listView.mirrored ? 0 : listView.width - width
        height: listView.availableHeight
        active: listView.ScrollBar.horizontal.active
    }

    ScrollBar.horizontal: Comp.ScrollBar {
        parent: listView
        y: listView.height - height
        width: listView.availableWidth
        active: listView.ScrollBar.vertical.active
    }
}
