import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

RowLayout {
    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true

        delegate: CheckDelegate {
            width: ListView.view.width
            text: "Sample task"
        }

        model: 10
    }
}
