import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import body.components as Body

ScrollView {
    id: scrollView
    padding: 10
    rightPadding: 10
    bottomPadding: 10
    contentWidth: availableWidth

    ColumnLayout {
        width: scrollView.availableWidth

//        GridView {
//            Layout.preferredHeight: contentHeight
//            Layout.preferredWidth: (Math.floor(parent.width / cellWidth) * cellWidth)
//            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
//            cellWidth: 310
//            cellHeight: 210
//            clip: true

//            delegate: Item {
//                width: 310
//                height: 210

//                Body.GoalItemDelegate {
//                    anchors.centerIn: parent
//                    imageSource: model.imageSource
//                    category: model.category
//                    goalName: model.goalName
//                    timeRemaining: model.timeRemaining
//                    progressBar.value: model.progressValue
//                    progressBar.to: model.progressTarget
//                    unit: model.unit
//                }
//            }

//            model: ListModel {
//                ListElement {
//                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
//                    category: "Home"
//                    goalName: "Wash Dishes"
//                    timeRemaining: "1d 3h remaining"
//                    progressValue: 47
//                    progressTarget: 87
//                    unit: "book"
//                }

//                ListElement {
//                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
//                    category: "Home"
//                    goalName: "Wash Dishes"
//                    timeRemaining: "1d 3h remaining"
//                    progressValue: 47
//                    progressTarget: 87
//                    unit: "book"
//                }

//                ListElement {
//                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
//                    category: "Home"
//                    goalName: "Wash Dishes"
//                    timeRemaining: "1d 3h remaining"
//                    progressValue: 47
//                    progressTarget: 87
//                    unit: "book"
//                }

//                ListElement {
//                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
//                    category: "Home"
//                    goalName: "Wash Dishes"
//                    timeRemaining: "1d 3h remaining"
//                    progressValue: 47
//                    progressTarget: 87
//                    unit: "book"
//                }

//                ListElement {
//                    imageSource: "file:/Users/Carlos Simon/OneDrive/Documents/Personal/244554433_867713097472035_6513392882745034687_n.jpg"
//                    category: "Home"
//                    goalName: "Wash Dishes"
//                    timeRemaining: "1d 3h remaining"
//                    progressValue: 47
//                    progressTarget: 87
//                    unit: "book"
//                }
//            }
//        }
    }
}
