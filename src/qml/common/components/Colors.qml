pragma Singleton

import QtQuick
import QtQuick.Controls.Material

//In Dark Theme shade1 is the darkest and in Light Theme, it is the lightest
QtObject {
    property QtObject primary: QtObject {
        property color shade1: "black"
        property color shade2: "#121212"
        property color shade3: Material.color(Material.Grey, Material.Shade900)
    }

    property QtObject secondary: QtObject {
        property color shade1: Material.color(Material.Grey, Material.Shade500)
        property color shade3: "white"
    }

    property QtObject accent: QtObject {
        property color shade1: Material.color(Material.Grey, Material.Shade900)
        property color shade2: "#00AB9B"
    }
}
