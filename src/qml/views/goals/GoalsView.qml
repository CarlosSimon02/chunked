import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
    Material.background: "#121212"

    header: Pane {
        height: 60
        horizontalPadding: 20

        Material.background: Material.color(Material.Grey, Material.Shade900)
        Material.elevation: 6

        RowLayout {
            anchors.fill: parent

            Text {
                text: "Goals"
                color: "white"
                font.pixelSize: 22
                font.weight: Font.DemiBold
            }
        }
    }
}

