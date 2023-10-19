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

    property alias parentGoalId: parentGoal.parentGoalId
    property Goal goal: Goal {
        itemId: 0
        name: common.goalName
        imageSource: common.imageSource
        category: common.category
        startDateTime: timeFrame.startDateTime
        endDateTime: timeFrame.endDateTime
        progressTracker: progress.trackerType
        progressUnit: progress.unit
        mission: description.mission
        vision: description.vision
        obstacles: description.obstacles
        resources: description.resources
        parentGoalId: parentGoal.parentGoalId

        onItemIdChanged: {
            if(itemId) {
                let tempGoal = dbAccess.getGoalItem(itemId)
                common.goalName = tempGoal.name
                common.imageSource = tempGoal.imageSource
                common.category = tempGoal.category
                timeFrame.startDateTime = tempGoal.startDateTime
                timeFrame.endDateTime = tempGoal.endDateTime
                progress.trackerType = tempGoal.progressTracker

                progress.unit = tempGoal.progressUnit
                description.mission = tempGoal.mission
                description.vision = tempGoal.vision
                description.obstacles = tempGoal.obstacles
                description.resources = tempGoal.resources
                parentGoal.parentGoalId = tempGoal.parentGoalId

                let tempGoalProgress = dbAccess.getGoalProgress(itemId)
                goalProgress.parentId = itemId
                progress.progressValue = tempGoalProgress.value
                progress.targetValue = tempGoalProgress.target
            }
        }
    }
    property Progress goalProgress: Progress {
        value: progress.progressValue
        target: progress.targetValue
    }

    isInitItem: false
    title: pageView.goal.itemId ? "Edit Goal" : "Create Goal"
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
            visible: !pageIndicator.visible && pageView.goal.itemId
            spacing: 0
            currentIndex: 0
            delegate: ItemDelegate {
                width: listView.width
                required property string modelData
                required property int index
                text: modelData
                highlighted: ListView.isCurrentItem
                onClicked: {
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
                        listView.currentIndex = index
                        stackLayout.currentIndex = index
                        stepper.currentIndex = index
                    }
                }
            }

            model: ["Common", "Parent Goal", "Time Frame", "Progress", "Description"]

            TapHandler {
                onTapped: listView.forceActiveFocus()
            }
        }

        Comp.Stepper {
            id: stepper
            Layout.fillHeight: true
            Layout.preferredWidth: 100
            Layout.topMargin: 30
            Layout.leftMargin: 30
            visible: !pageIndicator.visible && !listView.visible
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
                currentIndex: {
                    stepper.currentIndex
                }

                CommonFormView { id: common }
                ParentGoalFormView { id: parentGoal }
                TimeFrameFormView { id: timeFrame; editMode: pageView.goal.itemId }
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
                            listView.currentIndex--
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
                                listView.currentIndex++
                                stepper.currentIndex++
                                stepper.currentItem.done = true
                            }
                        }
                        else {
                            if(pageView.goal.itemId)
                            {
                                dbAccess.updateGoalItem(pageView.goal)
                                dbAccess.updateGoalProgress(pageView.goalProgress)
                            }
                            else
                            {
                                pageView.goalProgress.parentId = dbAccess.saveGoalItem(pageView.goal)
                                dbAccess.saveGoalProgress(pageView.goalProgress)
                            }

                            stackPageView.pop()
                        }
                    }
                }
            }
        }
    }
}
