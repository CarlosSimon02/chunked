import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Controls.Material.impl
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects

import components as Comp

T.ComboBox {
    id: comboBox

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    leftPadding: 15
    rightPadding: 15
    topPadding: 14
    bottomPadding: 14

    delegate: Comp.ItemDelegate {
        width: ListView.view.width
        height: 40
        text: comboBox.textRole ? (Array.isArray(comboBox.model) ? modelData[comboBox.textRole] : model[comboBox.textRole]) : modelData
        highlighted: text === comboBox.displayText
    }

    indicator: ColorImage {
        x: comboBox.mirrored ? comboBox.padding : comboBox.width - width - comboBox.padding
        y: comboBox.height / 2 - 10
        color: Comp.ColorScheme.secondaryColor.dark
        source: "qrc:/qt-project.org/imports/QtQuick/Controls/Material/images/drop-indicator.png"
    }

    contentItem: T.TextField {
        text: comboBox.editable ? comboBox.editText : comboBox.displayText

        enabled: comboBox.editable
        autoScroll: comboBox.editable
        readOnly: comboBox.down
        inputMethodHints: comboBox.inputMethodHints
        validator: comboBox.validator
        selectByMouse: comboBox.selectTextByMouse

        color: Comp.ColorScheme.secondaryColor.regular
        verticalAlignment: Text.AlignVCenter

        cursorDelegate: CursorDelegate {}
    }

    background: Rectangle {
        implicitHeight: 50
        color: "transparent"
        border.width: 1.5
        border.color: comboBox.activeFocus ? Comp.ColorScheme.accentColor.regular :
                                             Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Units.commonRadius
    }

    popup: Comp.Popup {
        y: comboBox.height
        width: comboBox.width
        height: Math.min(contentItem.implicitHeight + verticalPadding * 2, comboBox.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top
        topMargin: 12
        bottomMargin: 12
        padding: 10

        enter: Transition {
            NumberAnimation { property: "scale"; from: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            NumberAnimation { property: "scale"; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        contentItem: ListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            model: comboBox.delegateModel
            currentIndex: comboBox.highlightedIndex
            highlightMoveDuration: 0
        }
    }
}
