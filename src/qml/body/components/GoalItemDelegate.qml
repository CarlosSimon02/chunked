import QtQuick as Q
import QtQuick.Controls as Q
import QtQuick.Layouts as Q
import Qt5Compat.GraphicalEffects as Q

import components as C

C.ItemDelegate {
    id: itemDelegate
    implicitWidth: 400
    implicitHeight: 490
    backgroundColor: C.ColorScheme.primaryColor.light
    fadeEffectColor: C.ColorScheme.secondaryColor.dark
    elevated: true
    padding: 0

//    property alias imageSource: image.source
//    property alias category: category.text
//    property alias goalName: goalName.text
//    property alias timeRemaining: timeRemaining.text
//    property alias progressBar: progressBar
//    property string unit: ""

    contentItem: Q.ColumnLayout {
        Q.Image {
            id: image
            Q.Layout.fillWidth: true
            Q.Layout.preferredHeight: width * 9 / 16
            fillMode: Q.Image.PreserveAspectCrop
            opacity: 0.5
            source: "file:/Users/Carlos Simon/Downloads/643b8d08354c7818786eb7a9_Prompt engineer.png"
            layer.enabled: true
            layer.effect: Q.OpacityMask {
                maskSource: Q.Item {
                    width: image.width
                    height: image.height

                    Q.ColumnLayout {
                        anchors.fill: parent
                        spacing: -C.Units.commonRadius
                        Q.Rectangle {
                            Q.Layout.fillWidth: true
                            Q.Layout.fillHeight: true
                            radius: C.Units.commonRadius
                        }
                        Q.Rectangle {
                            Q.Layout.fillWidth: true
                            Q.Layout.preferredHeight: C.Units.commonRadius
                        }
                    }
                }
            }
        }

        Q.Item {
            Q.Layout.fillWidth: true
            Q.Layout.fillHeight: true
            Q.Layout.margins: 20

            Q.ColumnLayout {
                anchors.fill: parent

                Q.ColumnLayout {
                    Q.Layout.fillWidth: true
                    Q.Layout.alignment: Qt.AlignTop
                    spacing: 10

                    Q.Label {
                        text: "Home"
                        leftPadding: 10
                        rightPadding: 10
                        topPadding: 3
                        bottomPadding: 3
                        color: C.ColorScheme.secondaryColor.dark
                        background: Q.Rectangle {
                            radius: C.Units.commonRadius
                            color: C.Utils.setColorAlpha(C.ColorScheme.secondaryColor.dark, 0.1)
                        }
                    }

                    C.Text {
                        id: goalName
                        Q.Layout.fillWidth: true
                        font.weight: Q.Font.Bold
                        font.pixelSize: 22
                        wrapMode: Q.Text.Wrap
                        maximumLineCount: 2
                        elide: Q.Text.ElideRight
                        text: "Become a Fucking Software Engineer"
                    }

                    C.Text {
                        id: timeRemaining
                        text: "1d 12h remaining"
                    }
                }

                Q.ColumnLayout {
                    Q.Layout.fillWidth: true
                    Q.Layout.fillHeight: true
                    spacing: 10

                    Q.RowLayout {
                        C.Text {
                            Q.Layout.fillWidth: true
                            Q.Layout.alignment: Qt.AlignBaseline
                            color: C.ColorScheme.secondaryColor.dark
                            text: "30 / 100 books completed"
                        }

                        C.Text {
                            Q.Layout.alignment: Qt.AlignRight | Qt.AlignBaseline
                            color: C.ColorScheme.accentColor.regular
                            font.pixelSize: 35
                            font.bold: true
                            text: "30%"
                        }

                    }

                    C.ProgressBar {
                        Q.Layout.fillWidth: true
                        value: 0.8
                    }
                }
            }
        }
    }


//    contentItem: Q.ColumnLayout {
//        Q.RowLayout {
//            Q.Image {
//                id: image
//                Q.Layout.preferredWidth: 80
//                Q.Layout.preferredHeight: 80
//                sourceSize.width: Q.Layout.preferredWidth
//                sourceSize.height: Q.Layout.preferredHeight
//            }

//            Q.ColumnLayout {
//                C.Text {
//                    id: category
//                }

//                C.Text {
//                    id: goalName
//                    font.weight: Q.Font.Bold
//                    font.pixelSize: 16
//                }

//                C.Text {
//                    id: timeRemaining
//                }
//            }
//        }

//        Q.ColumnLayout {
//            Q.ProgressBar {
//                Q.Layout.fillWidth: true
//                id: progressBar
//            }

//            C.Text {
//                text: Math.floor(progressBar.value / progressBar.to * 100).toString() + "%"
//            }

//            C.Text {
//                text: progressBar.value.toString() + "/" + progressBar.to.toString() + " " + itemDelegate.unit + " completed"
//            }
//        }
//    }
}
