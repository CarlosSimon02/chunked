import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import body.components as Body

Comp.Popup {
    id: popup

    property Goal goal: Goal {
        onIdChanged: dbAccess.loadData(goal)
    }

    Comp.Page {
        anchors.fill: parent
        padding: 20
        topPadding: 0

        header: Body.PageHeader {
            background: null
            height: 80
            RowLayout {
                Comp.Button {
                    icon.source: "qrc:/back_icon.svg"
                    onClicked: popup.close()
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

            Comp.Pane {
                Layout.preferredWidth: 400
                Layout.fillHeight: true
                padding: 0

                Comp.ScrollView {
                    id: scrollView
                    anchors.fill: parent
                    contentWidth: availableWidth

                    ColumnLayout {
                        width: scrollView.availableWidth
                        spacing: 0

                        Image {
                            id: image
                            Layout.fillWidth: true
                            Layout.preferredHeight: width * 9 / 16
                            source: goal.imageSource
                            fillMode: Image.PreserveAspectCrop

                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: Item {
                                    width: image.width
                                    height: image.height

                                    ColumnLayout {
                                        anchors.fill: parent
                                        spacing: -Comp.Units.commonRadius
                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            radius: Comp.Units.commonRadius
                                        }
                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: Comp.Units.commonRadius
                                        }
                                    }
                                }
                            }
                        }

                        ColumnLayout {
                            Layout.margins: 20
                            spacing: 40

                            ColumnLayout {
                                Comp.Text {
                                    text: goal.name
                                    font.weight: Font.Bold
                                    font.pixelSize: 24
                                }

                                Comp.Text {
                                    text: "1d 2h remaining"
                                }
                            }

                            ColumnLayout {
                                Comp.Text {
                                    text: "Progress"
                                    font.weight: Font.DemiBold
                                    font.pixelSize: 18
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    spacing: 10

                                    RowLayout {
                                        Comp.Text {
                                            Layout.fillWidth: true
                                            Layout.alignment: Qt.AlignBaseline
                                            color: Comp.ColorScheme.secondaryColor.dark
                                            text: goal.progressValue.toString() + " / " + goal.targetValue.toString() + " " + goal.progressUnit + " completed"
                                        }

                                        Comp.Text {
                                            Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                                            color: Comp.ColorScheme.accentColor.regular
                                            font.pixelSize: 35
                                            font.bold: true
                                            text: Math.floor(goal.progressValue/goal.targetValue*100).toString()+"%"
                                        }

                                    }

                                    Comp.ProgressBar {
                                        Layout.fillWidth: true
                                        value: goal.progressValue/goal.targetValue
                                    }
                                }

                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 15

                                Comp.Text {
                                    text: "Details"
                                    font.weight: Font.DemiBold
                                    font.pixelSize: 18
                                }

                                ColumnLayout {
                                    spacing: 10
                                    Repeater {
                                        Layout.fillWidth: true
                                        RowLayout {
                                            width: parent

                                            Comp.Text {
                                                Layout.preferredWidth: 100
                                                Layout.alignment: Qt.AlignTop
                                                color: Comp.ColorScheme.secondaryColor.dark
                                                text: model.label + ":"
                                            }

                                            Comp.Text {
                                                Layout.fillWidth: true
                                                text: model.data
                                            }
                                        }

                                        model: ListModel {
                                            ListElement {
                                                label: "Parent"
                                                data: "Wash Dishes"
                                            }

                                            ListElement {
                                                label: "Category"
                                                data: "Home"
                                            }

                                            ListElement {
                                                label: "Status"
                                                data: "Active"
                                            }

                                            ListElement {
                                                label: "Category"
                                                data: "Home"
                                            }

                                            ListElement {
                                                label: "Start Time"
                                                data: "January 1, 2023"
                                            }

                                            ListElement {
                                                label: "End Time"
                                                data: "December 31, 2023"
                                            }

                                            ListElement {
                                                label: "Time Frame"
                                                data: "365 days"
                                            }

                                            ListElement {
                                                label: "Tracking"
                                                data: "Task"
                                            }

                                            ListElement {
                                                label: "Target"
                                                data: "100"
                                            }

                                            ListElement {
                                                label: "Unit"
                                                data: "books"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Page {
                Layout.fillWidth: true
                Layout.fillHeight: true
                background: null

                header: Body.PageHeader {
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
                                text: model.text
                                font.weight: Font.Normal
                                bottomInset: 10
                                highlighted: ListView.isCurrentItem
                                backgroundColor: "transparent"
                                onClicked: ListView.view.currentIndex = model.index
                            }

                            model: ListModel {
                                ListElement {
                                    text: "Description"
                                }
                                ListElement {
                                    text: "Subgoals"
                                }
                                ListElement {
                                    text: "Tasks"
                                }
                                ListElement {
                                    text: "Habits"
                                }
                                ListElement {
                                    text: "Journal"
                                }
                            }
                        }
                    }
                }

//                ColumnLayout {
//                    anchors.fill: parent

//                    TabBar {
//                        id: tabBar
//                        Layout.fillWidth: true

//                        TabButton {
//                            text: "Description"
//                        }

//                        TabButton {
//                            text: "Subgoals"
//                        }

//                        TabButton {
//                            text: "Tasks"
//                        }

//                        TabButton {
//                            text: "Habits"
//                        }

//                        TabButton {
//                            text: "Journal"
//                        }
//                    }

//                    StackLayout{
//                        Layout.fillWidth: true
//                        Layout.fillHeight: true
//                        currentIndex: tabBar.currentIndex
//                        clip: true

//                        DescriptionView {

//                        }

//                        SubgoalsView {

//                        }

//                        TasksView {

//                        }

//                        HabitsView {

//                        }

//                        JournalView {

//                        }
//                    }
//                }
            }
        }
    }
}
