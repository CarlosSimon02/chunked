import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

ColumnLayout {
    spacing: 30

    Comp.ComboBox {
        Layout.preferredWidth: datePicker.width
        Layout.preferredHeight: 45
        topInset: 0
        bottomInset: 0
        model: ["Active","Pending", "Overdue","Completed"]
    }

    Comp.DatePicker {
        id: datePicker
    }

    RoundButton {
        text: "Reset Filters"
        radius: Material.SmallScale
        flat: true
    }
}
