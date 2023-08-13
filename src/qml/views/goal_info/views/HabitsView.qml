import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: scrollView

    ListView {
        id: listView
        width: scrollView.availableWidth

        delegate: RowLayout {
            width: parent.width

            Text {
                Layout.preferredWidth: 250
                Layout.fillHeight: true
                text: model.title
            }

            ListView {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                orientation: ListView.Horizontal
                layoutDirection: Qt.RightToLeft
                spacing: 20

                delegate: ColumnLayout {
                    Text {
                        text: model.index
                    }

                    CheckBox {}
                }

                model: 100
            }
        }

        model: ListModel {
            ListElement {
                title: "Meditate everyday"
            }

            ListElement {
                title: "Drink eight glass of water everyday"
            }
        }
    }
}
