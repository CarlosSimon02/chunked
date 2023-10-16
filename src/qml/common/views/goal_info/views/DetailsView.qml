import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import components as Comp

ScrollView {
    id: scrollView

    property string imageSource
    property alias goalName: goalName.text
    property date startDateTime
    property date endDateTime
    property alias category: category.value
    property int trackerType
    property int progressValue
    property int targetValue
    property string unit
    property int parentGoalId

    clip: true
    layer.samples: 8
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: scrollView.width
            height: scrollView.height

            radius: 10
        }
    }

    background: Rectangle {
        color: Comp.Globals.color.primary.shade3
    }

    ColumnLayout {
        width: scrollView.width
        spacing: 0

        Image {
            Layout.fillWidth: true
            Layout.preferredHeight: width * 9 / 16
            fillMode: Image.PreserveAspectCrop
            source: scrollView.imageSource
            sourceSize.width: 350
            sourceSize.height: 197
            visible: scrollView.imageSource
        }

        ColumnLayout {
            Layout.margins: 20
            spacing: 40

            ColumnLayout {
                spacing: 8

                Text {
                    id: goalName
                    Layout.fillWidth: true
                    Layout.preferredWidth: width
                    wrapMode: Text.Wrap
                    font.pixelSize: Comp.Globals.fontSize.large
                    font.weight: Font.DemiBold
                    color: "white"
                }

                Text {
                    id: timeStatus
                    text: Comp.Utils.getTimeStatus(scrollView.startDateTime,
                                                   scrollView.endDateTime,
                                                   progressBar.value === 1)
                    font.pixelSize: Comp.Globals.fontSize.medium
                    color: Comp.Globals.color.secondary.shade2
                }
            }

            ColumnLayout {
                spacing: 0

                Comp.ProgressBar {
                    id: progressBar
                    Layout.fillWidth: true
                    value: scrollView.progressValue
                    target: scrollView.targetValue
                    fontPixelSize: Comp.Globals.fontSize.large
                }

                Text{
                    id: progress
                    text: scrollView.progressValue + " / " + scrollView.targetValue + " " +
                          scrollView.unit + " completed"
                    font.pixelSize: 16
                    color: Comp.Globals.color.secondary.shade2
                }
            }

            Column {
                Layout.fillWidth: true
                spacing: 12

                Comp.ContentIconLabelData {
                    id: parentGoal
                    width: parent.width
                    iconSource: "qrc:/hierarchy_icon.svg"
                    label: "Parent Goal"
                    value: scrollView.parentGoalId ? dbAccess.getValue("goals","name",scrollView.parentGoalId) :
                                                     ""
                    color: "white"
                    visible: scrollView.parentGoalId
                    underline: true
                }

                Comp.ContentIconLabelData {
                    id: status
                    width: parent.width
                    iconSource: "qrc:/status_icon.svg"
                    label: "Status"
                    value: Comp.Globals.statusTypes[Comp.Utils.getStatus(scrollView.startDateTime,
                                                                         scrollView.endDateTime,
                                                                         progressBar.value === 1)]
                    color: Comp.Globals.statusColors[Comp.Utils.getStatus(scrollView.startDateTime,
                                                                         scrollView.endDateTime,
                                                                         progressBar.value === 1)]
                }

                Comp.ContentIconLabelData {
                    id: category
                    width: parent.width
                    iconSource: "qrc:/category_icon.svg"
                    label: "Category"
                    color: "white"
                }

                Comp.ContentIconLabelData {
                    id: timeFrame
                    width: parent.width
                    iconSource: "qrc:/date_time_icon.svg"
                    label: "Time Frame"
                    value: scrollView.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP") + " -\n" +
                           scrollView.endDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP") + "\n" +
                           "(" + Comp.Utils.getTimeFrame(scrollView.startDateTime,scrollView.endDateTime) + ")"
                    color: "white"
                }

                Comp.ContentIconLabelData {
                    id: tracker
                    width: parent.width
                    iconSource: "qrc:/tracker_icon.svg"
                    label: "Tracker"
                    value: Comp.Globals.trackerTypes[scrollView.trackerType]
                    color: "white"
                }
            }
        }
    }
}
