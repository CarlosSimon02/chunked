import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

import components as Comp
import "./components" as MComp
import "./views"

Comp.PageView {
    isInitItem: false
    title: "Create Goal"
    focusPolicy: Qt.ClickFocus

    Material.accent: Comp.Globals.color.accent.shade1

    RowLayout {
        anchors.fill: parent
        spacing: 30

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.preferredWidth: 150
            Layout.topMargin: 30
            Layout.leftMargin: 30
            visible: !pageIndicator.visible
            spacing: 0
            currentIndex: 0
            delegate: ItemDelegate {
                width: listView.width
                required property string modelData
                required property int index
                text: modelData
                highlighted: ListView.isCurrentItem
                onClicked: listView.currentIndex = index
            }

            model: ["Common", "Parent Goal", "Time Frame", "Progress", "Description"]

            TapHandler {
                onTapped: listView.forceActiveFocus()
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
                count: listView.count
                currentIndex: listView.currentIndex
                visible: window.width < Comp.Globals.screen.smallW

                Material.foreground: Comp.Globals.color.accent.shade1
            }

            StackLayout {
                id: stackLayout
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: listView.currentIndex

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
                        if(listView.currentIndex > 0) {
                            listView.currentIndex--
                        }
                    }
                }

                Button {
                    Layout.preferredWidth: backButton.width
                    text: listView.currentIndex === (listView.count - 1) ? "Save" : "Next"

                    Material.background: Comp.Globals.color.accent.shade1
                    Material.roundedScale: Material.SmallScale

                    onClicked: {
                        if(listView.currentIndex < listView.count - 1) {
                            //check for errors first
                            let hasError

                            if(listView.currentIndex === 0) {
                                commonFormView.checkError()
                                hasError = commonFormView.hasError
                            }
                            else if(listView.currentIndex === 3) {
                                progressFormView.checkError()
                                hasError = progressFormView.hasError
                            }

                            if(!hasError) {
                                listView.currentIndex++
                            }
                        }
                    }
                }
            }
        }
    }
}
