pragma Singleton
import QtQuick

QtObject {
    readonly property int commonRadius: 15

    readonly property var goalProgressTrackers: [
        "Total number of completed tasks",
        "Total outcome from all tasks",
        "Total progress from all subgoals",
        "Total number of completed subgoals",
        "Manually updating current progress"
    ]
}
