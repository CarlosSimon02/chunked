import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../components" as MComp

ScrollView {
    id: scrollView

    property alias mission: mission.text
    property alias vision: vision.text
    property alias obstacles: obstacles.text
    property alias resources: resources.text

    contentHeight: columnLayout.height

    MouseArea {
        width: scrollView.width
        height: scrollView.height
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
                    id: mission
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
                    id: vision
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
                    id: obstacles
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
                    id: resources
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                    wrapMode: TextArea.Wrap
                }
            }
        }
    }
}
