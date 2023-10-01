import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import views.goals_body

Comp.StackPageView {
    id: stackPageView

    initialItem: Comp.PageView {
        id: goalsPageView
        title: "Goals"

        headerOptions: Component {
            RowLayout {
                Comp.IconButton {
                    icon.source: "qrc:/three_dots_icon.svg"
                    rotation: 90
                    onClicked: menu.open()

                    Menu {
                        id: menu
                        Material.background: Material.color(Material.Grey, Material.Shade900)
                        Material.elevation: 15

                        //This option is usually use for subgoals where image is not required
                        MenuItem {
                            id: showImage
                            text: qsTr("Show Image")
                            checkable: true
                            checked: true
                            onTriggered: {
                                    goalsBodyView.itemsHasImage = checked
                            }

                            Material.accent: Material.color(Material.Lime, Material.Shade900)
                        }
                    }
                }
            }
        }

        GoalsBodyView {
            id: goalsBodyView
            anchors.fill: parent

            verticalScrollBar: ScrollBar {
                parent: goalsPageView
                x: goalsPageView.width - width
                y: goalsPageView.header.height
                height: goalsPageView.availableHeight - goalsPageView.header.height
            }
        }
    }
}



