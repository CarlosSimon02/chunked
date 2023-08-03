import QtQuick
import QtQuick.Controls as Q

Q.ScrollView {
    property alias placeholderText: textArea.placeholderText
    property alias control: textArea

    background: Rectangle {
        border.width: 1
        border.color: "lightgrey"
    }

    Q.TextArea {
        id: textArea
        background: null
        wrapMode: TextInput.Wrap
    }
}
