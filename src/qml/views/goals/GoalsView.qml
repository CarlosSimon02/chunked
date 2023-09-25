import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.StackPageView {
    id: stackView

    initialItem: Comp.PageView {
        Button {
            text: "push item "
            onClicked: stackView.push(sampleItem)
        }

        Component {
            id: sampleItem

            Comp.PageView {
                isInitItem: false
            }
        }
    }
}



