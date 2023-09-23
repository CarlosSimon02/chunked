import QtQuick
import QtQuick.Controls.Windows

import components as Comp

Comp.PageView {
    Comp.Button {
        text: "Sample Menu"
        onClicked: menu.open()

        Comp.Menu {
            id: menu

            Comp.Menu {
                id: subMenu
                title: "what the fuck"
                MenuItem {
                    text: "New..."
                    checkable: true
                }
                MenuItem {
                    text: "Open..."
                }
                MenuItem {
                    text: "Save"
                }
            }

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
