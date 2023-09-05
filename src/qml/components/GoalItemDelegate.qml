import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

Comp.ItemDelegate {
    id: itemDelegate
    implicitWidth: subGoal ? 320 : 380
    implicitHeight: (subGoal ? 220 : 220) + (image.source.toString() ? image.Layout.preferredHeight : 0)
    backgroundColor: Comp.ColorScheme.primaryColor.light
    fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
    elevated: true
    padding: 0

    property bool subGoal: false
    property alias imageSource: image.source
    property alias category: category.text
    property alias goalName: goalName.text
    required property int itemId
    required property date startDateTime
    required property date endDateTime
    required property double progressValue
    required property double targetValue
    required property string unit

    onClicked: stackView.push(goalInfoView, {"goal": dbAccess.getGoalItem(itemDelegate.itemId)})

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            opacity: 0.5
            visible: image.source.toString()
            sourceSize.width: {sourceSize.width = width}
            sourceSize.height: {sourceSize.height = height}
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

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 16

            ColumnLayout {
                anchors.fill: parent

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop
                    spacing: 8

                    Comp.Text {
                        id: goalName
                        Layout.fillWidth: true
                        font.weight: subGoal ? Font.DemiBold : Font.Bold
                        font.pixelSize: 20
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }

                    Comp.Text {
                        id: timeRemaining
                        text: new Date() > itemDelegate.startDateTime ? Comp.Utils.getTimeFrame(new Date(), itemDelegate.endDateTime) + " remaining" :
                                                                        "Start on " + itemDelegate.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                        color: Comp.ColorScheme.secondaryColor.dark
                    }

                    RowLayout {
                        Label {
                            leftPadding: 10
                            rightPadding: 10
                            topPadding: 3
                            bottomPadding: 3

                            property int status: Comp.Utils.getGoalStatus(itemDelegate.startDateTime, itemDelegate.endDateTime, itemDelegate.targetValue, itemDelegate.progressValue)
                            text: Comp.Consts.statusTypes[status]
                            color: switch(status) {
                                   case 0: return "darkgoldenrod"
                                   case 1: return "darkolivegreen"
                                   case 2: return "darkblue"
                                   case 3: return "darkred"
                                   }

                            background: Rectangle {
                                radius: Comp.Consts.commonRadius
                                color: Comp.Utils.setColorAlpha(parent.color, 0.1)
                            }
                        }

                        Label {
                            id: category
                            leftPadding: 10
                            rightPadding: 10
                            topPadding: 3
                            bottomPadding: 3
                            visible: !itemDelegate.subGoal
                            color: Comp.ColorScheme.secondaryColor.dark
                            background: Rectangle {
                                radius: Comp.Consts.commonRadius
                                color: Comp.Utils.setColorAlpha(Comp.ColorScheme.secondaryColor.dark, 0.1)
                            }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 10

                    RowLayout {
                        spacing: 15
                        Comp.Text {
                            Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                            color: Comp.ColorScheme.accentColor.regular
                            font.pixelSize: itemDelegate.subGoal ? 20 : 24
                            font.bold: true
                            text: itemDelegate.targetValue ? Math.floor(itemDelegate.progressValue/itemDelegate.targetValue*100).toString()+"%" : "--"
                        }

                        Comp.Text {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignBaseline
                            color: Comp.ColorScheme.secondaryColor.dark
                            text: itemDelegate.progressValue.toString() + " / " + itemDelegate.targetValue.toString() + " " + itemDelegate.unit + " completed"
                        }
                    }

                    Comp.ProgressBar {
                        Layout.fillWidth: true
                        value: itemDelegate.progressValue/itemDelegate.targetValue
                    }
                }
            }
        }
    }
}
