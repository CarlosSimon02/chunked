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
                checkable: true
            }
            Comp.MenuItem {
                text: "Open..."
            }
            Comp.MenuItem {
                text: "Save"
            }
        }
    }
}
