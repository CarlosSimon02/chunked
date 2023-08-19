import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

Comp.ItemDelegate {
    id: itemDelegate
    implicitWidth: 400
    implicitHeight: 480
    backgroundColor: Comp.ColorScheme.primaryColor.light
    fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
    elevated: true
    padding: 0

    property alias imageSource: image.source
    property alias category: category.text
    property alias goalName: goalName.text
    required property date startDateTime
    required property date endDateTime
    required property double progressValue
    required property double targetValue
    required property string unit

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            opacity: 0.5
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
            Layout.margins: 20

            ColumnLayout {
                anchors.fill: parent

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop
                    spacing: 8

                    Comp.Text {
                        id: goalName
                        Layout.fillWidth: true
                        font.weight: Font.Bold
                        font.pixelSize: 22
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }

                    Comp.Text {
                        id: timeRemaining
                        text: Comp.Utils.getTimeFrame(itemDelegate.startDateTime, itemDelegate.endDateTime) + " remaining"
                        color: Comp.ColorScheme.secondaryColor.dark
                    }

                    Label {
                        id: category
                        leftPadding: 10
                        rightPadding: 10
                        topPadding: 3
                        bottomPadding: 3
                        color: Comp.ColorScheme.secondaryColor.dark
                        background: Rectangle {
                            radius: Comp.Consts.commonRadius
                            color: Comp.Utils.setColorAlpha(Comp.ColorScheme.secondaryColor.dark, 0.1)
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
                            font.pixelSize: 24
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
