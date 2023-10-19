import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.inputs as Inpt
import "../components" as MComp

ScrollView {
    id: scrollView

    property alias trackerType: trackerType.currentIndex
    property alias unit: unit.text
    property alias progressValue: progressValue.value
    property alias targetValue: targetValue.value
    property bool hasError
    signal checkError

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
                    text: "Progress Tracker"
                }

                Inpt.ComboBox {
                    id: trackerType
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true

                    model: Comp.Globals.trackerTypes

                    onActivated: index => {
                        switch(index) {
                            case 0: unit.text = "goals' progress"; break;
                            case 1: unit.text = "goals"; break;
                            case 2: unit.text = "outcomes"; break;
                            case 3: unit.text = "tasks"; break;
                            case 4: unit.text = "habits' progress"; break;
                            case 5: unit.text = "habits"; break;
                            case 6: unit.text = ""; break;
                        }
                    }
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Unit"
                }

                Inpt.TextField {
                    id: unit
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    text: "goals' progress"

                    onTextChanged: {
                        hasError = false
                        scrollView.hasError = false
                    }

                    Connections {
                        target: scrollView
                        function onCheckError() {
                            if(unit.length <= 0) {
                                scrollView.hasError = true
                                unit.hasError = true
                                unitError.text = "This field is required and cannot be empty"
                                scrollView.ScrollBar.vertical.position = 0.0
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

                Inpt.SpinBox {
                    id: progressValue
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    enabled: trackerType.currentIndex === 6
                    editable: true
                    value: 0
                    from: 0
                    to: 999999

                    onDisplayTextChanged: {
                        hasError = false
                        scrollView.hasError = false
                    }

                    Connections {
                        target: scrollView
                        function onCheckError() {
                            if(progressValue.value > targetValue.value) {
                                scrollView.hasError = true
                                progressValue.hasError = true
                                progressValueError.text = "Value cannot be higher than target value"
                                scrollView.ScrollBar.vertical.position = 0.0
                            }
                        }
                    }
                }

                Text {
                    id: progressValueError
                    visible: progressValue.hasError
                    verticalAlignment: Text.AlignBottom
                    color: "red"
                    font.pixelSize: Comp.Globals.fontSize.small
                }
            }

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Target Value"
                }

                SpinBox {
                    id: targetValue
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    enabled: trackerType.currentIndex === 6
                    editable: true
                    value: 0
                    from: 0
                    to: 999999
                }
            }
        }
    }
}
