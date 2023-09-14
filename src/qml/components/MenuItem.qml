import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import components as Comp
import components.impl as Impl

T.MenuItem {
    id: menuItem

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    verticalPadding: 0
    horizontalPadding: 8
    spacing: 10

    icon.width: 24
    icon.height: 24
    icon.color: foregroundColor
    font.pixelSize: 14

    property color foregroundColor: enabled ?
                                        highlighted ? Comp.ColorScheme.accentColor.regular :
                                                      Comp.ColorScheme.secondaryColor.regular :
                                        Comp.ColorScheme.secondaryColor.veryDark

    property color backgroundColor: "transparent"
    property color fadeEffectColor: Comp.ColorScheme.secondaryColor.regular
    property bool elevated: false
    property alias border: rectangle.border

    contentItem: IconLabel {
        readonly property real arrowPadding: menuItem.subMenu && menuItem.arrow ? menuItem.arrow.width + menuItem.spacing : 0
        readonly property real indicatorPadding: menuItem.checkable && menuItem.indicator ? menuItem.indicator.width + menuItem.spacing : 0
        leftPadding: !menuItem.mirrored ? indicatorPadding : arrowPadding
        rightPadding: menuItem.mirrored ? indicatorPadding : arrowPadding
        spacing: menuItem.spacing
        mirrored: menuItem.mirrored
        display: menuItem.display
        alignment: Qt.AlignCenter

        icon: menuItem.icon
        text: menuItem.text
        font: menuItem.font
        color: menuItem.foregroundColor
    }

    indicator: ColorImage {
        x: menuItem.mirrored ? menuItem.width - width - menuItem.rightPadding : menuItem.leftPadding
        y: menuItem.topPadding + (menuItem.availableHeight - height) / 2

        visible: menuItem.checked
        source: menuItem.checkable ? "qrc:/qt-project.org/imports/QtQuick/Controls/Basic/images/check.png" : ""
        color: menuItem.palette.windowText
        defaultColor: "#353637"
    }

    arrow: ColorImage {
        x: menuItem.mirrored ? menuItem.leftPadding : menuItem.width - width - menuItem.rightPadding
        y: menuItem.topPadding + (menuItem.availableHeight - height) / 2

        visible: menuItem.subMenu
        mirror: menuItem.mirrored
        source: menuItem.subMenu ? "qrc:/qt-project.org/imports/QtQuick/Controls/Basic/images/arrow-indicator.png" : ""
        color: menuItem.palette.windowText
        defaultColor: "#353637"
    }

    background: Rectangle {
        id: rectangle
        implicitWidth: 200
        implicitHeight: 40
        radius: Comp.Consts.commonRadius
        color: menuItem.backgroundColor
        border.color: menuItem.foregroundColor
        border.width: 0

        layer.enabled: menuItem.elevated
        layer.effect: Impl.DropShadow {}

        Impl.FadeEffect {
            anchors.fill: parent
            colorEffect: menuItem.fadeEffectColor
            controlIsHovered: menuItem.hovered
            controlIsDown: menuItem.down
            controlIsHighlighted: menuItem.highlighted
            controlIsEnabled: menuItem.enabled
        }
    }
}
