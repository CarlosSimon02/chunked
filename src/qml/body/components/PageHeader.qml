import QtQuick as Q
import QtQuick.Controls as Q
import QtQuick.Layouts as Q

import components as C

C.Pane {
    id: pane
    implicitHeight: 140
    padding: 20
    bottomPadding: 12

    background: Q.Item {
        Q.ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Q.ColumnLayout {
                Q.Layout.fillWidth: true
                Q.Layout.fillHeight: true
                spacing: -1 * C.Units.commonRadius

                Q.Rectangle {
                    Q.Layout.fillWidth: true
                    Q.Layout.fillHeight: true
                    color: pane.backgroundColor
                    radius: C.Units.commonRadius
                }

                Q.Rectangle {
                    Q.Layout.fillWidth: true
                    Q.Layout.preferredHeight: C.Units.commonRadius
                    color: pane.backgroundColor
                }
            }

            Q.Rectangle {
                Q.Layout.fillWidth: true
                Q.Layout.preferredHeight: pane.bottomPadding
                gradient: Q.Gradient {
                    Q.GradientStop { position: 0.0; color: "#AA080808" }
                    Q.GradientStop { position: 0.5; color: "#00080808" }

                }
            }
        }
    }
}
