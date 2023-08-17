import QtQuick 
import QtQuick.Controls 
import QtQuick.Templates as T

import components as Comp
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

    property color foregroundColor: enabled ? highlighted ? Comp.ColorScheme.accentColor.regular :
                                                            Comp.ColorScheme.secondaryColor.regular :
                                              Comp.ColorScheme.secondaryColor.veryDark
    property color backgroundColor: "transparent"
    property color fadeEffectColor: Comp.ColorScheme.secondaryColor.regular
    property bool elevated: false
    property alias border: rectangle.border

    contentItem: IconLabel {
        spacing: button.spacing
        mirrored: button.mirrored
        display: button.display
        alignment: Qt.AlignCenter

        icon: button.icon
        text: button.text
        font: button.font
        color: button.foregroundColor
    }

    background: Rectangle {
        id: rectangle
        radius: Comp.Consts.commonRadius
        color: button.backgroundColor
        border.color: button.foregroundColor
        border.width: 0

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: button.fadeEffectColor
            controlIsHovered: button.hovered
            controlIsDown: button.down
            controlIsHighlighted: button.highlighted
            controlIsEnabled: button.enabled
        }
    }
}
