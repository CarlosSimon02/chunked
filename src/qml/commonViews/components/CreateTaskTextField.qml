import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp

RowLayout {
    id: columnLayout
    spacing: -(buttonLayout.width + 15)
    property Task task: Task{}
    signal save

    Comp.TextField {
        id: textArea
        Layout.fillWidth: true
        rightPadding: 100
        placeholderText: "Type your task here and press 'Enter' to save"
        wrapMode: TextArea.NoWrap

        background: Rectangle {
            implicitHeight: 52
            color: "transparent"
            border.width: 1
            border.color: textArea.activeFocus ? Comp.ColorScheme.accentColor.regular :
                                                 Comp.ColorScheme.secondaryColor.dark
            radius: Comp.Consts.commonRadius

        }

        Keys.onReturnPressed: {
            if (textArea.length > 0)
            {
                columnLayout.task.name = textArea.text
                columnLayout.task.startDateTime = dateTimeFramePicker.startDateTimeText
                columnLayout.task.endDateTime = dateTimeFramePicker.endDateTimeText
                columnLayout.task.done = doneCheckBox.checked
                columnLayout.task.actualDuration = parseInt(actualDurationTextArea.text)
                columnLayout.task.outcome = parseInt(outcomeTextArea.text)
                columnLayout.task.notes = notesTextArea.text
                dbAccess.saveTaskItem(columnLayout.task)
                columnLayout.save()

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

                function reset() {
                    doneCheckBox.checked = false
                    actualDurationTextArea.text = "0"
                    outcomeTextArea.text = "1"
                    notesTextArea.text = ""
                }

                ColumnLayout {
                    spacing: 25
                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Done"
                        }

                        Comp.CheckBox {
                            id: doneCheckBox
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Actual Duration"
                        }

                        Comp.TextArea {
                            id: actualDurationTextArea
                            Layout.preferredWidth: 200
                            text: "0"
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Outcome"
                        }

                        Comp.TextArea {
                            id: outcomeTextArea
                            Layout.preferredWidth: 200
                            text: "1"
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Notes"
                        }

                        Comp.TextArea {
                            id: notesTextArea
                            Layout.preferredWidth: 200
                        }
                    }
                }
            }
        }
    }
}
