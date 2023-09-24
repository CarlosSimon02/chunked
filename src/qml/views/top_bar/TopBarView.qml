import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "./components" as MComp

ToolBar {
    padding: 0
    implicitHeight: rowLayout.height
    Material.primary: Material.color(Material.Grey, Material.ShadeA100)
    property alias minimizeButton: minimize
    property alias maximizeButton: maximize
    property alias closeButton: close

    RowLayout {
        id: rowLayout
        anchors.right: parent.right
        anchors.rightMargin: 0
        spacing: 0

        MComp.Button {
            id: minimize
            icon.source: "qrc:/minimize_icon.svg"
            onClicked: window.showMinimized()
        }

        MComp.Button {
            id: maximize
            icon.source: window.maximized ?
                             "qrc:/restore_down_icon.svg" :
                             "qrc:/maximize_icon.svg"
            display: Button.IconOnly
            onClicked: {
                if(!window.maximized)
                    window.showMaximized()
                else
                    window.showNormal()
            }
        }

        MComp.Button {
            id: close
            icon.source: "qrc:/close_icon.svg"
            hoveredOpacity: 1.0
            pressedOpacity: 0.8
            fadeColor: "red"
            display: Button.IconOnly
            smooth: false
            onClicked: window.close()
        }
    }
}

