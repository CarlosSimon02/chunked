import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp
import views.goal_info
import "./impl" as Impl

Impl.ItemDelegate {
    id: control

    property int itemId
    property string imageSource
    property alias goalName: goalName.text
    property date startDateTime
    property date endDateTime
    property alias category: category.text
    property int progressValue
    property int targetValue
    property string unit
    property bool isSubGoal: false
    property bool hasImage: true

    contentItem: ColumnLayout {
        Image {
            id: image
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16 - (Layout.topMargin + Layout.bottomMargin)
            Layout.topMargin: control.imageSource ? 0 : 15
            Layout.bottomMargin: control.imageSource ? 0 : 15
            fillMode: control.imageSource ? Image.PreserveAspectCrop :
                                            Image.PreserveAspectFit
            opacity: 0.7
            visible: control.hasImage
            source: control.imageSource ? control.imageSource :
                                          "qrc:/robot_with_flag_icon.svg"
            sourceSize.width: {sourceSize.width = width}
            sourceSize.height: {sourceSize.height = height}
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: image.width
                    height: image.height

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: -Material.SmallScale

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: Material.SmallScale
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Material.SmallScale
                        }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.margins: 15
            spacing: 15

            RowLayout {
                spacing: 8

                Text {
                    id: goalName
                    Layout.fillWidth: true
                    Layout.preferredHeight: control.isSubGoal ? 46 : 60
                    font.weight: Font.Medium
                    font.pixelSize: control.isSubGoal ? Comp.Globals.fontSize.medium :
                                                        Comp.Globals.fontSize.large
                    wrapMode: Text.Wrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    color: "white"
                }

                Impl.MenuButton {
                    Layout.preferredHeight: 27
                    Layout.alignment: Qt.AlignTop

                    onClicked: menu.open()

                    Menu {
                        id: menu
                        Material.background: Material.color(Material.Grey, Material.Shade900)
                        Material.elevation: 15

                        MenuItem {
                            text: qsTr("Open")
                            onTriggered: {
                                stackPageView.push("qrc:/common/views/goal_info/GoalInfoView.qml",
                                                   {"itemId": control.itemId})
                            }

                            Material.accent: Material.color(Material.Lime, Material.Shade900)
                        }

                        MenuItem {
                            text: qsTr("Edit")
                            onTriggered: {
                                stackPageView.push("qrc:/common/views/goals_body/views/create_edit_goal/CreateEditGoalView.qml",
                                                   {"goal.itemId" : control.itemId})
                            }

                            Material.accent: Material.color(Material.Lime, Material.Shade900)
                        }

                        MenuItem {
                            text: qsTr("Delete")
                            onTriggered: {
                                    gridView.model.removeRow(model.index)
                            }

                            Material.foreground: Material.Red
                        }
                    }
                }
            }

            ColumnLayout {
                spacing: 6

                Impl.ContentIconLabel {
                    id: timeStatus
                    icon.source: "qrc:/time_icon.svg"
                    text: Comp.Utils.getTimeStatus(control.startDateTime,
                                                   control.endDateTime,
                                                   progressBar.value === 1)
                    color: Comp.Globals.statusColors[Comp.Utils.getStatus(control.startDateTime,
                                                    control.endDateTime,
                                                    progressBar.value === 1)]
                }

                Impl.ContentIconLabel {
                    id: category
                    spacing: 8
                    icon.source: "qrc:/category_icon.svg"
                    visible: !control.isSubGoal
                }

                Impl.ContentIconLabel {
                    icon.source: "qrc:/progress_icon.svg"
                    text: control.progressValue + " / " + control.targetValue + " " +
                          control.unit + " completed"
                }
            }

            RowLayout {
                Layout.fillHeight: true
                Layout.maximumHeight: Number.POSITIVE_INFINITY

                Comp.ProgressBar {
                    id: progressBar
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignBottom
                    value: control.progressValue
                    target: control.targetValue
                    fontPixelSize: control.isSubGoal ? Comp.Globals.fontSize.medium :
                                                       Comp.Globals.fontSize.large
                }
            }
        }
    }

    onClicked: {
        stackPageView.push("qrc:/common/views/goal_info/GoalInfoView.qml",
                           {"itemId": control.itemId})
    }
}
