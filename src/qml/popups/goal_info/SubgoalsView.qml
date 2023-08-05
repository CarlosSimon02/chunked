import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./components" as GoalInfo

ScrollView {
    id: scrollView
    padding: 10
    rightPadding: 10
    bottomPadding: 10
    contentWidth: availableWidth

    ColumnLayout {
        width: scrollView.availableWidth

        GridView {
            Layout.preferredHeight: contentHeight
            Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            cellWidth: 330
            cellHeight: 390
            clip: true

            delegate: Item {
                width: GridView.view.cellWidth
                height: GridView.view.cellHeight

                GoalInfo.SubgoalItemDelegate {
                    anchors.centerIn: parent
                    imageSource: model.imageSource
                    goalName: model.goalName
                    timeRemaining: model.timeRemaining
                    progressValue: model.progressValue
                    targetValue: model.progressTarget
                    unit: model.unit
                }
            }

            model: ListModel {
                ListElement {
                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
                    category: "Home"
                    goalName: "Become a Freaking Software Engineer"
                    timeRemaining: "1d 3h remaining"
                    progressValue: 47
                    progressTarget: 87
                    unit: "book"
                }

                ListElement {
                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
                    category: "Home"
                    goalName: "Become a Freaking Software Engineer"
                    timeRemaining: "1d 3h remaining"
                    progressValue: 47
                    progressTarget: 87
                    unit: "book"
                }

                ListElement {
                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
                    category: "Home"
                    goalName: "Become a Freaking Software Engineer"
                    timeRemaining: "1d 3h remaining"
                    progressValue: 47
                    progressTarget: 87
                    unit: "book"
                }

                ListElement {
                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
                    category: "Home"
                    goalName: "Become a Freaking Software Engineer"
                    timeRemaining: "1d 3h remaining"
                    progressValue: 47
                    progressTarget: 87
                    unit: "book"
                }

                ListElement {
                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
                    category: "Home"
                    goalName: "Become a Freaking Software Engineer"
                    timeRemaining: "1d 3h remaining"
                    progressValue: 47
                    progressTarget: 87
                    unit: "book"
                }
            }
        }
    }
}
