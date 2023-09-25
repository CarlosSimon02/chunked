import QtQuick
import QtQuick.Controls.Material

import "./components" as MComp
import components as Comp

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
                spacing: 50

                Component.onCompleted: menuListView.currentIndex = sideMenuView.currentIndex

                Comp.IconButton {
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    icon.source: "qrc:/double_arrow_left_icon.svg"
                    onClicked: {
                        drawer.close()
                        backdrop.close()
                    }
                }

                MComp.MenuListView {
                    id: menuListView
                    width: 170

                    delegate: MComp.ItemDelegate {
                        width: menuListView.width
                        property url viewSource: model.viewSource

                        highlighted: ListView.isCurrentItem
                        text: label
                        icon.source: iconSource
                        onClicked: {
                            menuListView.currentIndex = model.index
                            sideMenuView.currentIndex = model.index
                            drawer.close()
                            backdrop.close()
                        }
                    }
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
