pragma Singleton
import QtQuick

QtObject {
    property QtObject primaryColor: QtObject {
        property color veryLight: "#222227"
        property color light: "#18181B"
        property color regular: "#0E0E10"
        property color shadow: "#0A0A0B"
        property color dark: "#050506"
    }

    property QtObject secondaryColor: QtObject {
        property color veryDark: "#737373"
        property color dark: "#A3A3A3"
        property color regular: "#FFFFFF"
    }

    property QtObject accentColor: QtObject {
        property color dark: "#005951"
        property color regular: "#00AB9B"
    }
}
