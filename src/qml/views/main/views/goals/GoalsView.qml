import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import popups as Pop

Comp.Page {
    signal goalAdded
    topPadding: -pageHeader.bottomPadding

    header: Comp.PageHeader {
        id: pageHeader
        height: 90

        Comp.Text {
            text: "Goals"
            font.weight: Font.Bold
            font.pixelSize: 28
        }

//        RowLayout {
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            width: parent.width

//            ListView {
//                id: listView
//                Layout.fillWidth: true
//                Layout.preferredHeight: contentItem.childrenRect.height
//                orientation: ListView.Horizontal
//                currentIndex: 0
//                spacing: 10
//                clip: true
//                highlightFollowsCurrentItem: false
//                highlight: Rectangle {
//                    height: 2
//                    width: listView.currentItem.width
//                    color: Comp.ColorScheme.accentColor.regular
//                    x: listView.currentItem.x
//                    y: listView.currentItem.y + listView.currentItem.height - height

//                    Behavior on width { SmoothedAnimation { velocity: 100 } }
//                    Behavior on x { SmoothedAnimation { velocity: 400 } }
//                }

//                delegate: Comp.ItemDelegate {
//                    padding: 10
//                    bottomPadding: 20
//                    text: model.text
//                    font.weight: Font.Normal
//                    bottomInset: 10
//                    highlighted: ListView.isCurrentItem
//                    backgroundColor: "transparent"
//                    onClicked: ListView.view.currentIndex = model.index
//                }

//                model: ListModel {
//                    ListElement {
//                        text: "Active"
//                    }
//                    ListElement {
//                        text: "Achieved"
//                    }
//                    ListElement {
//                        text: "Failed"
//                    }
//                    ListElement {
//                        text: "Dreams"
//                    }
//                    ListElement {
//                        text: "Templates"
//                    }
//                }
//            }
//        }
    }

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

        ColumnLayout {
            width: scrollView.availableWidth

            GridView {
                id: gridView
                Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
                Layout.preferredHeight: contentHeight
                Layout.alignment: Qt.AlignHCenter

                delegate: Item {
                    id: item
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    Comp.GoalItemDelegate {
                        anchors.centerIn: parent
                        itemId: model.itemId
                        imageSource: model.imageSource
                        category: model.category
                        goalName: model.name
                        startDateTime: Date.fromLocaleString(Qt.locale(), model.startDateTime, "dd MMM yyyy hh:mm AP")
                        endDateTime: Date.fromLocaleString(Qt.locale(), model.endDateTime, "dd MMM yyyy hh:mm AP")
                        progressValue: model.progressValue
                        targetValue: model.targetValue
                        unit: model.progressUnit

                        Component.onCompleted: {
                            if(item.GridView.view.cellWidth < implicitWidth)
                                item.GridView.view.cellWidth = implicitWidth + 20
                            if(item.GridView.view.cellHeight < implicitHeight)
                                item.GridView.view.cellHeight = implicitHeight + 20
                        }
                    }
                }

                Connections {
                    target: createGoalPopup
                    function onSave() {gridView.model.refresh()}
                }

                Connections {
                    target: mainView.StackView
                    function onActivating() {gridView.model.refresh()}
                }

                model: dbAccess.createGoalsTableModel()
            }
        }
    }

    Comp.AccentButton {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 30
        anchors.rightMargin: 30
        padding: 10
        icon.source: "qrc:/create_icon.svg"
        onClicked: {
            createGoalPopup.open()
        }

        Pop.CreateGoalPopup {
            id: createGoalPopup
        }
    }
}

