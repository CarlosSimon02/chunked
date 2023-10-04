import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Drawer {
    id: drawer
    z: 0
    implicitWidth: 370
    interactive: false
    leftPadding: 10
    rightPadding: 10
    Overlay.modal: null
    modal: false
    edge: Qt.RightEdge
    Material.background: Comp.Globals.color.primary.shade1
    Material.roundedScale: Material.NotRounded
    Material.accent: Comp.Globals.color.accent.shade1

    //To prevent drawer from closing when clicked
    MouseArea {
        anchors.fill: parent
        onClicked: drawer.focus = true
    }

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

                ColumnLayout {
                    width: parent.width

                    RowLayout {
                        CheckBox {
                            Layout.alignment: Qt.AlignTop
                        }

                        TextInput {
                            Layout.fillWidth: true
                            Layout.topMargin: 10
                            color: "white"
                            text: "This is just a sample task, it is suppossed to be very very long"
                            font.pixelSize: Comp.Globals.fontSize.large
                            wrapMode: TextInput.Wrap
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
