import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./views"

Comp.PageView {
    title: "Goal Info"

    isInitItem: false

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20

        layer.enabled: true
        layer.samples: 4

        DetailsView {
            Layout.preferredWidth: 350
            Layout.fillHeight: true
        }
    }
}
