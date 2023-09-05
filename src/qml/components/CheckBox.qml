import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl

import components as Comp

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: Rectangle {
        implicitWidth: 18
        implicitHeight: 18

        x: control.leftPadding
        y: parent.height / 2 - height / 2

        radius: 3
        color: control.checkState !== Qt.Unchecked ?
                   Comp.ColorScheme.accentColor.dark :
                   "transparent"

        border.width: 1
        border.color: Comp.ColorScheme.accentColor.dark

        ColorImage {
            width: 15
            height: 15

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            color: Comp.ColorScheme.secondaryColor.regular
            source: "qrc:/check_icon.svg"
            visible: control.checkState === Qt.Checked
        }

        Rectangle {
            width: 15
            height: 3

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            color: Comp.ColorScheme.secondaryColor.regular
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    contentItem: CheckLabel {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font: control.font
        color: control.palette.windowText
    }
}
