import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import components as Comp

RowLayout {
    id: columnLayout
    spacing: -(buttonLayout.width + 15)
    signal save

    Comp.TextField {
        id: textArea
        Layout.fillWidth: true
        rightPadding: 80
        placeholderText: "Type your task here and press 'Enter' to save"
        wrapMode: TextArea.NoWrap
        property Task task: Task{}

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
                task.name = textArea.text
                dbAccess.saveTaskItem(task)
                columnLayout.save()
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

                ColumnLayout {
                    spacing: 25
                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Done"
                        }

                        Comp.CheckBox {}
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Actual Duration"
                        }

                        Comp.TextArea {
                            Layout.preferredWidth: 200
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Outcome"
                        }

                        Comp.TextArea {
                            Layout.preferredWidth: 200
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Notes"
                        }

                        Comp.TextArea {
                            Layout.preferredWidth: 200
                        }
                    }

                    Comp.FieldColumnLayout {
                        Comp.FieldLabel {
                            text: "Parent Goal"
                        }

                        Comp.TextArea {
                            Layout.preferredWidth: 200
                        }
                    }
                }
            }
        }
    }
}
