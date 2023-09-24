import QtQuick
import QtQuick.Controls.Material

import "./components" as MComp

Drawer {
    id: drawer
    implicitWidth: 190
    interactive: false
    leftPadding: 10
    rightPadding: 10
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
        anchors.fill: parent
        sourceComponent: drawer.opened ? content : null

        Component {
            id: content

            Column {
                spacing: 50

                Button {
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    flat: true
                    icon.source: "qrc:/double_arrow_left_icon.svg"
                    onClicked: {
                        drawer.close()
                        backdrop.close()
                    }
                }

                MComp.MenuListView {
                    id: menuListView
                    width: 170
                }
            }
        }
    }

    onAboutToShow: backdrop.open()
}
