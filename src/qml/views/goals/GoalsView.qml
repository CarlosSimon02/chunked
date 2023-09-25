import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "./components" as MComp
import components as Comp

Comp.StackPageView {
    id: stackPageView

    initialItem: Comp.PageView {
        id: goalsPageView
        title: "Goals"

        GridView {
            id: gridView
            width: contentWidth
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            topMargin: 15
            bottomMargin: 15
            contentWidth: Math.floor((stackPageView.width - 30) / cellWidth) * cellWidth
            clip: true
            cellWidth: 350
            cellHeight: 450

            ScrollBar.vertical: ScrollBar {
                parent: goalsPageView
                x: gridView.mirrored ? 0 : goalsPageView.width - width
                y: goalsPageView.header.height
                height: goalsPageView.availableHeight - goalsPageView.header.height
            }

            delegate: Item {
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                MComp.GoalItemDelegate {
                    anchors.fill: parent
                    anchors.margins: parent.GridView.view.topMargin

                    Material.background: Material.color(Material.Grey, Material.Shade900)
                    Material.elevation: 0
                    Material.roundedScale: Material.SmallScale
                }
            }

            model: 10
        }

        Button {
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            icon.source: "qrc:/create_icon.svg"
            text: "New Goal"

            Material.background: Material.color(Material.Lime, Material.Shade900)
            Material.elevation: 10
            Material.roundedScale: Material.SmallScale
        }
    }
}



