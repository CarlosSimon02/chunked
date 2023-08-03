import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./goals"
import "./settings"

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
