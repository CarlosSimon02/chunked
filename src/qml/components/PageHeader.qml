import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Pane {
    id: pane
    padding: 20
    bottomPadding: 12

    background: Item {
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: -Comp.Units.commonRadius

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: Comp.Units.commonRadius
                    color: Comp.ColorScheme.primaryColor.light
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Comp.Units.commonRadius
                    color: Comp.ColorScheme.primaryColor.light
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
