import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Comp.ItemDelegate {
    id: itemDelegate
    implicitHeight: 50
    implicitWidth: 600
    horizontalPadding: 20
    backgroundColor: Comp.ColorScheme.primaryColor.light
    fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
    elevated: true
    font.pixelSize: 15
    font.weight: Font.Normal
    signal setDone

    property alias taskDone: checkBox.checked
    property alias name: name.text
    property alias outcome: outcome.text
    property date startDateTime
    property date endDateTime
    property bool isOutcomeVisible

    contentItem: Item {
        RowLayout {
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            RowLayout {
                spacing: 0

                Label {
                    id: outcome
                    Layout.preferredWidth: Math.max(40, implicitWidth)
                    horizontalAlignment: Text.AlignHCenter
                    topPadding: 3
                    bottomPadding: 3
                    leftPadding: 10
                    rightPadding: 10
                    text: "15"
                    visible: itemDelegate.isOutcomeVisible
                    color: Comp.ColorScheme.secondaryColor.dark
                    background: Rectangle {
                        radius: Comp.Consts.commonRadius
                        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.secondaryColor.dark, 0.1)
                    }
                }

                Comp.CheckBox {
                    id: checkBox
                    onClicked: itemDelegate.setDone()
                }
            }

            Comp.Text {
                id: name
                font: itemDelegate.font
            }

            Comp.Text {
                id: timeRemaining
                Layout.fillWidth: true
                Layout.maximumWidth: Number.POSITIVE_INFINITY
                horizontalAlignment: Text.AlignRight
                text: new Date() > itemDelegate.startDateTime ? Comp.Utils.getTimeFrame(new Date(), itemDelegate.endDateTime) + " remaining" :
                                                                "Start on " + itemDelegate.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                color: Comp.ColorScheme.secondaryColor.dark
            }
        }
    }
}
