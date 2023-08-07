import QtQuick

import "./views/create_goal"

Item {
    property alias createGoalView: createGoalView

    CreateGoalView {
        id: createGoalView
        anchors.centerIn: parent
    }
}
