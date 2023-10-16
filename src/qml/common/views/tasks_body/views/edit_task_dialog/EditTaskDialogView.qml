import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "../../components" as MComp

Comp.Dialog {
    title: "Edit Task"

    ColumnLayout {
        spacing: 30

        ColumnLayout {
            spacing: 12

            Text {
                text: "Outcomes"
                font.pixelSize: Comp.Globals.fontSize.medium
                font.weight: Font.DemiBold
                color: Material.color(Material.Grey, Material.Shade600)
            }

            SpinBox {
                id: outcomes
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                editable: true
                from: 1
                to: 99999
            }
        }

        ColumnLayout {
            spacing: 12

            Text {
                text: "Date and Time Frame"
                font.pixelSize: Comp.Globals.fontSize.medium
                font.weight: Font.DemiBold
                color: Material.color(Material.Grey, Material.Shade600)
            }

            ColumnLayout {
                spacing: 20

                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentItem.childrenRect.height
                    spacing: 10
                    currentIndex: 0
                    delegate: Comp.NavBarDelegate {
                        width: (listView.width - (listView.spacing * 2)) / 3
                        highlighted: ListView.isCurrentItem
                        display: ItemDelegate.IconOnly
                        icon.source: model.icon
                        onClicked: listView.currentIndex = model.index

                        ToolTip.visible: hovered
                        ToolTip.text: model.label
                    }

                    model: ListModel {
                        ListElement {
                            icon: "qrc:/date_icon.svg"
                            label: "Date"
                        }

                        ListElement {
                            icon: "qrc:/time_icon.svg"
                            label: "Time"
                        }

                        ListElement {
                            icon: "qrc:/timer_icon.svg"
                            label: "Duration"
                        }
                    }

                    orientation: ListView.Horizontal
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 350
                    currentIndex: listView.currentIndex

                    Comp.DatePicker {
                        id: datePicker
                    }

                    Page {
                        background: null
                        header: RowLayout {
                            RowLayout {
                                Layout.alignment: Qt.AlignHCenter
                                Layout.bottomMargin: 10
                                spacing: 30

                                Text {
                                    text: "HH"
                                    font.pointSize: Comp.Globals.fontSize.superSmall
                                    font.weight: Font.Normal
                                    color: Comp.Globals.color.secondary.shade1
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                Text {
                                    text: "MM"
                                    font.pointSize: Comp.Globals.fontSize.superSmall
                                    font.weight: Font.Normal
                                    color: Comp.Globals.color.secondary.shade1
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }

                        Comp.TimePicker {
                            id: timePicker
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: parent.height
                            chosenDateTime: new Date(0,0,0,0,0,0)
                            onChooseTime: datePicker.chosenDateTime.setHours(timePicker.chosenDateTime.getHours(),
                                                                             timePicker.chosenDateTime.getMinutes())
                        }
                    }

                    Page {
                        background: null
                        header: RowLayout {
                            RowLayout {
                                Layout.alignment: Qt.AlignHCenter
                                Layout.bottomMargin: 10
                                spacing: 30

                                Text {
                                    text: "HH"
                                    font.pointSize: Comp.Globals.fontSize.superSmall
                                    font.weight: Font.Normal
                                    color: Comp.Globals.color.secondary.shade1
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                Text {
                                    text: "MM"
                                    font.pointSize: Comp.Globals.fontSize.superSmall
                                    font.weight: Font.Normal
                                    color: Comp.Globals.color.secondary.shade1
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }

                        MComp.DurationPicker {
                            id: durationPicker
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: parent.height
                        }
                    }
                }
            }
        }
    }
}
