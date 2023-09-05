import QtQuick
import QtQuick.Controls
import components as Comp

Comp.Page {
    Comp.Button {
        text: "Test Dialog"

        onClicked: dialog.open()

        Comp.Dialog {
            id: dialog
            title: "Dialog"
            standardButtons: Dialog.Ok | Dialog.Cancel
            contentText: "This is just a test Dialog"
        }
    }
}
