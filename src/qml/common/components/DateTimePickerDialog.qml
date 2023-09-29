import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Comp.Dialog {
    id: dialog
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
    }

    onAboutToHide: backdrop.close()

    RowLayout {
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
}
