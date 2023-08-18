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

    property alias goal: scrollView.goal

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

                    RowLayout {
                        Layout.fillWidth: true

                        Comp.Text {
                            text: "Progress"
                            font.weight: Font.DemiBold
                            font.pixelSize: 18
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignRight
                            visible: scrollView.goal.progressTracker === 6

                            Comp.Button {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                text: "-"
                                font.pixelSize: 20
                                font.bold: true
                            }

                            Comp.Button {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                text: "+"
                                font.pixelSize: 20
                                font.bold: true
                            }

                            Comp.Button {
                                Layout.preferredHeight: 30
                                text: "Edit"
                            }
                        }
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
                            visible: scrollView.goal.parentGoalId

                            Comp.Text {
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignTop
                                color: Comp.ColorScheme.secondaryColor.dark
                                text: "Parent Goal"
                            }

                            Comp.Text {
                                id: parentGoalText
                                Layout.fillWidth: true
                                text: scrollView.goal.parentGoalId ? dbAccess.getValue("goals", "name", scrollView.goal.parentGoalId) : ""
                                font.underline: true
                                wrapMode: Text.Wrap

                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }

                                TapHandler {
                                    onTapped: stackView.push(goalInfoView, {"goal": dbAccess.getGoalItem(scrollView.goal.parentGoalId)})
                                }
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
                                    wrapMode: Text.Wrap
                                }
                            }

                            model: ListModel {
                                Component.onCompleted: {
                                    append({"label":"Category", "data":scrollView.goal.category})
                                    append({"label":"Status", "data":"Active"})
                                    append({"label":"Start Time", "data":scrollView.goal.startDateTime})
                                    append({"label":"End Time", "data":scrollView.goal.endDateTime})
                                    append({"label":"Time Frame", "data":"1d 2h"})
                                    append({"label":"Tracker", "data":Comp.Consts.goalProgressTrackers[scrollView.goal.progressTracker]})
                                    append({"label":"Target", "data":scrollView.goal.targetValue.toString()})
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
