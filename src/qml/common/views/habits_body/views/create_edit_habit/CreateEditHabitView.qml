import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./components" as MComp

Comp.PageView {
    title: "Create Habit"
    isInitItem: false

    Material.accent: Comp.Globals.color.accent.shade1

    ScrollView {
        id: scrollView
        anchors.fill: parent
        padding: 20

        ColumnLayout {
            width: scrollView.width

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 30

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "Habit Name"
                    }

                    Comp.TextField {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                    }
                }

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "Frequency"
                    }

                    Comp.ComboBox {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                    }
                }

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "Start Date"
                    }

                    TextField {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                    }
                }

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "End Date"
                    }

                    Comp.TextField {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                    }
                }

                Button {
                    Layout.leftMargin: 400 - width
                    Layout.preferredWidth: 100
                    text: "Save"

                    Material.background: Comp.Globals.color.accent.shade1
                    Material.roundedScale: Material.SmallScale
                }
            }
        }
    }
}
