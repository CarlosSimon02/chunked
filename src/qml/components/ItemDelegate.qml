import QtQuick as Q
import QtQuick.Controls as Q
import Qt5Compat.GraphicalEffects as Q
import QtQuick.Templates as T

import components as C
import "./impl" as Impl

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
    font.weight: Q.Font.Medium

    property Q.color foregroundColor: highlighted ? C.ColorScheme.accentColor.regular :
                                             C.ColorScheme.secondaryColor.dark
    property Q.color backgroundColor: highlighted ? C.Utils.setColorAlpha(C.ColorScheme.accentColor.regular, 0.1) :
                                             "transparent"
    property Q.color fadeEffectColor: C.ColorScheme.secondaryColor.regular
    property bool elevated: false

    contentItem: Q.IconLabel {
        spacing: itemDelegate.spacing
        mirrored: itemDelegate.mirrored
        display: itemDelegate.display
        alignment: Qt.AlignLeft

        icon: itemDelegate.icon
        text: itemDelegate.text
        font: itemDelegate.font
        color: itemDelegate.foregroundColor
    }

    background: Q.Rectangle {
        radius: C.Units.commonRadius
        color: itemDelegate.backgroundColor

        layer.enabled: itemDelegate.elevated
        layer.effect: Q.DropShadow {
            horizontalOffset: 2
            verticalOffset: 2
            spread: 0.2
            radius: 12
            samples: 17
            color: C.ColorScheme.primaryColor.shadow
        }

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: itemDelegate.fadeEffectColor
            controlIsHovered: itemDelegate.hovered
            controlIsDown: itemDelegate.down
            controlIsHighlighted: itemDelegate.highlighted
        }
    }

    states: Q.State {
        name: "down"
        when: itemDelegate.hovered && !itemDelegate.highlighted

        Q.PropertyChanges {
            target: itemDelegate
            foregroundColor: C.ColorScheme.secondaryColor.regular
        }
    }

    transitions: Q.Transition {
        to: "down"
        reversible: true

        Q.ColorAnimation {
            target: itemDelegate
            property: "foregroundColor"
            duration: 300
        }
    }
}
