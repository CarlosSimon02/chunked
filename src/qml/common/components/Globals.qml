pragma Singleton

import QtQuick
import QtQuick.Controls.Material

QtObject {

    //In Dark Theme shade1 is the darkest and in Light Theme, it is the lightest
    property QtObject color: QtObject {
        property QtObject primary: QtObject {
            property color shade1: "black"
            property color shade2: "#121212"
            property color shade3: Material.color(Material.Grey, Material.Shade900)
        }

        property QtObject secondary: QtObject {
            property color shade1: Material.color(Material.Grey, Material.Shade700)
            property color shade2: Material.color(Material.Grey, Material.Shade500)
            property color shade3: "white"
        }

        property QtObject accent: QtObject {
            property color shade1: Material.color(Material.Lime, Material.Shade900)
            property color shade2: Material.color(Material.Lime, Material.Shade400)
        }
    }

    property QtObject screen: QtObject {
        property int smallW: 700
    }

    property QtObject fontSize: QtObject {
        property int small: 14
        property int medium: 16
        property int large: 20
        property int extraLarge: 22
    }
}
