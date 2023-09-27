import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

ListView {
    spacing: 5
    currentIndex: 0

    delegate: RowLayout {
        id: rowLayout
        required property string modelData
        required property int index
        property bool done: index === 0

        ColumnLayout {
            spacing: 5

            Rectangle {
                Layout.preferredHeight: 50
                Layout.preferredWidth: 1
                Layout.alignment: Qt.AlignHCenter
                color: Comp.Globals.color.secondary.shade1
                visible: index !== 0
            }

            Label {
                id: label
                Layout.preferredWidth: 25
                Layout.preferredHeight: 25
                text: rowLayout.ListView.isCurrentItem ? (index + 1) :
                        rowLayout.done ? "✓" : (index + 1)
                font.pixelSize: Comp.Globals.fontSize.small
                color: Comp.Globals.color.secondary.shade3
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                background: Rectangle {
                    color: rowLayout.ListView.isCurrentItem ? Comp.Globals.color.accent.shade1 :
                                                              rowLayout.done ? Comp.Globals.color.accent.shade1 :
                                                                               Comp.Globals.color.primary.shade3
                    radius: width / 2
                }
            }
        }

        Text {
            text: modelData
            Layout.preferredHeight: label.height
            Layout.alignment: Qt.AlignBottom
            font.pixelSize: Comp.Globals.fontSize.small
            color: rowLayout.ListView.isCurrentItem ? Comp.Globals.color.secondary.shade3 :
                                                      rowLayout.done ? Comp.Globals.color.secondary.shade3 :
                                                                       Comp.Globals.color.secondary.shade1
            verticalAlignment: Label.AlignVCenter
        }
    }
}
