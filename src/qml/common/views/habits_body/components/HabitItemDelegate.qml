import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import components as Comp

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    horizontalPadding: 10
    verticalPadding: text.lineCount > 1 ? 5 : 0

    property bool isSubGoal: false
    property bool hasImage: true

    contentItem: RowLayout {
        spacing: 20

        RowLayout {
            Text {
                id: text
                Layout.fillWidth: true
                text: "This is my sample task dojsof jdjf f f jfja jfja jfjf jkjfj kj"
                maximumLineCount: 2
                color: Comp.Globals.color.secondary.shade3
                elide: Text.ElideRight
                font.pixelSize: Comp.Globals.fontSize.medium
                wrapMode: Text.Wrap
            }
        }

        RowLayout {
            RowLayout {
                spacing: -8

                Repeater {
                    delegate: CheckBox {

                    }

                    model: 7
                }
            }

            IconLabel {
                icon.source: "qrc:/three_dots_icon.svg"
                icon.width: 18
                icon.height: 18
                icon.color: Comp.Globals.color.secondary.shade2
            }
        }
    }

    background: Rectangle {
        radius: Material.SmallScale
        color: Comp.Globals.color.primary.shade3

        Rectangle {
            width: parent.width
            height: parent.height
            radius: parent.radius
            visible: enabled && (control.hovered || control.visualFocus)
            color: control.Material.rippleColor
        }

        Rectangle {
            width: parent.width
            height: parent.height
            radius: parent.radius
            visible: control.down
            color: control.Material.rippleColor
        }
    }
}
