import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: scrollView
    //this view should contain multiple types of view like board view and list view


    ListView {
        width: scrollView.availableWidth
        height: contentHeight
        spacing: 30
        delegate: ColumnLayout {
            CheckBox {
                text: model.taskName
                checkState: model.done ? Qt.Checked : Qt.Unchecked
            }

            RowLayout {
                Layout.preferredWidth: 100
                Text {
                    text: "Start"
                }

                Text {
                    text: model.start
                }
            }

            RowLayout {
                Layout.preferredWidth: 100
                Text {
                    text: "Due"
                }

                Text {
                    text: model.due
                }
            }

            RowLayout {
                Layout.preferredWidth: 100
                Text {
                    text: "Status"
                }

                Text {
                    text: model.status
                }
            }

            RowLayout {
                Layout.preferredWidth: 100
                Text {
                    text: "Outcome"
                }

                Text {
                    text: model.outcome
                }
            }
        }

        model: ListModel {
            ListElement {
                taskName: "What is your task"
                done: false
                start: "20 Sep 2023 5:30 PM"
                due: "21 Sep 2023 5:30 PM"
                status: "in progress"
                outcome: 30
            }

            ListElement {
                taskName: "What is your task"
                done: true
                start: "20 Sep 2023 5:30 PM"
                due: "21 Sep 2023 5:30 PM"
                status: "incomplete"
                outcome: 50
            }
        }
    }
}
