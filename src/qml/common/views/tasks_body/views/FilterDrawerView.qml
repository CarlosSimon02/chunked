import QtQuick
import QtQuick.Controls.Material

import components as Comp

Drawer {
    id: drawer
    implicitWidth: 370
    interactive: false
    leftPadding: 10
    rightPadding: 10
    Overlay.modal: null
    modal: false
    edge: Qt.RightEdge
    Material.background: Comp.Globals.color.primary.shade1
    Material.roundedScale: Material.NotRounded
    Material.accent: Comp.Globals.accent.shade1

    Connections {
        target: window
        function onWidthChanged() {
            if(drawer.opened && sideMenuView.visible) {
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
        id: loader
        anchors.fill: parent

        Component {
            id: content

            Column {
                spacing: 20

                Comp.IconButton {
                    id: closeButton
                    rotation: 180
                    icon.source: "qrc:/double_arrow_left_icon.svg"
                    onClicked: {
                        drawer.close()
                        backdrop.close()
                    }
                }

                FilterView {
                    width: parent.width
                }
            }
        }
    }

    onAboutToShow: {
        backdrop.open()
        loader.sourceComponent = content
    }

    onClosed: loader.sourceComponent = null
}

