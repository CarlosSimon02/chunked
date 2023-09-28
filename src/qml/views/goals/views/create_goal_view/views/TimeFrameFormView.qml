import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "../components" as MComp

ScrollView {
    id: scrollView
    contentHeight: columnLayout.height

    MouseArea {
        anchors.fill: parent
        onClicked: { scrollView.focus = false}
    }

    ColumnLayout {
        id: columnLayout
        width: scrollView.width

        ColumnLayout {
            Layout.margins: 30
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Start Time"
                }

                RowLayout {
                    spacing: 15

                    TextField {
                        id: startTime
                        Layout.maximumWidth: 500
                        Layout.fillWidth: true
                    }

                    Comp.IconButton {
                        Layout.preferredWidth: startTime.height
                        Layout.preferredHeight: startTime.height
                        flat: true
                        icon.source: "qrc:/date_time_icon.svg"
                        icon.color: Comp.Globals.color.secondary.shade1

                        Material.roundedScale: Material.SmallScale
                    }
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "End Time"
                }

                RowLayout {
                    spacing: 15

                    TextField {
                        id: endTime
                        Layout.maximumWidth: 500
                        Layout.fillWidth: true
                    }

                    Comp.IconButton {
                        Layout.preferredWidth: endTime.height
                        Layout.preferredHeight: endTime.height
                        flat: true
                        icon.source: "qrc:/date_time_icon.svg"
                        icon.color: Comp.Globals.color.secondary.shade1

                        Material.roundedScale: Material.SmallScale

                        onClicked: endDateTimePicker.open()

                        Comp.DateTimePickerDialog {
                            id: endDateTimePicker

                        }
                    }
                }
            }
        }
    }
}
