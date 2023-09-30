import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./views"

Comp.PageView {
    title: "Goal Info"
    isInitItem: false

    Material.accent: Comp.Globals.color.accent.shade1

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
                Layout.preferredHeight: 100
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
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
