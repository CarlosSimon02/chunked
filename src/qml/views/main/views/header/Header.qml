import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Comp.Pane {
    implicitHeight: 50 + Comp.Consts.commonRadius
    background: null
    padding: 0

    RowLayout {
        anchors.fill: parent

        Comp.Pane {
            Layout.preferredWidth: 200
            Layout.fillHeight: true
            padding: 0
            horizontalPadding: 15
            bottomPadding: Comp.Consts.commonRadius

            background: Rectangle {
                color: Comp.ColorScheme.primaryColor.regular
                radius: Comp.Consts.commonRadius

                Rectangle {
                    width: parent.width
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    height: Comp.Consts.commonRadius
                    color: parent.color
                }
            }

            IconLabel {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                text: "Home"
                font.pixelSize: 18
                font.weight: Font.DemiBold
                color: Comp.ColorScheme.secondaryColor.dark
                icon.source: "qrc:/home_icon.svg"
                icon.width: 20
                icon.height: 20
                icon.color: Comp.ColorScheme.accentColor.regular
            }
        }
    }
}
