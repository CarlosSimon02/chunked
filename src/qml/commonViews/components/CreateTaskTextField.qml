import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp

RowLayout {
    id: rowLayout
    spacing: -(buttonLayout.width + 15)
    property Task task: Task{}
    signal save

    Comp.TextField {
        id: textArea
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        rightPadding: 100
        placeholderText: "Type your task here and press 'Enter' to save"
        wrapMode: TextArea.NoWrap

        background: Rectangle {
            implicitHeight: 52
            color: Comp.ColorScheme.primaryColor.dark
            radius: Comp.Consts.commonRadius
        }

        Keys.onReturnPressed: {
            if (textArea.length > 0)
            {
                rowLayout.task.name = textArea.text
                rowLayout.task.startDateTime = dateTimeFramePicker.startDateTimeText
                rowLayout.task.endDateTime = dateTimeFramePicker.endDateTimeText
                rowLayout.task.actualDuration = actualDurationSpinBox.value
                rowLayout.task.outcome = outcomeSpinBox.value
                rowLayout.task.notes = notesTextArea.text
                rowLayout.save()

                textArea.text = ""
                dateTimeFramePicker.reset()
                taskDetailsPopup.reset()
            }
        }
    }

    RowLayout {
        id: buttonLayout
        Layout.rightMargin: 15
        spacing: 0

        Comp.Button {
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            icon.source: "qrc:/calendar_icon.svg"
            icon.width: 20
            icon.height: 20
            onClicked: dateTimeFramePickerPopup.open()

            Comp.Popup {
                id: dateTimeFramePickerPopup
                x: parent.width - width
                padding: 25

                Comp.DateTimeFramePicker {
                    id: dateTimeFramePicker
                }
            }
        }

        Comp.Button {
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            icon.source: "qrc:/arrow_down_icon.svg"
            icon.width: 12
            icon.height: 12
            onClicked: taskDetailsPopup.open()

            Comp.Popup {
                id: taskDetailsPopup
                x: parent.width - width
                padding: 0

                function reset() {
                    actualDurationSpinBox.value = 0
                    outcomeSpinBox.value = 1
                    notesTextArea.text = ""
                }

                Comp.Pane {
                    padding: 20

                    ColumnLayout {
                        spacing: 25

                        Comp.FieldColumnLayout {
                            Comp.FieldLabel {
                                text: "Outcome"
                            }

                            Comp.SpinBox {
                                id: outcomeSpinBox
                                Layout.preferredWidth: 200
                                value: 1
                            }
                        }

                        Comp.FieldColumnLayout {
                            Comp.FieldLabel {
                                text: "Actual Duration (in minutes)"
                            }

                            Comp.SpinBox {
                                id: actualDurationSpinBox
                                Layout.preferredWidth: 200
                            }
                        }

                        Comp.FieldColumnLayout {
                            Comp.FieldLabel {
                                text: "Notes"
                            }

                            Comp.TextArea {
                                id: notesTextArea
                                Layout.preferredWidth: 400
                                Layout.preferredHeight: 104
                            }
                        }
                    }
                }
            }
        }
    }
}
