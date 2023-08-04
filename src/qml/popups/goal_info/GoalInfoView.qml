import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp

Comp.Popup {
    id: popup

    property Goal goal: Goal {
        onIdChanged: dbAccess.loadData(goal)
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Button {
                text: "Back"
                onClicked: popup.close()
            }

           Comp.PageHeaderTitle {
                text: "Goal Info"
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollView {
                id: scrollView
                Layout.preferredWidth: 400
                Layout.fillHeight: true
                padding: 10
                rightPadding: 10
                bottomPadding: 10
                background: Rectangle {
                    color: "lightgrey"
                }

                ColumnLayout {
                    width: scrollView.availableWidth
                    spacing: 30

                    Image {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 250
                        sourceSize.width: Layout.preferredWidth
                        sourceSize.height: Layout.preferredHeight
                        source: goal.imageSource
                        fillMode: Image.PreserveAspectCrop
                    }

                    ColumnLayout {
                        Text {
                            text: goal.name
                            font.weight: Font.Bold
                            font.pixelSize: 24
                        }

                        Text {
                            text: "1d 2h remaining"
                        }
                    }

                    ColumnLayout {
                        Text {
                            text: "Progress"
                            font.bold: true
                        }

                        ProgressBar {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            value: goal.progressValue / goal.targetValue
                        }

                        Text {
                            text: goal.progressValue + " out of " + goal.targetValue + " " + goal.progressUnit + " is completed"
                        }

                        Text {
                            text: ((goal.progressValue / goal.targetValue) * 100).toString() + "%"
                        }

                    }

                    ColumnLayout {
                        Layout.fillWidth: true

                        Text {
                            text: "Details"
                            font.bold: true
                        }

                        Repeater {
                            Layout.fillWidth: true
                            RowLayout {
                                width: parent

                                Text {
                                    Layout.preferredWidth: 100
                                    Layout.alignment: Qt.AlignTop
                                    text: model.label + ":"
                                }

                                Text {
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

            Pane {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent

                    TabBar {
                        id: tabBar
                        Layout.fillWidth: true

                        TabButton {
                            text: "Description"
                        }

                        TabButton {
                            text: "Subgoals"
                        }

                        TabButton {
                            text: "Tasks"
                        }

                        TabButton {
                            text: "Habits"
                        }

                        TabButton {
                            text: "Journal"
                        }
                    }

                    StackLayout{
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        currentIndex: tabBar.currentIndex
                        clip: true

                        DescriptionView {

                        }

                        SubgoalsView {

                        }

                        TasksView {

                        }

                        HabitsView {

                        }

                        JournalView {

                        }
                    }
                }
            }
        }
    }
}
