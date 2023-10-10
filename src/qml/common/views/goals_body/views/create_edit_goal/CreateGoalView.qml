import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import app

import components as Comp
import "./components" as MComp
import "./views"

Comp.PageView {
    id: pageView

    property Goal goal: {

    }

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

                CommonFormView {
                    id: commonFormView
                }

                ParentGoalFormView {

                }

                TimeFrameFormView {

                }

                ProgressFormView {
                    id: progressFormView
                }

                DescriptionFormView {

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

                    onClicked: {
                        if(stepper.currentIndex > 0) {
                            stepper.currentIndex--
                        }
                    }
                }

                Button {
                    Layout.preferredWidth: backButton.width
                    text: stepper.currentIndex === (stepper.count - 1) ? "Save" : "Next"
                    Material.background: Comp.Globals.color.accent.shade1
                    Material.roundedScale: Material.SmallScale

                    onClicked: {
                        if(stepper.currentIndex < stepper.count - 1) {
                            //check for errors first
                            let hasError

                            if(stepper.currentIndex === 0) {
                                commonFormView.checkError()
                                hasError = commonFormView.hasError
                            }
                            else if(stepper.currentIndex === 3) {
                                progressFormView.checkError()
                                hasError = progressFormView.hasError
                            }

                            if(!hasError) {
                                stepper.currentIndex++
                                stepper.currentItem.done = true
                            }
                        }
                        else {
                        }
                    }
                }
            }
        }
    }
}
