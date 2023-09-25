import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

StackView {
    id: stackView
    clip: true

    pushEnter: Transition {
        PropertyAnimation {
            property: "x"
            from: window.width
            duration: 200
        }
    }

    pushExit: Transition {
        PropertyAnimation {
            property: "x"
            to: -100
            duration: 200
        }
    }

    popEnter: Transition {
        PropertyAnimation {
            property: "x"
            from: -100
            duration: 200
        }
    }

    popExit: Transition {
        PropertyAnimation {
            property: "x"
            to: window.width
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



