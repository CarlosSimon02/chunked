import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp
import commonViews as View

Comp.Page {
    signal goalAdded
    topPadding: -pageHeader.bottomPadding

    header: Comp.PageHeader {
        id: pageHeader
        height: 90

        Comp.Text {
            text: "Goals"
            font.weight: Font.Bold
            font.pixelSize: 28
        }
    }

    View.GoalsBodyView {
        id: goalsBodyView
        anchors.fill: parent

        Connections {
            target: mainView.StackView
            function onActivating() {goalsBodyView.gridView.model.select()}
        }
    }
}

