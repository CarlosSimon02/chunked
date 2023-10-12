import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn

Page {
    id: page
    Material.background: Comp.Globals.color.primary.shade2
    property bool isInitItem: true

    //For adding options in page view header
    //Always use RowLayout and Comp.PageHeaderButton
    property Component headerOptions

    header: Pane {
        height: 60
        padding: 0
        horizontalPadding: 15
        focusPolicy: Qt.ClickFocus

        Material.background: Comp.Globals.color.primary.shade3
        Material.elevation: 6

        RowLayout {
            anchors.fill: parent

            RowLayout {
                spacing: 5

                 Btn.MenuButton {
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

                Btn.PageHeaderButton {
                    visible: !page.isInitItem
                    icon.source: "qrc:/arrow_left_icon.svg"
                    onClicked: page.StackView.view.pop()
                }

                Text {
                    id: title
                    text: page.title
                    color: Comp.Globals.color.secondary.shade4
                    font.pixelSize: Comp.Globals.fontSize.extraLarge
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
