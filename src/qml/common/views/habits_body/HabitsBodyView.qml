import QtQuick
import QtQuick.Layouts

import "./components" as MComp

ColumnLayout {
    ListView {
        anchors.fill: parent
        spacing: 10

        delegate: MComp.HabitItemDelegate {
            width: ListView.view.width -
                   ListView.view.leftMargin -
                   ListView.view.rightMargin
        }

        model: 10
    }
}
