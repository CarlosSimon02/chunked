import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

import components as Comp
import "./components" as MComp

Comp.PageView {
    isInitItem: false
    title: "Create Goal"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        PageIndicator {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            count: 5
            currentIndex: 0
            visible: window.width < Comp.Globals.screen.smallW

            Material.foreground: Comp.Globals.color.accent.shade1
        }

        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true

            Material.accent: Comp.Globals.color.accent.shade1

            Pane {
                implicitWidth: scrollView.width
                padding: 20
                focusPolicy: Qt.ClickFocus

                ColumnLayout {
                    width: parent.width
                    spacing: 30

                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 12

                        Text {
                            text: "Goal Name"
                            font.pixelSize: Comp.Globals.fontSize.medium
                            font.weight: Font.DemiBold
                            color: Material.color(Material.Grey, Material.Shade600)
                        }

                        TextField {
                            Layout.maximumWidth: 500
                            Layout.fillWidth: true
                        }
                    }

                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 12

                        Text {
                            text: "Category"
                            font.pixelSize: Comp.Globals.fontSize.medium
                            font.weight: Font.DemiBold
                            color: Material.color(Material.Grey, Material.Shade600)
                        }

                        ComboBox {
                            id: category
                            Layout.maximumWidth: 500
                            Layout.fillWidth: true
                            model: ["Work", "Personal", "Home"]
                            popup.background: Rectangle {
                                radius: 4
                                color: Comp.Globals.color.primary.shade3

                                layer.enabled: category.enabled
                                layer.effect: RoundedElevationEffect {
                                    elevation: 4
                                    roundedScale: Material.ExtraSmallScale
                                }
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 12

                        Text {
                            text: "Image"
                            font.pixelSize: Comp.Globals.fontSize.medium
                            font.weight: Font.DemiBold
                            color: Material.color(Material.Grey, Material.Shade600)
                        }

                        MComp.ImagePicker {
                            Layout.maximumWidth: 500
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Layout.margins: 15
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
            }
        }
    }
}
