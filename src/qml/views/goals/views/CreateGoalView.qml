import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./components" as MComp

Comp.PageView {
    isInitItem: false
    title: "Create Goal"

    ScrollView {
        id: scrollView
        anchors.fill: parent
        Material.accent: Material.Lime

        Pane {
            implicitWidth: scrollView.width
            padding: 30

            ColumnLayout {
                width: parent.width
                spacing: 30

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Goal Name"
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    TextField {
                        Layout.maximumWidth: 600
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Category"
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    ComboBox {
                        Layout.maximumWidth: 600
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout {
                    spacing: 12

                    Text {
                        text: "Image"
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                        color: Material.color(Material.Grey, Material.Shade600)
                    }

                    MComp.ImagePicker {
                        Layout.maximumWidth: 600
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
