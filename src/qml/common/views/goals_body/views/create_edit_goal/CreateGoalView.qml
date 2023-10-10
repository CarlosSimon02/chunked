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

    property Goal goal: Goal {
        name: common.goalName
        imageSource: common.imageSource
        category: common.category
        startDateTime: timeFrame.startDateTime
        endDateTime: timeFrame.endDateTime
        progressTracker: progress.trackerType
        progressValue: progress.progressValue
        targetValue: progress.targetValue
        progressUnit: progress.unit
        mission: description.mission
        vision: description.vision
        obstacles: description.obstacles
        resources: description.resources
        parentGoalId: parentGoal.parentGoalId
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

                CommonFormView { id: common }
                ParentGoalFormView { id: parentGoal }
                TimeFrameFormView { id: timeFrame }
                ProgressFormView { id: progress }
                DescriptionFormView { id: description }
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
                                common.checkError()
                                hasError = common.hasError
                            }
                            else if(stepper.currentIndex === 3) {
                                progress.checkError()
                                hasError = progress.hasError
                            }

                            if(!hasError) {
                                stepper.currentIndex++
                                stepper.currentItem.done = true
                            }
                        }
                        else {
                            dbAccess.saveGoalItem(pageView.goal)
                            stackPageView.pop()
                        }
                    }
                }
            }
        }
    }
}
