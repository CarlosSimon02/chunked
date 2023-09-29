import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.Dialog {
    id: dialog
    //Will fix this spagetti code
    width: maximumWidth > (window.width - (leftMargin + rightMargin)) ? (window.width - (leftMargin + rightMargin))  : maximumWidth
    height: maximumHeight > (window.height - (topMargin + bottomMargin)) ? (window.height - (topMargin + bottomMargin)) : maximumHeight

    property int maximumWidth: window.width > Comp.Globals.screen.smallW ? 527 : 390
    property int maximumHeight: window.width > Comp.Globals.screen.smallW ? 40 + header.height + footer.height + 350  :
                                                                            40 + header.height + footer.height + 407

    title: "Select Date and Time"
    parent: Overlay.overlay
    anchors.centerIn: parent
    standardButtons: Dialog.Ok | Dialog.Cancel

    Material.accent: Comp.Globals.color.accent.shade1

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

            RowLayout {
                visible: !timePicker.visible

                RoundButton {
                    id: dateButton
                    Layout.fillWidth: true
                    topInset: 0
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 0
                    padding: 6
                    flat: true
                    radius: Material.SmallScale
                    highlighted: true
                    icon.source: "qrc:/date_icon.svg"

                    onClicked: {
                        stackLayout.currentIndex = 0
                        highlighted = true
                        timeButton.highlighted = false
                    }
                }

                RoundButton {
                    id: timeButton
                    Layout.fillWidth: true
                    topInset: 0
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 0
                    padding: 6
                    flat: true
                    radius: Material.SmallScale
                    icon.source: "qrc:/time_icon.svg"

                    onClicked: {
                        stackLayout.currentIndex = 1
                        highlighted = true
                        dateButton.highlighted = false
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: Comp.Globals.color.accent.shade1
                visible: !timePicker.visible
            }

            StackLayout {
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: 0

                RowLayout {
                    id: rowLayout
                    spacing: 40

                    DatePicker {
                        id: datePicker
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        chosenDateTime: dialog.dateTime
                        hasStartDateTime: dialog.hasStartDateTime
                        startDateTime: dialog.startDateTime

                        onChooseDate: dialog.dateTime = chosenDateTime
                    }

                    TimePicker {
                        id: timePicker
                        Layout.preferredHeight: datePicker.height
                        chosenDateTime: dialog.dateTime
                        hasStartDateTime: dialog.hasStartDateTime
                        startDateTime: dialog.startDateTime
                        visible: window.width > Comp.Globals.screen.smallW

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
