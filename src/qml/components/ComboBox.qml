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

    leftPadding: iconSource ? iconLabel.width + 8 : 15
    rightPadding: 15

    property alias iconSource: iconLabel.icon.source

    IconLabel {
        id: iconLabel
        height: parent.height
        leftPadding: 15
        icon.width: 20
        icon.height: 20
        icon.color: Comp.ColorScheme.secondaryColor.veryDark
        display: IconLabel.IconOnly
    }

    delegate: Comp.ItemDelegate {
        width: ListView.view.width
        height: 40

        text: comboBox.textRole ?
                  Array.isArray(comboBox.model) ?
                      modelData[comboBox.textRole] :
                      model[comboBox.textRole] :
                  modelData

        highlighted: text === comboBox.displayText
    }

    indicator: ColorImage {
        x: comboBox.mirrored ?
               comboBox.padding :
               comboBox.width - width - comboBox.padding
        y: comboBox.height / 2 - 10

        color: Comp.ColorScheme.secondaryColor.dark
        source: "qrc:/arrow_down_icon.svg"
    }

    contentItem: T.TextField {
        text: comboBox.editable ? comboBox.editText : comboBox.displayText
        enabled: comboBox.editable
        autoScroll: comboBox.editable
        readOnly: comboBox.down
        inputMethodHints: comboBox.inputMethodHints
        validator: comboBox.validator
        selectByMouse: comboBox.selectTextByMouse
        color: comboBox.enabled ?
                   Comp.ColorScheme.secondaryColor.regular :
                   Comp.ColorScheme.secondaryColor.dark
        verticalAlignment: Text.AlignVCenter

        cursorDelegate: CursorDelegate {}
    }

    background: Rectangle {
        implicitHeight: 52

        color: "transparent"
        border.width: 1
        border.color: comboBox.activeFocus ? Comp.ColorScheme.accentColor.regular :
                                             Comp.ColorScheme.secondaryColor.dark
        radius: Comp.Consts.commonRadius
    }

    popup: Comp.Popup {
        y: comboBox.height
        width: comboBox.width
        height: Math.min(contentItem.implicitHeight + verticalPadding * 2, comboBox.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top

        enter: Transition {
            NumberAnimation { property: "scale"; from: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; from: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        exit: Transition {
            NumberAnimation { property: "scale"; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { property: "opacity"; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
        }

        contentItem: Comp.ListView {
            id: listView
            implicitHeight: contentHeight

            clip: true
            model: comboBox.delegateModel
            currentIndex: comboBox.highlightedIndex
            highlightMoveDuration: 0
            interactive: true
        }
    }
}
