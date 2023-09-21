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
            icon.width: 12
            icon.height: 12
            foregroundColor: Comp.ColorScheme.secondaryColor.regular
            display: Button.IconOnly
            radius: 0
            smooth: false
            onClicked: window.showMinimized()
        }

        Comp.Button {
            id: maximize
            Layout.preferredWidth: 50
            icon.width: 12
            icon.height: 12
            icon.source: window.maximized ?
                             "qrc:/restore_down_icon.svg" :
                             "qrc:/maximize_icon.svg"
            foregroundColor: Comp.ColorScheme.secondaryColor.regular
            display: Button.IconOnly
            radius: 0
            smooth: false
            onClicked: {
                if(!window.maximized)
                {
                    window.showMaximized()
                }
                else {
                    window.showNormal()
                }
            }
        }

        Comp.Button {
            id: close
            Layout.preferredWidth: 50
            icon.source: "qrc:/close_icon.svg"
            icon.width: 12
            icon.height: 12
            foregroundColor: Comp.ColorScheme.secondaryColor.regular
            property color mColor: "red"
            fadeEffectHoveredColor: Comp.Utils.setColorAlpha(mColor, 0.8)
            fadeEffectPressedColor: Comp.Utils.setColorAlpha(mColor, 0.6)
            display: Button.IconOnly
            radius: 0
            smooth: false
            onClicked: window.close()
        }
    }
}
