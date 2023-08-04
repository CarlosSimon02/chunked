import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import body.components as Body
import "./active_goals"

Comp.Page {
    signal goalAdded
    topPadding: -pageHeader.bottomPadding
    onGoalAdded: activeGoalsView.model.refresh()

    header: Body.PageHeader {
        id: pageHeader

        Comp.Text {
            text: "Goals"
            font.weight: Font.Bold
            font.pixelSize: 28
        }

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
                    text: model.text
                    font.weight: Font.Normal
                    bottomInset: 10
                    highlighted: ListView.isCurrentItem
                    backgroundColor: "transparent"
                    onClicked: ListView.view.currentIndex = model.index
                }

                model: ListModel {
                    ListElement {
                        text: "Active"
                    }
                    ListElement {
                        text: "Achieved"
                    }
                    ListElement {
                        text: "Failed"
                    }
                    ListElement {
                        text: "Dreams"
                    }
                    ListElement {
                        text: "Templates"
                    }
                }
            }
        }
    }

    StackLayout {
        anchors.fill: parent

        ActiveGoalsView {
            id: activeGoalsView
        }
    }

    Comp.AccentButton {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 30
        anchors.rightMargin: 30
        padding: 10
        icon.source: "qrc:/create_icon.svg"
    }
}



