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
            spacing: 30

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

            RowLayout {
                ProgressBar {
                    id: progressBar
                    Layout.fillWidth: true
                    Material.accent: Material.color(Material.Lime, Material.Shade900)
                    value: scrollView.targetValue ? scrollView.progressValue / scrollView.targetValue : 0
                }

                Text {
                    text: scrollView.targetValue ? Math.floor((scrollView.progressValue / scrollView.targetValue) * 100) + "%" : "??"
                    font.pixelSize: Comp.Globals.fontSize.large
                    color: Material.color(Material.Lime, Material.Shade900)
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                Comp.ContentIconLabelData {
                    id: parentGoal
                    iconSource: "qrc:/hierarchy_icon.svg"
                    label: "Parent Goal"
                    value: "Sample"
                    color: "white"
                }

                Comp.ContentIconLabelData {
                    id: status
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
                    iconSource: "qrc:/category_icon.svg"
                    label: "Category"
                    color: "white"
                }

                Comp.ContentIconLabelData {
                    id: timeFrame
                    iconSource: "qrc:/date_time_icon.svg"
                    label: "Time Frame"
                    value: scrollView.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP") + " -\n" +
                           scrollView.endDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP") + "\n" +
                           "(" + Comp.Utils.getTimeFrame(scrollView.startDateTime,scrollView.endDateTime) + ")"
                    color: "white"
                }

                Comp.ContentIconLabelData {
                    id: tracker
                    iconSource: "qrc:/tracker_icon.svg"
                    label: "Tracker"
                    value: Comp.Globals.trackerTypes[scrollView.trackerType]
                    color: "white"
                }
            }
        }
    }
}
