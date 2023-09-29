import QtQuick
import QtQuick.Controls.Material

import components as Comp

Comp.PageView {
    title: "Home"

    Button {
        text: "Date Time"
        onClicked: dialog.open()

        Comp.DateTimePickerDialog {
            id: dialog
        }
    }
}
