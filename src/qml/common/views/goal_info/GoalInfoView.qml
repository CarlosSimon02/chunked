import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp
import components.buttons as Btn
import views.goals_body
import views.habits_body
import views.tasks_body
import "./views"

Comp.PageView {
    id: pageView
    title: "Goal Info"
    isInitItem: false

    property int itemId
    property Goal goal: dbAccess.getGoalItem(itemId)
    property bool itemsHasImage: true

    Material.accent: Comp.Globals.color.accent.shade1

    StackView.onActivating: {
        //refresh
        goal = dbAccess.getGoalItem(itemId)
    }

    headerOptions: Component {
        RowLayout {
            Btn.PageHeaderButton {
                icon.source: "qrc:/three_dots_icon.svg"
                rotation: 90
                onClicked: menu.open()

                Menu {
                    id: menu
                    Material.background: Material.color(Material.Grey, Material.Shade900)
                    Material.accent: Material.color(Material.Lime, Material.Shade900)
                    Material.elevation: 15

                    //This option is usually use for subgoals where image is not required
                    MenuItem {
                        id: showImage
                        text: qsTr("Show Image")
                        checkable: true
                        checked: true
                        onTriggered: {
                            pageView.itemsHasImage = checked
                        }
                    }

                    MenuItem {
                        text: qsTr("Edit")
                        onTriggered: {
                            stackPageView.push("qrc:/common/views/goals_body/views/create_edit_goal/CreateEditGoalView.qml",
                                               {"goal.itemId" : pageView.itemId})
                        }
                    }

                    MenuItem {
                        text: qsTr("Delete")
                        Material.foreground: "red"
                        onTriggered: {
                            dbAccess.removeGoalItem(pageView.itemId)
                            stackPageView.pop()
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        layer.enabled: true
        layer.samples: 4

        DetailsView {
            Layout.preferredWidth: 350
            Layout.fillHeight: true

            imageSource: pageView.goal.imageSource
            goalName: pageView.goal.name
            startDateTime: pageView.goal.startDateTime
            endDateTime: pageView.goal.endDateTime
            category: pageView.goal.category
            trackerType: pageView.goal.progressTracker
            progressValue: pageView.goal.progressValue
            targetValue: pageView.goal.targetValue
            unit: pageView.goal.progressUnit
            parentGoalId: pageView.goal.parentGoalId
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Comp.NavBar {
                id: listView
                Layout.fillWidth: true
                Layout.preferredHeight: contentItem.childrenRect.height

                delegate: Comp.NavBarDelegate {
                    text: model.data

                    onClicked: {
                        ListView.view.currentIndex = model.index

                        if(listView.currentItem.text === "Subgoals") loader.sourceComponent = goalsBodyViewComp
                        else if(listView.currentItem.text === "Habits") loader.sourceComponent = habitsBodyViewComp
                        else if(listView.currentItem.text === "Tasks") loader.sourceComponent = tasksBodyViewComp
                        else if(listView.currentItem.text === "Description") loader.sourceComponent = descriptionViewComp
                    }
                }

                model: ListModel {
                    Component.onCompleted: {
                        switch(pageView.goal.progressTracker) {
                        case 0: case 1:
                                    append({"data":"Subgoals"});
                                    loader.sourceComponent = goalsBodyViewComp
                                    break;
                        case 2: case 3:
                                    append({"data":"Tasks"});
                                    loader.sourceComponent = tasksBodyViewComp
                                    break;
                        case 4: case 5:
                                    append({"data":"Habits"});
                                    loader.sourceComponent = habitsBodyViewComp
                                    break;
                        case 6:
                            loader.sourceComponent = descriptionViewComp
                            break;
                        }
                        append({"data":"Description"})
                    }
                }
            }

            Loader {
                id: loader
                Layout.fillWidth: true
                Layout.fillHeight: true

                Component {
                    id: goalsBodyViewComp

                    GoalsBodyView {
                        id: goalsBodyView
                        parentGoalId: pageView.itemId
                        itemsHasImage: pageView.itemsHasImage
                        verticalScrollBar: ScrollBar {
                            parent: loader
                            x: loader.width - width
                            height: loader.height
                        }

                        Connections {
                            target: pageView.StackView
                            function onActivating() {
                                goalsBodyView.model.refresh()
                            }
                        }
                    }
                }

                Component {
                    id: habitsBodyViewComp

                    HabitsBodyView {
                        itemsHasImage: pageView.itemsHasImage
                        isSubHabit: true
                        verticalScrollBar: ScrollBar {
                            parent: loader
                            x: loader.width - width
                            height: loader.height
                        }
                    }
                }

                Component {
                    id: tasksBodyViewComp

                    TasksBodyView {
                        parentGoalId: pageView.itemId
                        trackerType: pageView.goal.progressTracker

                        onDataChanged: {
                            pageView.goal = dbAccess.getGoalItem(pageView.itemId)
                        }
                    }
                }

                Component {
                    id: descriptionViewComp

                    DescriptionView {
                        mission: pageView.goal.mission
                        vision: pageView.goal.vision
                        obstacles: pageView.goal.obstacles
                        resources: pageView.goal.resources
                    }
                }
            }
        }
    }
}
