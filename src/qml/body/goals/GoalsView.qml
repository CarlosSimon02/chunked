import QtQuick as Q
import QtQuick.Controls as Q
import QtQuick.Layouts as Q

import components as C
import body.components as B
import "./active_goals"

C.Page {
    signal goalAdded
    topPadding: -pageHeader.bottomPadding
    onGoalAdded: activeGoalsView.model.refresh()

    header: B.PageHeader {
        id: pageHeader

        C.Text {
            text: "Goals"
            font.weight: Q.Font.Bold
            font.pixelSize: 28
        }

        Q.RowLayout {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            width: parent.width

            Q.ListView {
                id: listView
                Q.Layout.fillWidth: true
                Q.Layout.preferredHeight: contentItem.childrenRect.height
                orientation: Q.ListView.Horizontal
                currentIndex: 0
                spacing: 10
                clip: true
                highlightFollowsCurrentItem: false
                highlight: Q.Rectangle {
                    height: 2
                    width: listView.currentItem.width
                    color: C.ColorScheme.accentColor.regular
                    x: listView.currentItem.x
                    y: listView.currentItem.y + listView.currentItem.height - height

                    Q.Behavior on width { Q.SmoothedAnimation { velocity: 100 } }
                    Q.Behavior on x { Q.SmoothedAnimation { velocity: 400 } }
                }

                delegate: C.ItemDelegate {
                    padding: 10
                    bottomPadding: 20
                    text: model.text
                    font.weight: Q.Font.Normal
                    bottomInset: 10
                    highlighted: Q.ListView.isCurrentItem
                    backgroundColor: "transparent"
                    onClicked: Q.ListView.view.currentIndex = model.index
                }

                model: Q.ListModel {
                    Q.ListElement {
                        text: "Active"
                    }
                    Q.ListElement {
                        text: "Achieved"
                    }
                    Q.ListElement {
                        text: "Failed"
                    }
                    Q.ListElement {
                        text: "Dreams"
                    }
                    Q.ListElement {
                        text: "Templates"
                    }
                }
            }
        }
    }

    Q.StackLayout {
        anchors.fill: parent

        ActiveGoalsView {
            id: activeGoalsView
        }
    }

    C.AccentButton {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 30
        anchors.rightMargin: 30
        padding: 10
        icon.source: "qrc:/create_icon.svg"
    }
}



