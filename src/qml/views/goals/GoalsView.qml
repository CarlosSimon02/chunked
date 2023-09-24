import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Page {
    Material.background: "#121212"

    header: Pane {
        height: 60
        padding: 0
        horizontalPadding: 10

        Material.background: Material.color(Material.Grey, Material.Shade900)
        Material.elevation: 6

        RowLayout {
            anchors.fill: parent

            RowLayout {
                spacing: 5

                Comp.MenuButton {
                    id: menuButton
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    visible: !sideMenu.visible

                    onClicked: sideMenuDrawerView.open()

                    Connections {
                        target: sideMenuDrawerView
                        function onAboutToHide() {menuButton.opened = false}
                    }
                }

                Text {
                    text: "Goals"
                    color: "white"
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                }
            }
        }
    }
}

