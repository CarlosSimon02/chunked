import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.Dialog {
    id: dialog
    width: 527
    height: 40 + header.height + footer.height + 350
    title: "Select Date and Time"
    parent: Overlay.overlay
    anchors.centerIn: parent
    standardButtons: Dialog.Ok | Dialog.Cancel

    property date dateTime
    //startDateTime is use for date and time range.
    //set hasStartDateTime: true and spefify startDateTime
    property date startDateTime
    property bool hasStartDateTime: false

    header: Label {
        text: dialog.title
        visible: dialog.title
        elide: Label.ElideRight
        padding: 20
        color: Comp.Globals.color.secondary.shade2
        font.pixelSize: Comp.Globals.fontSize.medium
    }

    Connections {
        target: backdrop
        function onTapped() {
            dialog.close()
        }
    }

    onAboutToShow: {
        backdrop.open()
        loader.sourceComponent = content
    }

    onAboutToHide: {
        backdrop.close()
        loader.sourceComponent = null
    }

    Loader {
        id: loader
        anchors.fill: parent
    }

    Component {
        id: content

        ColumnLayout {
            id: columnLayout
            spacing: 8

            Component.onCompleted: console.log(columnLayout.height)

            RowLayout {
                RoundButton {
                    id: date
                    Layout.fillWidth: true
                    topInset: 0
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 0
                    flat: true
                    radius: Material.SmallScale
                    highlighted: true

                    onClicked: {
                        stackLayout.currentIndex = 0
                        highlighted = true
                        time.highlighted = false
                    }
                }

                RoundButton {
                    id: time
                    Layout.fillWidth: true
                    topInset: 0
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 0
                    flat: true
                    radius: Material.SmallScale

                    onClicked: {
                        stackLayout.currentIndex = 1
                        highlighted = true
                        date.highlighted = false
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: Comp.Globals.color.accent.shade1
            }

            StackLayout {
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: 1

                RowLayout {
                    id: rowLayout
                    spacing: 40

                    DatePicker {
                        id: datePicker
                        chosenDateTime: dialog.dateTime
                        hasStartDateTime: dialog.hasStartDateTime
                        startDateTime: dialog.startDateTime

                        onChooseDate: dialog.dateTime = chosenDateTime
                    }

                    TimePicker {
                        Layout.preferredHeight: datePicker.height
                        chosenDateTime: dialog.dateTime
                        hasStartDateTime: dialog.hasStartDateTime
                        startDateTime: dialog.startDateTime

                        onChooseTime: dialog.dateTime = chosenDateTime
                    }
                }

                RowLayout {
                    RowLayout {
                        Layout.maximumWidth: Number.POSITIVE_INFINITY
                        Layout.fillWidth: true
                        TimePicker {
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignHCenter
                            chosenDateTime: dialog.dateTime
                            hasStartDateTime: dialog.hasStartDateTime
                            startDateTime: dialog.startDateTime

                            onChooseTime: dialog.dateTime = chosenDateTime
                        }
                    }
                }
            }
        }
    }
}
