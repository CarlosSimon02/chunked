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
    property bool isOutcomeVisible

    contentItem: Item {
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            RowLayout {
                spacing: 0

                Label {
                    id: category
                    leftPadding: 10
                    rightPadding: 10
                    topPadding: 3
                    bottomPadding: 3
                    text: "15"
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
        }
    }
}
