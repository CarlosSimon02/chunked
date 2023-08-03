import QtQuick as Q
import QtQuick.Templates as T

import components as C

T.ProgressBar {
    id: progressBar

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)


    contentItem: Q.Item {
        implicitWidth: 200
        implicitHeight: 7

        Q.Rectangle {
            width: progressBar.visualPosition * parent.width
            height: parent.height
            radius: progressBar.background.radius
            color: C.ColorScheme.accentColor.regular
        }
    }

    background: Q.Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        color: C.Utils.setColorAlpha(C.ColorScheme.accentColor.regular, 0.2)
        radius: implicitHeight
    }
}
