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
                    text: "Mission"
                }

                TextField {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                    wrapMode: TextArea.Wrap
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Vision"
                }

                TextArea {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                    wrapMode: TextArea.Wrap
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Obstacles"
                }

                TextArea {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                    wrapMode: TextArea.Wrap
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Purposes"
                }

                TextArea {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                    wrapMode: TextArea.Wrap
                }
            }
        }
    }
}
