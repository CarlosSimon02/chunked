import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp
import "../components" as GoalInfo

Comp.Pane {
    implicitWidth: 400
    implicitHeight: 1000
    padding: 0

    GoalInfo.ScrollView {
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
                source: scrollView.goal.imageSource
                fillMode: Image.PreserveAspectCrop

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: image.width
                        height: image.height

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: -Comp.Consts.commonRadius
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: Comp.Consts.commonRadius
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: Comp.Consts.commonRadius
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                Layout.margins: 20
                spacing: 40

                ColumnLayout {
                    spacing: 10

                    Comp.Text {
                        Layout.fillWidth: true
                        text: scrollView.goal.name
                        font.weight: Font.Bold
                        font.pixelSize: 24
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }

                    Comp.Text {
                        text: "1d 2h remaining"
                        color: Comp.ColorScheme.secondaryColor.dark
                    }
                }

                ColumnLayout {
                    spacing: 15
                    Comp.Text {
                        text: "Progress"
                        font.weight: Font.DemiBold
                        font.pixelSize: 18
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        RowLayout {
                            spacing: 15
                            Comp.Text {
                                Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                                color: Comp.ColorScheme.accentColor.regular
                                font.pixelSize: 24
                                font.bold: true
                                text: scrollView.goal.targetValue ? Math.floor(scrollView.goal.progressValue/scrollView.goal.targetValue*100).toString()+"%" : "--"
                            }

                            Comp.Text {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignBaseline
                                color: Comp.ColorScheme.secondaryColor.dark
                                text: scrollView.goal.progressValue.toString() + " / " + scrollView.goal.targetValue.toString() + " " + scrollView.goal.progressUnit + " completed"
                            }
                        }

                        Comp.ProgressBar {
                            Layout.fillWidth: true
                            value: scrollView.goal.progressValue/scrollView.goal.targetValue
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

                        RowLayout {
                            id: parentGoalRowLayout
                            width: parent
                            visible: page.scrollView.goal.parentGoalId

                            Comp.Text {
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignTop
                                color: Comp.ColorScheme.secondaryColor.dark
                                text: "Parent Goal"
                            }

                            Comp.Text {
                                id: parentGoalText
                                Layout.fillWidth: true
                                text: page.scrollView.goal.parentGoalId ? goalsDataAccess.get("goals","name", page.scrollView.goal.parentGoalId) : ""
                            }
                        }

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
