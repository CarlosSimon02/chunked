import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn
import views.goals_body

Comp.StackPageView {
    id: stackPageView

    initialItem: Comp.PageView {
        id: initPageView
        title: "Goals"

        headerOptions: Component {
            RowLayout {
                Btn.PageHeaderButton {
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
                parent: initPageView
                x: initPageView.width - width
                y: initPageView.header.height
                height: initPageView.availableHeight - initPageView.header.height
            }
        }
    }
}



