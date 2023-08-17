import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import "./views"

Comp.Page {
    id: page
    padding: 20
    topPadding: 0

    required property Goal goal

    header: Comp.PageHeader {
        background: null
        height: 80

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
                            color: Comp.ColorScheme.accentColor.regular
                            x: listView.currentItem.x
                            y: listView.currentItem.y + listView.currentItem.height - height

                            Behavior on width { SmoothedAnimation { velocity: 100 } }
                            Behavior on x { SmoothedAnimation { velocity: 400 } }
                        }

                        delegate: Comp.ItemDelegate {
                            padding: 10
                            bottomPadding: 20

                            required property string modelData
                            required property int index

                            text: modelData
                            font.weight: Font.Normal
                            bottomInset: 10
                            highlighted: ListView.isCurrentItem
                            backgroundColor: "transparent"

                            onClicked: ListView.view.currentIndex = index
                        }

                        model: ["Description","Subgoals","Tasks","Habits","Journal"]
                    }
                }
            }

            Loader {
                id: loader
                anchors.fill: parent
                clip: true
                sourceComponent: switch(listView.currentIndex) {
                                 case 0: return descriptionView;
                                 case 1: return subgoalsView;
                                 case 2: return tasksView;
                                 case 3: return habitsView;
                                 case 4: return journalView;
                                 }

                Component {id: descriptionView; DescriptionView {goal: page.goal}}
                Component {id: subgoalsView; SubgoalsView {goal: page.goal}}
                Component {id: tasksView; TasksView {goal: page.goal}}
                Component {id: habitsView; HabitsView {goal: page.goal}}
                Component {id: journalView; JournalView {goal: page.goal}}
            }
        }
    }
}
