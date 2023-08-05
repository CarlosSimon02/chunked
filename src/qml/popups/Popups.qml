import QtQuick

import "./views/create_goal"
import "./views/goal_info"

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
