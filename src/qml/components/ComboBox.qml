import QtQuick
import QtQuick.Controls as Ctrl
import QtQuick.Layouts

ColumnLayout {
    property alias label: label.text
    property alias control: comboBox

    Text {
        id: label
    }

    Ctrl.ComboBox {
        id: comboBox
        Layout.preferredWidth: 300
        Layout.preferredHeight: 40
        leftPadding: 10
        rightPadding: 10
    }
}
