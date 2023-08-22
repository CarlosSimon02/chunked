import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Comp.Page {
    signal goalAdded
    topPadding: -pageHeader.bottomPadding

    header: Comp.PageHeader {
        id: pageHeader
        height: 90

        Comp.Text {
            text: "Tasks"
            font.weight: Font.Bold
            font.pixelSize: 28
        }
    }

    Comp.ScrollView {
        id: scrollView
        anchors.fill: parent

        ColumnLayout {
            width: scrollView.availableWidth

            Comp.TextArea {
                Layout.preferredWidth: 700
                Layout.topMargin: 20
                Layout.alignment: Qt.AlignCenter
            }
        }
    }

}
