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
                visible: scrollView.goal.imageSource.toString()
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
                        text: Comp.Utils.getTimeFrame(new Date(),
                                                      Date.fromLocaleString(Qt.locale(), scrollView.goal.endDateTime, "dd MMM yyyy hh:mm AP")) + " remaining"
                        color: Comp.ColorScheme.secondaryColor.dark
                    }
                }

                ColumnLayout {
                    spacing: 15

                    RowLayout {
                        Layout.maximumWidth: Number.POSITIVE_INFINITY

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
                                font.weight: Font.DemiBold
                                onClicked: {
                                    if(scrollView.goal.progressValue > 0) {
                                        scrollView.goal.progressValue--
                                        dbAccess.updateValue("goals", "progressValue", scrollView.goal.itemId, scrollView.goal.progressValue)
                                    }
                                }
                            }

                            Comp.Button {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                text: "+"
                                font.pixelSize: 20
                                font.weight: Font.DemiBold
                                onClicked: {
                                    if(scrollView.goal.progressValue < scrollView.goal.targetValue) {
                                        scrollView.goal.progressValue++
                                        dbAccess.updateValue("goals", "progressValue", scrollView.goal.itemId, scrollView.goal.progressValue)
                                    }
                                }
                            }

                            Comp.Button {
                                Layout.preferredHeight: 30
                                text: "Edit"
                                onClicked: {
                                    progressEditPopup.open()
                                    progressEditPopup.targetValue = scrollView.goal.targetValue
                                    progressEditPopup.currentProgress = scrollView.goal.progressValue
                                }

                                Comp.Popup {
                                    id: progressEditPopup
                                    x: parent.x - implicitWidth
                                    padding: 20

                                    property alias targetValue: targetValueTextArea.text
                                    property alias currentProgress: currentProgressTextArea.text

                                    ColumnLayout {
                                        spacing: 25

                                        Comp.FieldColumnLayout {
                                            Comp.FieldLabel {
                                                text: "Target Value"
                                            }

                                            Comp.TextArea {
                                                id: targetValueTextArea
                                                Layout.preferredWidth: 200
                                                onEditingFinished: {
                                                    if(targetValueTextArea.text !== scrollView.goal.targetValue.toString()) {
                                                        scrollView.goal.targetValue = text
                                                        dbAccess.updateValue("goals", "targetValue", scrollView.goal.itemId, scrollView.goal.targetValue)
                                                    }
                                                }
                                            }
                                        }

                                        Comp.FieldColumnLayout {
                                            Comp.FieldLabel {
                                                text: "Current Progress"
                                            }

                                            Comp.TextArea {
                                                id: currentProgressTextArea
                                                Layout.preferredWidth: 200
                                                onEditingFinished: {
                                                    if(currentProgressTextArea.text !== scrollView.goal.progressValue.toString()) {
                                                        scrollView.goal.progressValue = text
                                                        dbAccess.updateValue("goals", "progressValue", scrollView.goal.itemId, scrollView.goal.progressValue)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
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
                                    append({"label":"Time Frame", "data":Comp.Utils.getTimeFrame(Date.fromLocaleString(Qt.locale(), scrollView.goal.startDateTime, "dd MMM yyyy hh:mm AP"),
                                                                                                 Date.fromLocaleString(Qt.locale(), scrollView.goal.endDateTime, "dd MMM yyyy hh:mm AP"))})
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
