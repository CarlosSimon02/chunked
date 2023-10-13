import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.inputs as Inpt
import "./components" as MComp

Comp.PageView {
    title: "Create Habit"
    isInitItem: false

    Material.accent: Comp.Globals.color.accent.shade1

    ScrollView {
        id: scrollView
        anchors.fill: parent

        ColumnLayout {
            width: scrollView.width

            ColumnLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 400
                Layout.alignment: Qt.AlignHCenter
                Layout.margins: 20
                spacing: 30

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "Habit Name"
                    }

                    Inpt.TextField {
                        Layout.fillWidth: true
                    }
                }

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "Frequency"
                    }

                    Inpt.ComboBox {
                        Layout.fillWidth: true
                    }
                }

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "Start Date"
                    }

                    TextField {
                        Layout.fillWidth: true
                    }
                }

                MComp.FieldColumnLayout {
                    MComp.FieldLabel {
                        text: "End Date"
                    }

                    Inpt.TextField {
                        Layout.fillWidth: true
                    }
                }

                Button {
                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: 100
                    text: "Save"

                    Material.background: Comp.Globals.color.accent.shade1
                    Material.roundedScale: Material.SmallScale
                }
            }
        }
    }
}
