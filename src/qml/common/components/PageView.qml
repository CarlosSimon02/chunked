import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Page {
    id: page
    Material.background: "#121212"
    property bool isInitItem: true

    //For adding options in page view header
    //Always use RowLayout and Comp.IconButton
    property Component headerOptions

    header: Pane {
        height: 60
        padding: 0
        horizontalPadding: 15

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
                    visible: !sideMenuView.visible && page.isInitItem

                    onClicked: sideMenuDrawerView.open()

                    Connections {
                        target: sideMenuDrawerView
                        function onAboutToHide() {menuButton.opened = false}
                    }
                }

                Comp.IconButton {
                    visible: !page.isInitItem
                    icon.source: "qrc:/arrow_left_icon.svg"
                    onClicked: page.StackView.view.pop()
                }

                Text {
                    id: title
                    text: page.title
                    color: "white"
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: Number.POSITIVE_INFINITY

                Loader {
                    Layout.alignment: Qt.AlignRight
                    sourceComponent: page.headerOptions
                }
            }
        }
    }
}
