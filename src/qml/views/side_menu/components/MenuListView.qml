import QtQuick

ListView {
    id: listView
    implicitWidth: 50
    implicitHeight: contentItem.childrenRect.height
    clip: true
    spacing: 10

    delegate: ItemDelegate {
        width: listView.width
        property url viewSource: model.viewSource

        highlighted: ListView.isCurrentItem
        text: label
        icon.source: iconSource
        onClicked: listView.currentIndex = model.index
    }

    model: ListModel {
        ListElement {
            label: "Home"
            iconSource: "qrc:/home_icon.svg"
            viewSource: "qrc:/views/home/HomeView.qml"
        }

        ListElement {
            label: "Goals"
            iconSource: "qrc:/goals_icon.svg"
            viewSource: "qrc:/views/goals/GoalsView.qml"
        }

        ListElement {
            label: "Tasks"
            iconSource: "qrc:/tasks_icon.svg"
            viewSource: "qrc:/views/tasks/TasksView.qml"
        }

        ListElement {
            label: "Habits"
            iconSource: "qrc:/habits_icon.svg"
            viewSource: "qrc:/views/habits/HabitsView.qml"
        }

        ListElement {
            label: "Reports"
            iconSource: "qrc:/reports_icon.svg"
            viewSource: "qrc:/views/reports/ReportsView.qml"
        }

        ListElement {
            label: "Settings"
            iconSource: "qrc:/settings_icon.svg"
            viewSource: "qrc:/views/settings/SettingsView.qml"
        }
    }
}
