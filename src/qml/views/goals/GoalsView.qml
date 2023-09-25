import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

StackView {
    id: stackView
//    clip: true

    pushEnter: Transition {
        PropertyAnimation {
            property: "x"
            from: window.width
            duration: 200
        }
    }

    pushExit: Transition {
        PropertyAnimation {
            property: "opacity"
            to: 0.2
            duration: 200
        }
    }

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



