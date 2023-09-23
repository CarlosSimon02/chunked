import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import commonViews as View

Comp.PageView {
    signal goalAdded

    View.GoalsBodyView {
        id: goalsBodyView
        anchors.fill: parent

        Connections {
            target: mainLoader.StackView
            function onActivating() {goalsBodyView.refresh()}
        }
    }
}

