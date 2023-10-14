import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import components as Comp
import components.inputs as Inpt
import "../../components" as MComp

Pane {
    implicitWidth: 350
    padding: 0

    ColumnLayout {
        spacing: 30

        MComp.IconComboBox {
            Layout.fillWidth: true
            icon.source: "qrc:/check_icon.svg"
            model: ["Active","Pending", "Overdue","Completed"]
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

                    Comp.TimePicker {
                        id: durationPicker
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height
                    }
                }
            }
        }
    }
}


