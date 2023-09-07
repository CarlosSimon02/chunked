import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import commonViews as View
import popups as Pop
import "./views"

Comp.Page {
    id: page
    padding: 20
    topPadding: 0

    required property Goal goal

    StackView.onActivating: {
        if(goal.progressTracker !== 6)
            page.goal = dbAccess.getGoalItem(page.goal.itemId)
    }

    Connections {
        target: createEditGoalPopup
        function onSave() {page.goal = dbAccess.getGoalItem(page.goal.itemId)}
    }

    header: Comp.PageHeader {
        background: null
        height: 80

        RowLayout {
            width: parent.width

            RowLayout {
                Comp.Button {
                    icon.source: "qrc:/back_icon.svg"
                    onClicked: stackView.pop()
                }

                Comp.Text {
                   text: "Goal Info"
                   font.weight: Font.Bold
                   font.pixelSize: 28
                }
            }

            Comp.Button {
                Layout.alignment: Qt.AlignRight
                icon.source: "qrc:/edit_icon.svg"
                onClicked: {
                    createEditGoalPopup.itemId = goal.itemId
                    createEditGoalPopup.open()
                }

                Pop.CreateEditGoalPopup {
                    id: createEditGoalPopup
                }
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 20

        DetailsView {
            Layout.preferredWidth: 400
            Layout.fillHeight: true
            goal: page.goal
        }

        Page {
            Layout.fillWidth: true
            Layout.fillHeight: true
            background: null
            topPadding: -pageHeader.bottomPadding

            header: Comp.PageHeader {
                id: pageHeader
                height: 80

                RowLayout {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    width: parent.width

                    Comp.ListView {
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
                            color: Comp.ColorScheme.accentColor.regular
                            x: listView.currentItem.x
                            y: listView.currentItem.y + listView.currentItem.height - height

                            Behavior on width { SmoothedAnimation { velocity: 100 } }
                            Behavior on x { SmoothedAnimation { velocity: 400 } }
                        }

                        delegate: Comp.ItemDelegate {
                            padding: 10
                            bottomPadding: 20

                            text: model.data
                            font.weight: Font.Normal
                            bottomInset: 10
                            highlighted: ListView.isCurrentItem
                            backgroundColor: "transparent"

                            onClicked: {
                                ListView.view.currentIndex = model.index

                                if(listView.currentItem.text === "Subgoals") loader.sourceComponent = subgoalsViewComp;
                                else if(listView.currentItem.text === "Habits") loader.sourceComponent = habitsViewComp;
                                else if(listView.currentItem.text === "Tasks") loader.sourceComponent = tasksViewComp;
                                else if(listView.currentItem.text === "Description") loader.sourceComponent = descriptionViewComp
                                else if(listView.currentItem.text === "Journal") loader.sourceComponent = journalViewComp
                            }
                        }

                        model: ListModel {
                            Component.onCompleted: {
                                switch(page.goal.progressTracker) {
                                case 0: case 1:
                                            append({"data":"Subgoals"});
                                            loader.sourceComponent = subgoalsViewComp
                                            break;
                                case 2: case 3:
                                            append({"data":"Tasks"});
                                            loader.sourceComponent = tasksViewComp
                                            break;
                                case 4: case 5:
                                            append({"data":"Habits"});
                                            loader.sourceComponent = habitsViewComp
                                            break;
                                case 6:
                                    loader.sourceComponent = descriptionViewComp
                                    break;
                                }

                                append({"data":"Description"})
                                append({"data":"Journal"})
                            }
                        }
                    }
                }
            }

            Loader {
                id: loader
                anchors.fill: parent
                clip: true

                Component {id: descriptionViewComp; DescriptionView {goal: page.goal}}
                Component {
                    id: subgoalsViewComp

                    View.GoalsBodyView {
                        id: subgoalsView
                        parentGoalId: page.goal.itemId

                        Connections {
                            target: page.StackView
                            function onActivating() {refresh()}
                        }

                        Connections {
                            target: subgoalsView
                            function onRefresh() {page.goal = dbAccess.getGoalItem(page.goal.itemId)}
                        }
                    }
                }
                Component {
                    id: tasksViewComp

                    View.TasksBodyView {
                        id: taskView
                        parentGoalId: page.goal.itemId
                    }
                }
                Component {id: habitsViewComp; HabitsView {goal: page.goal}}
                Component {id: journalViewComp; JournalView {goal: page.goal}}
            }
        }
    }
}
