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
                padding: 0
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                background: Rectangle {
                    color: Comp.ColorScheme.primaryColor.light
                }

                ColumnLayout {
                    width: scrollView.availableWidth
                    spacing: 40

                    Image {
                        Layout.fillWidth: true
                        Layout.preferredHeight: width * 9 / 16
                        sourceSize.width: Layout.preferredWidth
                        sourceSize.height: Layout.preferredHeight
                        source: goal.imageSource
                        fillMode: Image.PreserveAspectCrop
                    }

                    ColumnLayout {
                        Comp.Text {
                            text: goal.name
                            font.weight: Font.Bold
                            font.pixelSize: 30
                        }

                        Comp.Text {
                            text: "1d 2h remaining"
                        }
                    }

                    ColumnLayout {
                        Comp.Text {
                            text: "Progress"
                            font.bold: true
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
                            font.bold: true
                            font.pixelSize: 18
                        }

                        ColumnLayout {
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

//            Pane {
//                Layout.fillWidth: true
//                Layout.fillHeight: true

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
//            }
        }
    }
}
