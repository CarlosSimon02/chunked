import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    property alias mission: mission.text
    property alias vision: vision.text
    property alias obstacles: obstacles.text
    property alias resources: resources.text

    ColumnLayout {
        Text {
            id: mission
        }

        Text {
            id: vision
        }

        Text {
            id: obstacles
        }

        Text {
            id: resources
        }
    }
}
