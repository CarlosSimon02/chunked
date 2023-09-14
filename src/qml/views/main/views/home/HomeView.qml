import QtQuick
import QtQuick.Controls

import components as Comp

Comp.Page {
    Comp.Button {
        text: "Sample Menu"
        onClicked: menu.open()

        Comp.Menu {
            id: menu

            Comp.MenuItem {
                text: "New..."
                onTriggered: document.reset()
            }
            Comp.MenuItem {
                text: "Open..."
                onTriggered: openDialog.open()
            }
            Comp.MenuItem {
                text: "Save"
                onTriggered: saveDialog.open()
            }
        }
    }
}
