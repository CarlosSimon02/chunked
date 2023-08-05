import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./views/goals"
import "./views/settings"

StackLayout {
    signal goalAdded
    onGoalAdded: goalsView.goalAdded()

    GoalsView {
        id: goalsView
    }

    SettingsView {
        id: settingsView
    }
}
