import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: scrollView

    ListView {
        id: listView
        width: scrollView.availableWidth

        delegate: ColumnLayout {
            width: parent.width
            Text {
                text: model.date
            }

            Text {
                text: model.time
            }

            Text {
                Layout.fillWidth: true
                text: model.title
                wrapMode: Text.Wrap
            }

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                text: model.content
                wrapMode: Text.Wrap
                clip: true
                elide: Text.ElideRight
            }
        }

        model: ListModel {
            ListElement {
                date: "02 Sep 2023"
                time: "11:59 PM"
                title: "This is my title"
                content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae tincidunt metus. Sed tincidunt justo nec justo pellentesque, non aliquet purus hendrerit. Vestibulum consectetur mi in velit interdum, sit amet feugiat enim bibendum. Fusce id erat non neque laoreet facilisis a at quam. Sed dictum lacus vel pharetra blandit. Nulla facilisi. Proin nec tortor eget sapien venenatis eleifend. Etiam non risus sed.

Integer tincidunt eget justo a posuere. Curabitur fermentum, orci eu sagittis sagittis, nisl libero condimentum dolor, nec pellentesque nulla nulla vitae velit. Integer eleifend non lorem eget feugiat. Pellentesque pulvinar non nunc nec pharetra. Nunc tincidunt nulla vel mi interdum, sit amet volutpat ligula suscipit. In tempor, orci at posuere vestibulum, risus ex vehicula nunc, sit amet dictum eros est nec libero. In hac habitasse platea dictumst. Mauris consectetur dui at mi pellentesque, vitae fringilla libero eleifend."
            }

            ListElement {
                date: "02 Sep 2023"
                time: "11:59 PM"
                title: "This is my title"
                content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae tincidunt metus. Sed tincidunt justo nec justo pellentesque, non aliquet purus hendrerit. Vestibulum consectetur mi in velit interdum, sit amet feugiat enim bibendum. Fusce id erat non neque laoreet facilisis a at quam. Sed dictum lacus vel pharetra blandit. Nulla facilisi. Proin nec tortor eget sapien venenatis eleifend. Etiam non risus sed.

Integer tincidunt eget justo a posuere. Curabitur fermentum, orci eu sagittis sagittis, nisl libero condimentum dolor, nec pellentesque nulla nulla vitae velit. Integer eleifend non lorem eget feugiat. Pellentesque pulvinar non nunc nec pharetra. Nunc tincidunt nulla vel mi interdum, sit amet volutpat ligula suscipit. In tempor, orci at posuere vestibulum, risus ex vehicula nunc, sit amet dictum eros est nec libero. In hac habitasse platea dictumst. Mauris consectetur dui at mi pellentesque, vitae fringilla libero eleifend."
            }

            ListElement {
                date: "02 Sep 2023"
                time: "11:59 PM"
                title: "This is my title"
                content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae tincidunt metus. Sed tincidunt justo nec justo pellentesque, non aliquet purus hendrerit. Vestibulum consectetur mi in velit interdum, sit amet feugiat enim bibendum. Fusce id erat non neque laoreet facilisis a at quam. Sed dictum lacus vel pharetra blandit. Nulla facilisi. Proin nec tortor eget sapien venenatis eleifend. Etiam non risus sed.

Integer tincidunt eget justo a posuere. Curabitur fermentum, orci eu sagittis sagittis, nisl libero condimentum dolor, nec pellentesque nulla nulla vitae velit. Integer eleifend non lorem eget feugiat. Pellentesque pulvinar non nunc nec pharetra. Nunc tincidunt nulla vel mi interdum, sit amet volutpat ligula suscipit. In tempor, orci at posuere vestibulum, risus ex vehicula nunc, sit amet dictum eros est nec libero. In hac habitasse platea dictumst. Mauris consectetur dui at mi pellentesque, vitae fringilla libero eleifend."
            }
        }
    }
}
