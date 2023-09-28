import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../components" as MComp

ScrollView {
    id: scrollView
    contentHeight: columnLayout.height

    MouseArea {
        anchors.fill: parent
        onClicked: { scrollView.focus = false}
    }

    ColumnLayout {
        id: columnLayout
        width: scrollView.width

        ColumnLayout {
            Layout.margins: 30
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Progress Tracker"
                }

                TextField {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Unit"
                }

                TextField {
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Progress Value"
                }

                TextField {
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Target Progress Value"
                }

                TextField {
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                }
            }
        }
    }
}
