import QtQuick
import QtQuick.Controls.Material

Drawer {
    id: drawer
    width: 170
    interactive: false
    Overlay.modal: null
    modal: false
    Material.background: "black"
    Material.roundedScale: Material.NotRounded

    Connections {
        target: window
        function onWidthChanged() {
            if(drawer.opened && sideMenu.visible) {
                drawer.close()
                backdrop.close()
            }
        }
    }

    Connections {
        target: backdrop
        function onTapped() {
            drawer.close()
        }
    }

    Loader {

    }

    onAboutToShow: backdrop.open()
}
