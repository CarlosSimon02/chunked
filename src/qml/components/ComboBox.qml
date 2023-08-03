import QtQuick
import QtQuick.Controls as Q
import QtQuick.Layouts

ColumnLayout {
    property alias label: label.text
    property alias control: comboBox

    Text {
        id: label
    }

    Q.ComboBox {
        id: comboBox
        Layout.preferredWidth: 300
        Layout.preferredHeight: 40
        leftPadding: 10
        rightPadding: 10
    }
}
