import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import views.habits_body

Comp.StackPageView {
    id: stackPageView

    initialItem: Comp.PageView {
        id: habitsPageView
        title: "Habits"

        headerOptions: Component {
            RowLayout {
                Comp.IconButton {
                    icon.source: "qrc:/three_dots_icon.svg"
                    rotation: 90
                }
            }
        }

        HabitsBodyView {
            id: habitsBodyView
            anchors.fill: parent

            verticalScrollBar: ScrollBar {
                parent: habitsPageView
                x: habitsPageView.width - width
                y: habitsPageView.header.height
                height: habitsPageView.availableHeight - habitsPageView.header.height
            }
        }
    }
}
