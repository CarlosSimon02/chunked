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

        Comp.Button {
            id: minimize
            icon.source: "qrc:/check_icon.svg"
            display: Button.IconOnly
        }

        Comp.Button {
            id: maximize
            icon.source: "qrc:/check_icon.svg"
            display: Button.IconOnly
        }

        Comp.Button {
            id: close
            icon.source: "qrc:/check_icon.svg"
            display: Button.IconOnly
        }
    }
}
