import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import views.goals_body
import views.habits_body
import views.tasks_body
import "./views"

Comp.PageView {
    id: pageView
    title: "Goal Info"
    isInitItem: false

    property bool itemsHasImage: true

    Material.accent: Comp.Globals.color.accent.shade1

    headerOptions: Component {
        RowLayout {
            Comp.IconButton {
                icon.source: "qrc:/three_dots_icon.svg"
                rotation: 90
                onClicked: menu.open()

                Menu {
                    id: menu
                    Material.background: Material.color(Material.Grey, Material.Shade900)
                    Material.accent: Material.color(Material.Lime, Material.Shade900)
                    Material.elevation: 15

                    MenuItem {
                        text: qsTr("Edit")
                        onTriggered: {
                            stackPageView.push("qrc:/common/views/goals_body/views/create_edit_goal_view/EditGoalView.qml")
                        }
                    }

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
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.preferredHeight: contentItem.childrenRect.height
                orientation: ListView.Horizontal
                currentIndex: 0
                spacing: 10
                clip: true
                highlightFollowsCurrentItem: false
                highlight: Rectangle {
                    height: 2
                    width: listView.currentItem.width
                    color: Comp.Globals.color.accent.shade1
                    x: listView.currentItem.x
                    y: listView.currentItem.y + listView.currentItem.height - height

                    Behavior on width { SmoothedAnimation { velocity: 100 } }
                    Behavior on x { SmoothedAnimation { velocity: 400 } }
                }

                delegate: RoundButton {
                    padding: 10
                    bottomPadding: 20
                    topInset: 0
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 10

                    text: model.data
                    font.weight: Font.Normal
                    highlighted: ListView.isCurrentItem
                    flat: true
                    radius: Material.SmallScale
                    font.capitalization: Font.MixedCase

//                    onClicked: {
//                        ListView.view.currentIndex = model.index

//                        if(listView.currentItem.text === "Subgoals") loader.sourceComponent = subgoalsViewComp;
//                        else if(listView.currentItem.text === "Habits") loader.sourceComponent = habitsViewComp;
//                        else if(listView.currentItem.text === "Tasks") loader.sourceComponent = tasksViewComp;
//                        else if(listView.currentItem.text === "Description") loader.sourceComponent = descriptionViewComp
//                        else if(listView.currentItem.text === "Journal") loader.sourceComponent = journalViewComp
//                    }
                }

                model: ListModel {
                    Component.onCompleted: {
//                        switch(page.goal.progressTracker) {
//                        case 0: case 1:
//                                    append({"data":"Subgoals"});
//                                    loader.sourceComponent = subgoalsViewComp
//                                    break;
//                        case 2: case 3:
//                                    append({"data":"Tasks"});
//                                    loader.sourceComponent = tasksViewComp
//                                    break;
//                        case 4: case 5:
//                                    append({"data":"Habits"});
//                                    loader.sourceComponent = habitsViewComp
//                                    break;
//                        case 6:
//                            loader.sourceComponent = descriptionViewComp
//                            break;
//                        }
                        append({"data":"Subgoals"})
                        append({"data":"Description"})
                        append({"data":"Journal"})
                    }
                }
            }

            Loader {
                id: loader
                Layout.fillWidth: true
                Layout.fillHeight: true

                sourceComponent: habitsBodyView

                Component {
                    id: goalsBodyView

                    GoalsBodyView {
                        itemsHasImage: pageView.itemsHasImage
                        isSubGoal: true
                        verticalScrollBar: ScrollBar {
                            parent: loader
                            x: loader.width - width
                            height: loader.height
                        }
                    }
                }

                Component {
                    id: habitsBodyView

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
                    id: tasksBodyView

                    TasksBodyView {
                        isSubGoal: true
                    }
                }
            }
        }
    }
}
