pragma Singleton
import QtQuick

QtObject {
    readonly property int commonRadius: 15

    readonly property var goalProgressTrackers: [
        "Subgoals(Total Progress)",
        "Subgoals(Completed)",
        "Tasks(Total Outcome)",
        "Tasks(Completed)",
        "Habits(Total Progress)",
        "Habits(Completed)",
        "Manual Update"
    ]

    readonly property var statusTypes: [
        "Pending",
        "Active",
        "Done",
        "Unfinished"
    ]
}
