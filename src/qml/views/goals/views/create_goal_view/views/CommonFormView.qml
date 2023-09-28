import QtQuick
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts

import components as Comp
import "../components" as MComp

ScrollView {
    id: scrollView
    contentHeight: columnLayout.height
    signal checkError
    property bool hasError

    MouseArea {
        anchors.fill: parent
        onClicked: { scrollView.focus = false }
    }

    ColumnLayout {
        id: columnLayout
        width: scrollView.width

        ColumnLayout {
            Layout.margins: 30
            Layout.alignment: Qt.AlignHCenter
            spacing: 30

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Goal Name"
                }

                Comp.TextField {
                    id: goalName
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true

                    onTextChanged: hasError = false

                    Connections {
                        target: scrollView
                        function onCheckError() {
                            if(goalName.length <= 0) {
                                scrollView.hasError = true
                                goalName.hasError = true
                                goalNameError.text = "This field is required and cannot be empty"
                                scrollView.ScrollBar.vertical.position = 0.0
                            }
                            else {
                                scrollView.hasError = false
                            }
                        }
                    }
                }

                Text {
                    id: goalNameError
                    visible: goalName.hasError
                    verticalAlignment: Text.AlignBottom
                    color: "red"
                    font.pixelSize: Comp.Globals.fontSize.small
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Category"
                }

                MComp.ComboBox {
                    id: category
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                    model: ["Work", "Personal", "Home"]
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Image"
                }

                MComp.ImagePicker {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                }
            }
        }
    }
}
