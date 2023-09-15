import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

Item {
    id: item
    width: GridView.view.cellWidth
    height: GridView.view.cellHeight

    property bool added
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

    GridView.onAdd: added = true
    Component.onCompleted: {
        if(item.GridView.view.cellHeight < itemDelegate.height)
            item.GridView.view.cellHeight = itemDelegate.height + 20
    }

    Comp.ItemDelegate {
        id: itemDelegate
        anchors.centerIn: parent
        width: subGoal ? 320 : 380
        height: (subGoal ? 220 : 240) + (image.source.toString() ? image.Layout.preferredHeight : 0)
        backgroundColor: Comp.ColorScheme.primaryColor.light
        fadeEffectColor: Comp.ColorScheme.secondaryColor.dark
        elevated: true
        padding: 0

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
                Layout.margins: 20

                ColumnLayout {
                    anchors.fill: parent

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                        spacing: 12

                        Comp.Text {
                            id: goalName
                            Layout.preferredWidth: itemDelegate.availableWidth - 90
                            font.weight: subGoal ? Font.DemiBold : Font.Bold
                            font.pixelSize: 20
                            wrapMode: Text.Wrap
                            maximumLineCount: 2
                            elide: Text.ElideRight
                        }

                        ColumnLayout {
                            spacing: 6

                            IconLabel {
                                spacing: 8
                                icon.source: "qrc:/time_icon.svg"
                                icon.width: 15
                                icon.height: 15
                                icon.color: Comp.ColorScheme.secondaryColor.dark
                                text: new Date() > item.startDateTime ? Comp.Utils.getTimeFrame(new Date(), item.endDateTime) + " remaining" :
                                                                                "Start on " + item.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                color: Comp.ColorScheme.secondaryColor.dark
                            }

                            IconLabel {
                                id: category
                                spacing: 8
                                icon.source: "qrc:/category_icon.svg"
                                icon.width: 15
                                icon.height: 15
                                visible: !item.subGoal
                                icon.color: Comp.ColorScheme.secondaryColor.dark
                                text: Comp.Consts.statusTypes[status]
                                color: Comp.ColorScheme.secondaryColor.dark
                            }

                            IconLabel {
                                spacing: 8
                                icon.source: "qrc:/status_icon.svg"
                                icon.width: 15
                                icon.height: 15
                                icon.color: Comp.ColorScheme.secondaryColor.dark
                                property int status: Comp.Utils.getGoalStatus(item.startDateTime,
                                                                              item.endDateTime,
                                                                              item.targetValue,
                                                                              item.progressValue)
                                text: Comp.Consts.statusTypes[status]
                                color: switch(status) {
                                       case 0: return "darkgoldenrod"
                                       case 1: return "darkolivegreen"
                                       case 2: return "darkblue"
                                       case 3: return "darkred"
                                       }
                            }

                            IconLabel {
                                spacing: 8
                                icon.source: "qrc:/progress_icon.svg"
                                icon.width: 15
                                icon.height: 15
                                icon.color: Comp.ColorScheme.secondaryColor.dark
                                text: item.progressValue.toString() + " / " +
                                      item.targetValue.toString() + " " +
                                      item.unit + " completed"
                                color: Comp.ColorScheme.secondaryColor.dark
                            }
                        }
                    }

                    RowLayout {
                        Comp.Text {
                            id: percentText
                            text: item.targetValue ?
                                      Math.floor(item.progressValue/item.targetValue*100).toString()+"%" :
                                      "--"
                            font.pixelSize: 18
                            font.weight: Font.DemiBold
                            color: Comp.ColorScheme.accentColor.regular
                        }

                        Comp.ProgressBar {
                            Layout.fillWidth: true
                            Layout.preferredHeight: percentText.implicitHeight - 6
                            value: item.progressValue/item.targetValue
                        }
                    }
                }
            }
        }

        Comp.Button {
            padding: 0
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 40
            height: 40
            visible: itemDelegate.hovered
            backgroundColor: Comp.Utils.setColorAlpha(Comp.ColorScheme.primaryColor.light, 0.6)
            icon.source: "qrc:/option_icon.svg"
            onClicked: menu.open()

            Comp.Menu {
                id: menu

                Comp.MenuItem {
                    text: "Delete"
                    onTriggered: {
                        item.GridView.view.model.removeRow(model.index)
                    }
                }
            }
        }
    }

    states: State {
        name: "added"; when: item.added
        PropertyChanges { target: item; scale: 1; opacity: 1 }
    }

    transitions: Transition {
        to: "added"
        reversible: true

        NumberAnimation { property: "opacity"; from: 0; duration: 400 }
        NumberAnimation { property: "scale"; from: 0.7; duration: 400 }
    }
}
