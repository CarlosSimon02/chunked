import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp

Comp.PageView {
    title: "Home"

    RowLayout {
        anchors.fill: parent

        ListView {
            Layout.fillHeight: true
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        ListView {
            Layout.fillHeight: true
        }
    }
}
