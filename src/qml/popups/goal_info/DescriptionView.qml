import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: scrollView
    padding: 10
    contentWidth: availableWidth

    ColumnLayout {
        width: scrollView.availableWidth
        spacing: 30

        Repeater {
            ColumnLayout {
                Text {
                    Layout.fillWidth: true
                    text: model.label
                    font.pixelSize: 20
                    font.bold: true
                }

                Text {
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae tincidunt metus. Sed tincidunt justo nec justo pellentesque, non aliquet purus hendrerit. Vestibulum consectetur mi in velit interdum, sit amet feugiat enim bibendum. Fusce id erat non neque laoreet facilisis a at quam. Sed dictum lacus vel pharetra blandit. Nulla facilisi. Proin nec tortor eget sapien venenatis eleifend. Etiam non risus sed.

Integer tincidunt eget justo a posuere. Curabitur fermentum, orci eu sagittis sagittis, nisl libero condimentum dolor, nec pellentesque nulla nulla vitae velit. Integer eleifend non lorem eget feugiat. Pellentesque pulvinar non nunc nec pharetra. Nunc tincidunt nulla vel mi interdum, sit amet volutpat ligula suscipit. In tempor, orci at posuere vestibulum, risus ex vehicula nunc, sit amet dictum eros est nec libero. In hac habitasse platea dictumst. Mauris consectetur dui at mi pellentesque, vitae fringilla libero eleifend."
                }
            }

            model: ListModel {
                ListElement {
                    label: "Mission"
                }

                ListElement {
                    label: "Vision"
                }

                ListElement {
                    label: "Obstacles"
                }

                ListElement {
                    label: "Resources"
                }
            }
        }
    }
}
