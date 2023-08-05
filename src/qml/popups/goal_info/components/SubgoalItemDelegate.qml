import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

Comp.ItemDelegate {
    id: itemDelegate
    implicitWidth: 320
    implicitHeight: 380
    backgroundColor: Comp.ColorScheme.primaryColor.light
    fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
    elevated: true
    padding: 0

    property alias imageSource: image.source
    property alias goalName: goalName.text
    property alias timeRemaining: timeRemaining.text
    property double progressValue
    property double targetValue
    property string unit: ""

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            opacity: 0.5
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
                        font.weight: Font.DemiBold
                        font.pixelSize: 20
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }

                    Comp.Text {
                        id: timeRemaining
                        color: Comp.ColorScheme.secondaryColor.dark
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignBottom
                    spacing: 10

                    RowLayout {
                        spacing: 15
                        Comp.Text {
                            Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                            color: Comp.ColorScheme.accentColor.regular
                            font.pixelSize: 20
                            font.bold: true
                            text: Math.floor(itemDelegate.progressValue/itemDelegate.targetValue*100).toString()+"%"
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
                        Layout.preferredHeight: 6
                        value: itemDelegate.progressValue/itemDelegate.targetValue
                    }
                }
            }
        }
    }
}
