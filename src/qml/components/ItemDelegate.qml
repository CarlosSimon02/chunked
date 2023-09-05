import QtQuick 
import QtQuick.Controls 
import Qt5Compat.GraphicalEffects 
import QtQuick.Templates as T

import components as Comp
import components.impl as Impl

T.ItemDelegate {
    id: itemDelegate

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 10
    spacing: 15

    icon.width: 20
    icon.height: 20
    icon.color: foregroundColor
    font.pixelSize: 14
    font.weight: Font.Medium
    focusPolicy: Qt.ClickFocus

    property color foregroundColor: enabled ? highlighted ? Comp.ColorScheme.accentColor.regular :
                                             Comp.ColorScheme.secondaryColor.dark :
                                    Comp.ColorScheme.secondaryColor.veryDark
    property color backgroundColor: highlighted ? Comp.Utils.setColorAlpha(Comp.ColorScheme.accentColor.regular, 0.1) :
                                             "transparent"
    property color fadeEffectColor: Comp.ColorScheme.secondaryColor.regular
    property bool elevated: false

    contentItem: IconLabel {
        spacing: itemDelegate.spacing
        mirrored: itemDelegate.mirrored
        display: itemDelegate.display
        alignment: Qt.AlignLeft

        icon: itemDelegate.icon
        text: itemDelegate.text
        font: itemDelegate.font
        color: itemDelegate.foregroundColor
    }

    background: Rectangle {
        radius: Comp.Consts.commonRadius
        color: itemDelegate.backgroundColor

        layer.enabled: itemDelegate.elevated
        layer.effect: DropShadow {
            horizontalOffset: 2
            verticalOffset: 2
            spread: 0.2
            radius: 12
            samples: 17
            color: Comp.ColorScheme.primaryColor.shadow
        }

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: itemDelegate.fadeEffectColor
            controlIsHovered: itemDelegate.hovered
            controlIsDown: itemDelegate.down
            controlIsHighlighted: itemDelegate.highlighted
            controlIsEnabled: itemDelegate.enabled
        }
    }

    states: State {
        name: "down"
        when: itemDelegate.hovered && !itemDelegate.highlighted && itemDelegate.enabled

        PropertyChanges {
            target: itemDelegate
            foregroundColor: Comp.ColorScheme.secondaryColor.regular
        }
    }

    transitions: Transition {
        to: "down"
        reversible: true

        ColorAnimation {
            target: itemDelegate
            property: "foregroundColor"
            duration: 300
        }
    }
}
