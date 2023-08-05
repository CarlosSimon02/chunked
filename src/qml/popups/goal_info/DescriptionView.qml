import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import components as Comp

Comp.ScrollView {
    id: scrollView
    contentWidth: availableWidth

    Comp.Pane {
        width: scrollView.availableWidth
        padding: 20
        background: null

        ColumnLayout {
            width: parent.width
            spacing: 30

            Repeater {
                ColumnLayout {
                    spacing: 15

                    Comp.Text {
                        Layout.fillWidth: true
                        text: model.label
                        font.pixelSize: 18
                        font.weight: Font.DemiBold
                    }

                    Comp.Text {
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        lineHeight: 1.5

                        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae tincidunt metus. Sed tincidunt justo nec justo pellentesque, non aliquet purus hendrerit. Vestibulum consectetur mi in velit interdum, sit amet feugiat enim bibendum. Fusce id erat non neque laoreet facilisis a at quam. Sed dictum lacus vel pharetra blandit. Nulla facilisi. Proin nec tortor eget sapien venenatis eleifend. Etiam non risus sed."
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
}
