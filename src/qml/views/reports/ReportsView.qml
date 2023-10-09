import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtCharts

import components as Comp
import "./components" as MComp

Comp.PageView {
    title: "Reports"
    padding: 20

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Repeater {
                delegate: MComp.DataSummaryCard {
                    Layout.fillWidth: true
                    Layout.maximumWidth: 300
                    iconSource: model.iconSource
                    data: model.data
                    label: model.label
                }

                model: ListModel {
                    ListElement {
                        iconSource: "qrc:/goals_icon.svg"
                        data: "33 Goals"
                        label: "accomplished"
                    }

                    ListElement {
                        iconSource: "qrc:/tasks_icon.svg"
                        data: "107 Tasks"
                        label: "completed"
                    }

                    ListElement {
                        iconSource: "qrc:/habits_icon.svg"
                        data: "45 Habits"
                        label: "checked"
                    }
                }
            }
        }

        ChartView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            antialiasing: true
            backgroundColor: Comp.Globals.color.primary.shade3

            // Define x-axis to be used with the series instead of default one
            ValueAxis {
                id: valueAxis
                min: 2000
                max: 2011
                tickCount: 12
                labelFormat: "%.0f"
            }

            AreaSeries {
                borderColor: Comp.Globals.color.accent.shade1
                axisX: valueAxis
                upperSeries: LineSeries {
                    XYPoint { x: 2000; y: 1 }
                    XYPoint { x: 2001; y: 1 }
                    XYPoint { x: 2002; y: 1 }
                    XYPoint { x: 2003; y: 1 }
                    XYPoint { x: 2004; y: 1 }
                    XYPoint { x: 2005; y: 0 }
                    XYPoint { x: 2006; y: 1 }
                    XYPoint { x: 2007; y: 1 }
                    XYPoint { x: 2008; y: 4 }
                    XYPoint { x: 2009; y: 3 }
                    XYPoint { x: 2010; y: 2 }
                    XYPoint { x: 2011; y: 1 }
                }
            }
        }
    }



//    Slider {
//        id: sb
//        anchors {
//            bottom: parent.bottom
//            left: parent.left
//            right: parent.right
//        }
//        height: 30
//    }
}
