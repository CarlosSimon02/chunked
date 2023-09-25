import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

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
            topMargin: 10
            bottomMargin: 10
            contentWidth: Math.floor((stackPageView.width - 20) / cellWidth) * cellWidth
            clip: true
            cellWidth: 350
            cellHeight: 400

            ScrollBar.vertical: ScrollBar {
                parent: goalsPageView
                x: gridView.mirrored ? 0 : goalsPageView.width - width
                y: goalsPageView.header.height
                height: goalsPageView.availableHeight - goalsPageView.header.height
            }

            delegate: Item {
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                Page {
                    anchors.fill: parent
                    anchors.margins: parent.GridView.view.topMargin
                    padding: 0
                    horizontalPadding: 0
                    verticalPadding: 0
                    topInset: 0
                    bottomInset: 0
                    rightInset: 0
                    leftInset: 0

                    Material.background: Material.color(Material.Grey, Material.Shade900)
                    Material.elevation: 0
                    Material.roundedScale: Material.SmallScale

                    ColumnLayout {
                        anchors.fill: parent

                        Image {
                            Layout.fillWidth: true
                            Layout.preferredHeight: width * 9 / 16
                            source: "file:/Users/Carlos Simon/Downloads/dg0xaud-b2b199e4-e4fa-4f4c-a017-71e709e95926.png"
                        }
                    }

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



