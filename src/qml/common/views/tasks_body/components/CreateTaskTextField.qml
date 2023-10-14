import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp
import components.buttons as Btn
import components.inputs as Inpt

Inpt.BasicTextField {
    id: textField

    property Task task: Task{}
    signal save

    implicitHeight: 45
    placeholderText: "Type your task here and press 'Enter' to save"

    Keys.onReturnPressed: {
        if (textField.length > 0)
        {
            textField.task.name = textField.text
            textField.task.startDateTime = dateTimeFramePicker.startDateTimeText
            textField.task.endDateTime = dateTimeFramePicker.endDateTimeText
            textField.task.actualDuration = actualDurationSpinBox.value
            textField.task.outcome = outcomeSpinBox.value
            textField.task.notes = notesTextArea.text
            textField.save()

            textField.text = ""
            dateTimeFramePicker.reset()
            taskDetailsPopup.reset()
        }
    }
}
