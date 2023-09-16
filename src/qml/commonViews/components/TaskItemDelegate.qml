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
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 10

                Comp.Text {
                    id: timeRemaining

                    text: new Date() > itemDelegate.startDateTime ? Comp.Utils.getTimeFrame(new Date(), itemDelegate.endDateTime) + " remaining" :
                                                                    "Start on " + itemDelegate.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                    color: Comp.ColorScheme.secondaryColor.dark
                }

                Comp.Button {
                    padding: 0
                    Layout.preferredWidth: 35
                    Layout.preferredHeight: 35
                    backgroundColor: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.light, 0.6)
                    icon.source: "qrc:/option_icon.svg"
                    icon.width: 15
                    icon.height: 15
                    onClicked: menu.open()

                    Comp.Menu {
                        id: menu

                        Comp.MenuItem {
                            text: "Delete"
                            onTriggered: {
                                listView.model.cacheRemoveRow(model.index)
                            }
                        }
                    }
                }
            }
        }
    }
}
