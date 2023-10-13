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
            property color shade4: "#393939"
        }

        property QtObject secondary: QtObject {
            property color shade1: Material.color(Material.Grey, Material.Shade700)
            property color shade2: Material.color(Material.Grey, Material.Shade500)
            property color shade3: "#D6D6D6"
            property color shade4: "white"
        }

        property QtObject accent: QtObject {
            property color shade1: Material.color(Material.Lime, Material.Shade900)
            property color shade2: Material.color(Material.Lime, Material.Shade100)
        }
    }

    property QtObject screen: QtObject {
        property int smallW: 700
    }

    property QtObject fontSize: QtObject {
        property int superSmall: 10
        property int extraSmall: 12
        property int small: 14
        property int medium: 16
        property int large: 20
        property int extraLarge: 22
    }

    property string dateTimeFormat: "dd MMM yyyy hh:mm AP"

    property var statusTypes: [
        "Pending",
        "Active",
        "Done",
        "Overdue"
    ]

    property var statusColors: [
        "darkgoldenrod",
        "green",
        "darkblue",
        "red"
    ]

    property var categoryTypes: [
        "Work",
        "Personal",
        "Home"
    ]

    property var trackerTypes: [
        "Subgoals(Total Progress)",
        "Subgoals(Completed)",
        "Tasks(Total Outcome)",
        "Tasks(Completed)",
        "Habits(Total Progress)",
        "Habits(Completed)",
        "Manual Update"
    ]
}
