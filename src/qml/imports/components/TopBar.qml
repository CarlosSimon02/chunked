import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Item {
    property alias minimizeButton: minimize
    property alias maximizeButton: maximize
    property alias closeButton: close

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: 0
        spacing: 0

        Comp.Button {
            id: minimize
            Layout.preferredWidth: 50
            icon.source: "qrc:/minimize_icon.svg"
            display: Button.IconOnly
            radius: 0
        }

        Comp.Button {
            id: maximize
            Layout.preferredWidth: 50
            icon.source: "qrc:/maximize_icon.svg"
            display: Button.IconOnly
            radius: 0
        }

        Comp.Button {
            id: close
            Layout.preferredWidth: 50
            icon.source: "qrc:/close_icon.svg"
            display: Button.IconOnly
            radius: 0
            fadeEffectColor: "red"
        }
    }
}
