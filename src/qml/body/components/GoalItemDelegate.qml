import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

Comp.ItemDelegate {
    id: itemDelegate
    implicitWidth: 400
    implicitHeight: 490
    backgroundColor: Comp.ColorScheme.primaryColor.light
    fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
    elevated: true
    padding: 0

    property alias imageSource: image.source
    property alias category: category.text
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
                    spacing: 10

                    Label {
                        id: category
                        leftPadding: 10
                        rightPadding: 10
                        topPadding: 3
                        bottomPadding: 3
                        color: Comp.ColorScheme.secondaryColor.dark
                        background: Rectangle {
                            radius: Comp.Units.commonRadius
                            color: Comp.Utils.setColorAlpha(Comp.ColorScheme.secondaryColor.dark, 0.1)
                        }
                    }

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
                    }
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
                            text: itemDelegate.progressValue.toString() + " / " + itemDelegate.targetValue.toString() + " " + itemDelegate.unit + " completed"
                        }

                        Comp.Text {
                            Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                            color: Comp.ColorScheme.accentColor.regular
                            font.pixelSize: 35
                            font.bold: true
                            text: Math.floor(itemDelegate.progressValue/itemDelegate.targetValue*100).toString()+"%"
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


//    contentItem: ColumnLayout {
//        RowLayout {
//            Image {
//                id: image
//                Layout.preferredWidth: 80
//                Layout.preferredHeight: 80
//                sourceSize.width: Layout.preferredWidth
//                sourceSize.height: Layout.preferredHeight
//            }

//            ColumnLayout {
//                Comp.Text {
//                    id: category
//                }

//                Comp.Text {
//                    id: goalName
//                    font.weight: Font.Bold
//                    font.pixelSize: 16
//                }

//                Comp.Text {
//                    id: timeRemaining
//                }
//            }
//        }

//        ColumnLayout {
//            ProgressBar {
//                Layout.fillWidth: true
//                id: progressBar
//            }

//            Comp.Text {
//                text: Math.floor(progressBar.value / progressBar.to * 100).toString() + "%"
//            }

//            Comp.Text {
//                text: progressBar.value.toString() + "/" + progressBar.to.toString() + " " + itemDelegate.unit + " completed"
//            }
//        }
//    }
}
