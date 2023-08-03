import QtQuick

import "./create_goal"
import "./goal_info"

Item {
    property alias createGoalView: createGoalView
    property alias goalInfoView: goalInfoView

    CreateGoalView {
        id: createGoalView
        width: parent.width
        height: parent.height
    }

    GoalInfoView {
        id: goalInfoView
        width: parent.width
        height: parent.height
    }
}
