import QtQuick
import QtQuick.Controls as Q
import QtQuick.Layouts

ColumnLayout {
    property alias label: label.text
    property alias control: textField

    Text {
        id: label
    }

    Q.TextField {
        id: textField
        Layout.preferredWidth: 300
        Layout.preferredHeight: 40
        leftPadding: 10
        rightPadding: 10
        verticalAlignment: TextInput.AlignVCenter
    }
}
