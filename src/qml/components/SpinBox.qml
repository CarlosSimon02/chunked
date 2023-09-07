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

    leftPadding: padding + (control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0))
    rightPadding: padding + (control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0))

    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        z: 2
        text: control.displayText
        clip: width < implicitWidth
        padding: 6

        font: control.font
        color: control.palette.text
        selectionColor: control.palette.highlight
        selectedTextColor: control.palette.highlightedText
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints

        Rectangle {
            width: parent.width
            height: parent.height
            visible: control.activeFocus
            color: "transparent"
            border.color: control.palette.highlight
            border.width: 2
        }
    }

    up.indicator: Rectangle {
        x: control.mirrored ? 0 : control.width - width
        height: control.height
        implicitWidth: 40
        implicitHeight: 40
        radius: Comp.Consts.commonRadius
        color: "transparent"

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: Comp.ColorScheme.secondaryColor.regular
            controlIsHovered: control.down.hovered
            controlIsDown: control.down.pressed
            controlIsHighlighted: false
            controlIsEnabled: enabled
        }
    }

    down.indicator: Rectangle {
        x: control.mirrored ? parent.width - width : 0
        height: control.height
        implicitWidth: 40
        implicitHeight: 40
        radius: Comp.Consts.commonRadius
        color: "transparent"

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: Comp.ColorScheme.secondaryColor.regular
            controlIsHovered: control.up.hovered
            controlIsDown: control.up.pressed
            controlIsHighlighted: false
            controlIsEnabled: enabled
        }
    }

    background: Rectangle {
        implicitWidth: 140
        color: enabled ? control.palette.base : control.palette.button
        border.color: control.palette.button
    }
}
