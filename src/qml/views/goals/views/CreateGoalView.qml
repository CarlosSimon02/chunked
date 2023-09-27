import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

import components as Comp
import "./components" as MComp

Comp.PageView {
    isInitItem: false
    title: "Create Goal"
    focusPolicy: Qt.ClickFocus

    Material.accent: Comp.Globals.color.accent.shade1

    RowLayout {
        anchors.fill: parent
        spacing: 30

        Comp.Stepper {
            id: stepper
            Layout.fillHeight: true
            Layout.preferredWidth: 100
            Layout.topMargin: 30
            Layout.leftMargin: 30
            visible: !pageIndicator.visible
            model: ["Common", "Parent Goal", "Time Frame", "Progress", "Description"]

            TapHandler {
                onTapped: stepper.forceActiveFocus()
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            PageIndicator {
                id: pageIndicator
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 20
                count: stepper.count
                currentIndex: stepper.currentIndex
                visible: window.width < Comp.Globals.screen.smallW

                Material.foreground: Comp.Globals.color.accent.shade1
            }

            StackLayout {
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: stepper.currentIndex

                ScrollView {
                    TapHandler {
                        onTapped: stepper.forceActiveFocus()
                    }

                    ColumnLayout {
                        width: stackLayout.width

                        ColumnLayout {
                            Layout.margins: 30
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Goal Name"
                                }

                                TextField {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Category"
                                }

                                MComp.ComboBox {
                                    id: category
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                    model: ["Work", "Personal", "Home"]
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Image"
                                }

                                MComp.ImagePicker {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }

                ScrollView {
                    ColumnLayout {
                        width: stackLayout.width

                        ColumnLayout {
                            Layout.margins: 30
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Parent Goal"
                                }

                                TextField {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }

                ScrollView {
                    ColumnLayout {
                        width: stackLayout.width

                        ColumnLayout {
                            Layout.margins: 30
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Start Time"
                                }

                                TextField {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "End Time"
                                }

                                TextField {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }

                ScrollView {
                    ColumnLayout {
                        width: stackLayout.width

                        ColumnLayout {
                            Layout.margins: 30
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Progress Tracker"
                                }

                                TextField {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Unit"
                                }

                                TextField {
                                    Layout.maximumWidth: 200
                                    Layout.fillWidth: true
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Progress Value"
                                }

                                TextField {
                                    Layout.maximumWidth: 200
                                    Layout.fillWidth: true
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Target Progress Value"
                                }

                                TextField {
                                    Layout.maximumWidth: 200
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }

                ScrollView {
                    ColumnLayout {
                        width: stackLayout.width

                        ColumnLayout {
                            Layout.margins: 30
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Mission"
                                }

                                TextField {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                    wrapMode: TextArea.Wrap
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Vision"
                                }

                                TextArea {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                    wrapMode: TextArea.Wrap
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Obstacles"
                                }

                                TextArea {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                    wrapMode: TextArea.Wrap
                                }
                            }

                            MComp.FieldColumnLayout {
                                MComp.FieldLabel {
                                    text: "Purposes"
                                }

                                TextArea {
                                    Layout.maximumWidth: 500
                                    Layout.fillWidth: true
                                    wrapMode: TextArea.Wrap
                                }
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                Layout.margins: 15
                Layout.rightMargin: 20
                Layout.bottomMargin: 20
                spacing: 10

                Button {
                    id: backButton
                    icon.source: "qrc:/arrow_left_icon.svg"
                    text: "Back"

                    Material.roundedScale: Material.SmallScale
                }

                Button {
                    Layout.preferredWidth: backButton.width
                    text: "Save"

                    Material.background: Comp.Globals.color.accent.shade1
                    Material.roundedScale: Material.SmallScale

                    onClicked: {
                        stepper.currentIndex++
                        stepper.currentItem.done = true
                    }
                }
            }
        }
    }
}
