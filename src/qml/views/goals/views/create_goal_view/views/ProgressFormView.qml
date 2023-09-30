import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "../components" as MComp

ScrollView {
    id: scrollView
    contentHeight: columnLayout.height
    signal checkError
    property bool hasError

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
                    text: "Progress Tracker"
                }

                MComp.ComboBox {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true

                    model: [
                        "Subgoals(Total Progress)",
                        "Subgoals(Completed)",
                        "Tasks(Total Outcome)",
                        "Tasks(Completed)",
                        "Habits(Total Progress)",
                        "Habits(Completed)",
                        "Manual Update"
                    ]

                    onActivated: index => {
                        progressValue.enabled = false
                        targetValue.enabled = false
                        progressValue.text = 0
                        targetValue.text = 0

                        switch(index) {
                            case 0: unit.text = "goals' progress"; break;
                            case 1: unit.text = "goals"; break;
                            case 2: unit.text = "outcomes"; break;
                            case 3: unit.text = "tasks"; break;
                            case 4: unit.text = "habits' progress"; break;
                            case 5: unit.text = "habits"; break;
                            case 6:
                            unit.text = "";
                            progressValue.enabled = true
                            targetValue.enabled = true
                            break;
                        }
                    }
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Unit"
                }

                Comp.TextField {
                    id: unit
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    text: "goals' progress"

                    onTextChanged: hasError = false

                    Connections {
                        target: scrollView
                        function onCheckError() {
                            if(unit.length <= 0) {
                                scrollView.hasError = true
                                unit.hasError = true
                                unitError.text = "This field is required and cannot be empty"
                                scrollView.ScrollBar.vertical.position = 0.0
                            }
                            else {
                                scrollView.hasError = false
                            }
                        }
                    }
                }

                Text {
                    id: unitError
                    visible: unit.hasError
                    verticalAlignment: Text.AlignBottom
                    color: "red"
                    font.pixelSize: Comp.Globals.fontSize.small
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Progress Value"
                }

                TextField {
                    id: progressValue
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    enabled: false
                    text: "0"
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Target Value"
                }

                TextField {
                    id: targetValue
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    enabled: false
                    text: "0"
                }
            }
        }
    }
}
