import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

ColumnLayout {
    spacing: 30

    ComboBox {
        Layout.preferredWidth: datePicker.width
        Layout.preferredHeight: 45
        topInset: 0
        bottomInset: 0
        model: ["Active","Pending", "Overdue","Completed"]
    }

    Comp.DatePicker {
        id: datePicker
    }
}
