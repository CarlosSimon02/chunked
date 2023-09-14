import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import components as Comp
import components.impl as Impl

T.Menu {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 0
    overlap: 1

    delegate: MenuItem { }

    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: Window.window
                        ? contentHeight + control.topPadding + control.bottomPadding > Window.window.height
                        : false
        clip: true
        currentIndex: control.currentIndex

//        ScrollIndicator.vertical: ScrollIndicator {}
    }

    background: Rectangle {
        implicitWidth: 220
        implicitHeight: 40
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius
        layer.enabled: true
        layer.effect: Impl.DropShadow {}
    }

    T.Overlay.modal: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.12)
    }
}
