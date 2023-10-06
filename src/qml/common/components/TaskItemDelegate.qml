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
    required property string date

    contentItem: RowLayout {
        spacing: 20

        RowLayout {
            CheckBox {
                id: checkBox
            }

            //visible only if tracker is outcome base
            Label {
                Layout.preferredHeight: 30
                Layout.preferredWidth: 30
                text: "1"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                background: Rectangle {
                    color: Comp.Globals.color.primary.shade2
                    radius: Material.SmallScale
                }
            }

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
            Text {
                text: "1h 40m remaining"
                font.pixelSize: Comp.Globals.fontSize.small
                color: "green"
                visible: control.width > 600
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
