import QtQuick 
import QtQuick.Templates as T

import components as Comp

T.ProgressBar {
    id: progressBar

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    contentItem: Item {
        implicitWidth: 200
        implicitHeight: 7

        Rectangle {
            width: progressBar.visualPosition * parent.width
            height: parent.height
            radius: progressBar.background.radius
            color: Comp.ColorScheme.accentColor.regular
        }
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        color: Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular, 0.2)
        radius: implicitHeight
    }
}
