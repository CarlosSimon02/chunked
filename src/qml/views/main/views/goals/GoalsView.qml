import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import commonViews as View

Comp.Page {
    signal goalAdded

    View.GoalsBodyView {
        id: goalsBodyView
        anchors.fill: parent

        Connections {
            target: mainView.StackView
            function onActivating() {goalsBodyView.refresh()}
        }
    }
}

