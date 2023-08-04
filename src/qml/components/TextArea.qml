import QtQuick
import QtQuick.Controls 

ScrollView {
    property alias placeholderText: textArea.placeholderText
    property alias control: textArea

    background: Rectangle {
        border.width: 1
        border.color: "lightgrey"
    }

    TextArea {
        id: textArea
        background: null
        wrapMode: TextInput.Wrap
    }
}
