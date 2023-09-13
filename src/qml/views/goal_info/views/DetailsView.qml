import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import app

import components as Comp

Comp.Pane {
    id: pane
    implicitWidth: 400
    implicitHeight: 1000
    padding: 0
    elevated: true

    property Goal goal

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: parent.width
            spacing: 0

            Image {
                id: image
                Layout.fillWidth: true
                Layout.preferredHeight: width * 9 / 16
                source: pane.goal.imageSource
                fillMode: Image.PreserveAspectCrop
                visible: pane.goal.imageSource.toString()
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

                Column {
                    Layout.fillWidth: true
                    spacing: 10

                    Comp.Text {
                        width: parent.width
                        text: pane.goal.name
                        font.weight: Font.Bold
                        font.pixelSize: 24
                        wrapMode: Text.Wrap
                    }

                    Comp.Text {
                        text: Comp.Utils.getTimeFrame(new Date(),
                                                      Date.fromLocaleString(Qt.locale(), pane.goal.endDateTime, "dd MMM yyyy hh:mm AP")) + " remaining"
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
                            visible: pane.goal.progressTracker === 6

                            Comp.Button {
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                text: "-"
                                font.pixelSize: 20
                                font.weight: Font.DemiBold
                                onClicked: {
                                    if(pane.goal.progressValue > 0) {
                                        pane.goal.progressValue--
                                        dbAccess.updateValue("goals", "progressValue", pane.goal.itemId, pane.goal.progressValue)
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
                                    if(pane.goal.progressValue < pane.goal.targetValue) {
                                        pane.goal.progressValue++
                                        dbAccess.updateValue("goals", "progressValue", pane.goal.itemId, pane.goal.progressValue)
                                    }
                                }
                            }

                            Comp.Button {
                                Layout.preferredHeight: 30
                                text: "Edit"
                                onClicked: {
                                    progressEditPopup.open()
                                    progressEditPopup.targetValue = pane.goal.targetValue
                                    progressEditPopup.currentProgress = pane.goal.progressValue
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
                                                    if(targetValueTextArea.text !== pane.goal.targetValue.toString()) {
                                                        pane.goal.targetValue = text
                                                        dbAccess.updateValue("goals", "targetValue", pane.goal.itemId, pane.goal.targetValue)
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
                                                    if(currentProgressTextArea.text !== pane.goal.progressValue.toString()) {
                                                        pane.goal.progressValue = text
                                                        dbAccess.updateValue("goals", "progressValue", pane.goal.itemId, pane.goal.progressValue)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Frame {
                        Layout.fillWidth: true
                        padding: 15
                        background: Rectangle {
                            color: "transparent"
                            border.width: 1
                            border.color: Comp.ColorScheme.secondaryColor.veryDark
                            radius: Comp.Consts.commonRadius
                        }

                        ColumnLayout {
                            width: parent.width
                            spacing: 10

                            RowLayout {
                                spacing: 15
                                Comp.Text {
                                    Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                                    color: Comp.ColorScheme.accentColor.regular
                                    font.pixelSize: 24
                                    font.bold: true
                                    text: pane.goal.targetValue ? Math.floor(pane.goal.progressValue/pane.goal.targetValue*100).toString()+"%" : "--"
                                }

                                Comp.Text {
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignBaseline
                                    color: Comp.ColorScheme.secondaryColor.dark
                                    text: pane.goal.progressValue.toString() + " / " + pane.goal.targetValue.toString() + " " + pane.goal.progressUnit + " completed"
                                }
                            }

                            Comp.ProgressBar {
                                Layout.fillWidth: true
                                value: pane.goal.progressValue/pane.goal.targetValue
                            }
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

                    Frame {
                        Layout.fillWidth: true
                        padding: 15
                        background: Rectangle {
                            color: "transparent"
                            border.width: 1
                            border.color: Comp.ColorScheme.secondaryColor.veryDark
                            radius: Comp.Consts.commonRadius
                        }

                        ColumnLayout {
                            spacing: 10

                            RowLayout {
                                id: parentGoalRowLayout
                                width: parent
                                visible: pane.goal.parentGoalId

                                Comp.Text {
                                    Layout.preferredWidth: 100
                                    Layout.alignment: Qt.AlignTop
                                    color: Comp.ColorScheme.secondaryColor.dark
                                    text: "Parent Goal"
                                }

                                Comp.Text {
                                    id: parentGoalText
                                    Layout.fillWidth: true
                                    text: pane.goal.parentGoalId ? dbAccess.getValue("goals", "name", pane.goal.parentGoalId) : ""
                                    font.underline: true
                                    wrapMode: Text.Wrap

                                    HoverHandler {
                                        cursorShape: Qt.PointingHandCursor
                                    }

                                    TapHandler {
                                        onTapped: stackView.push(goalInfoView, {"goal": dbAccess.getGoalItem(pane.goal.parentGoalId)})
                                    }
                                }
                            }

                            RowLayout {
                                width: parent

                                Comp.Text {
                                    Layout.preferredWidth: 100
                                    Layout.alignment: Qt.AlignTop
                                    color: Comp.ColorScheme.secondaryColor.dark
                                    text: "Status"
                                }

                                Comp.Text {
                                    Layout.fillWidth: true
                                    property int status: Comp.Utils.getGoalStatus(Date.fromLocaleString(Qt.locale(), pane.goal.startDateTime, "dd MMM yyyy hh:mm AP"),
                                                                                  Date.fromLocaleString(Qt.locale(), pane.goal.endDateTime, "dd MMM yyyy hh:mm AP"),
                                                                                  pane.goal.targetValue,
                                                                                  pane.goal.progressValue)
                                    text: Comp.Consts.statusTypes[status]
                                    color: switch(status) {
                                           case 0: return "darkgoldenrod"
                                           case 1: return "darkolivegreen"
                                           case 2: return "darkblue"
                                           case 3: return "darkred"
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
                                        append({"label":"Category", "data":pane.goal.category})
                                        append({"label":"Start Time", "data":pane.goal.startDateTime})
                                        append({"label":"End Time", "data":pane.goal.endDateTime})
                                        append({"label":"Time Frame", "data":Comp.Utils.getTimeFrame(Date.fromLocaleString(Qt.locale(), pane.goal.startDateTime, "dd MMM yyyy hh:mm AP"),
                                                                                                     Date.fromLocaleString(Qt.locale(), pane.goal.endDateTime, "dd MMM yyyy hh:mm AP"))})
                                        append({"label":"Tracker", "data":Comp.Consts.goalProgressTrackers[pane.goal.progressTracker]})
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
