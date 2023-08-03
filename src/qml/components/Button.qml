import QtQuick as Q
import QtQuick.Controls as Q
import QtQuick.Templates as T

import components as C
import "./impl" as Impl

T.Button {
    id: button

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 8
    spacing: 10

    icon.width: 24
    icon.height: 24
    icon.color: foregroundColor
    font.pixelSize: 14

    property Q.color foregroundColor: C.ColorScheme.secondaryColor.regular
    property Q.color backgroundColor: "transparent"
    property Q.color fadeEffectColor: C.ColorScheme.secondaryColor.regular
    property bool elevated: false

    contentItem: Q.IconLabel {
        spacing: button.spacing
        mirrored: button.mirrored
        display: button.display
        alignment: Qt.AlignCenter

        icon: button.icon
        text: button.text
        font: button.font
        color: button.foregroundColor
    }

    background: Q.Rectangle {
        id: rectangle
        radius: C.Units.commonRadius
        color: button.backgroundColor

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: button.fadeEffectColor
            controlIsHovered: button.hovered
            controlIsDown: button.down
        }
    }
}
