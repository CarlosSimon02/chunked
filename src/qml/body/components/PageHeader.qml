import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 

import components as Comp

Comp.Pane {
    id: pane
    implicitHeight: 140
    padding: 20
    bottomPadding: 12

    background: Item {
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: -1 * Comp.Units.commonRadius

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: pane.backgroundColor
                    radius: Comp.Units.commonRadius
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Comp.Units.commonRadius
                    color: pane.backgroundColor
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: pane.bottomPadding
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#AA080808" }
                    GradientStop { position: 0.5; color: "#00080808" }

                }
            }
        }
    }
}
