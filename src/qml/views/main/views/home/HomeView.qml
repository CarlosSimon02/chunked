import QtQuick

import components as Comp

Comp.Page {
    Comp.Button {
        text: "Test Dialog"

        onClicked: dialog.open()

        Comp.Dialog {
            id: dialog
            title: "Dialog"
            contentText: "This is just a test Dialog"
        }
    }
}
