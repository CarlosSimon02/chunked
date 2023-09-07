import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import components as Comp
import components.impl as Impl

T.SpinBox {
    id: control

    // Note: the width of the indicators are calculated into the padding
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             up.implicitIndicatorHeight, down.implicitIndicatorHeight)

    leftPadding: 15
    rightPadding: padding + (control.mirrored ? (down.indicator ? down.indicator.width + 4 : 0) : (up.indicator ? up.indicator.width : 0))

    editable: true

    from: 0
    to: 999999999

    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        z: 2
        text: control.displayText
        clip: width < implicitWidth

        font: control.font
        color: Comp.ColorScheme.secondaryColor.regular
        selectionColor: control.palette.highlight
        selectedTextColor: control.palette.highlightedText
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    up.indicator: Rectangle {
        x: control.mirrored ? 0 : control.width - width - 4
        y: 4
        height: control.height/2 - 4
        implicitWidth: 40
        implicitHeight: 20
        radius: Comp.Consts.commonRadius
        color: "transparent"

        ColorImage {
            anchors.centerIn: parent
            sourceSize.width: 10
            sourceSize.height: 10
            color: enabled ? Comp.ColorScheme.secondaryColor.regular : Comp.ColorScheme.secondaryColor.veryDark
            source: "qrc:/arrow_down_icon.svg"
            mirrorVertically: true
        }

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: Comp.ColorScheme.secondaryColor.regular
            controlIsHovered: control.up.hovered
            controlIsDown: control.up.pressed
            controlIsHighlighted: false
            controlIsEnabled: enabled
        }
    }

    down.indicator: Rectangle {
        x: control.mirrored ? 0 : control.width - width - 4
        y: control.up.indicator.y + control.up.indicator.height
        height: control.height/2 - 4
        implicitWidth: 40
        implicitHeight: 20
        radius: Comp.Consts.commonRadius
        color: "transparent"

        ColorImage {
            anchors.centerIn: parent
            sourceSize.width: 10
            sourceSize.height: 10
            color: enabled ? Comp.ColorScheme.secondaryColor.regular : Comp.ColorScheme.secondaryColor.veryDark
            source: "qrc:/arrow_down_icon.svg"
        }

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: Comp.ColorScheme.secondaryColor.regular
            controlIsHovered: control.down.hovered
            controlIsDown: control.down.pressed
            controlIsHighlighted: false
            controlIsEnabled: enabled
        }
    }

    background: Rectangle {
        implicitHeight: 52
        implicitWidth: 140
        color: "transparent"
        border.width: 1
        border.color: control.activeFocus ? Comp.ColorScheme.accentColor.regular :
                Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Consts.commonRadius
    }
}
