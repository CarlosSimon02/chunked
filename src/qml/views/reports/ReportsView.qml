import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtCharts

import components as Comp
import "./components" as MComp

Comp.PageView {
    title: "Reports"
    padding: 20

    Material.accent: Comp.Globals.color.accent.shade1

    ColumnLayout {
        anchors.fill: parent
        spacing: 30

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

        ColumnLayout {
            spacing: 10

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Total Accomplishments Per Month"
                font.pixelSize: Comp.Globals.fontSize.large
                font.bold: true
                color: "white"
            }

            Rectangle {
                Layout.bottomMargin: 10
                Layout.fillWidth: true
                Layout.preferredHeight: 2
                color: Comp.Globals.color.primary.shade3
            }

            RowLayout {
                spacing: 20
                Layout.alignment: Qt.AlignHCenter
                z: 2

                Frame {
                    padding: 0
                    verticalPadding: 0
                    horizontalPadding: 10
                    Layout.preferredHeight: graphType.height
                    background: Rectangle {
                        color: "transparent"
                        border.width: 1
                        border.color: Comp.Globals.color.secondary.shade1
                        radius: 5
                    }

                    RowLayout {
                        Repeater {
                            delegate: CheckBox {
                                font.pixelSize: Comp.Globals.fontSize.medium
                                text: model.label
                                checkState: Qt.Checked
                            }

                            model: ListModel {
                                ListElement {
                                    label: "Goals Accomplished"
                                }

                                ListElement {
                                    label: "Tasks Completed"
                                }

                                ListElement {
                                    label: "Habits Checked"
                                }
                            }
                        }
                    }
                }

                Comp.ComboBox {
                    id: graphType
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 50
                    model: ["Monthly Graph", "Weekly Graph", "Daily Graph"]
                }
            }

            ChartView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin: -30
                Layout.bottomMargin: -30
                antialiasing: true
                backgroundColor: "transparent"
                theme: ChartView.ChartThemeDark
                legend.visible: false

                // Define x-axis to be used with the series instead of default one
                ValueAxis {
                    id: valueXAxis
                    min: lineSeries.at(0)
                    max: 2011
                    tickCount: 12
                    labelFormat: "%i"
                    gridLineColor: Comp.Globals.color.secondary.shade1
                    labelsAngle: 320
                    color: Comp.Globals.color.secondary.shade1
                }

                ValueAxis {
                    id: valueYAxis
                    gridLineColor: Comp.Globals.color.secondary.shade1
                    color: Comp.Globals.color.secondary.shade1
                    labelFormat: "%i"
                }

                AreaSeries {
                    borderColor: Comp.Globals.color.accent.shade1
                    borderWidth: 2
                    color: "#70827717"
                    axisX: valueXAxis
                    axisY: valueYAxis
                    upperSeries: LineSeries {
                        id: lineSeries
                        XYPoint { x: 2000; y: 1 }
                        XYPoint { x: 2001; y: 4 }
                        XYPoint { x: 2002; y: 1 }
                        XYPoint { x: 2003; y: 2 }
                        XYPoint { x: 2004; y: 1 }
                        XYPoint { x: 2005; y: 1 }
                        XYPoint { x: 2006; y: 3 }
                        XYPoint { x: 2007; y: 1 }
                        XYPoint { x: 2008; y: 20 }
                        XYPoint { x: 2009; y: 3 }
                        XYPoint { x: 2010; y: 3 }
                        XYPoint { x: 2011; y: 1 }
                        XYPoint { x: 2012; y: 1 }
                        XYPoint { x: 2013; y: 2 }
                        XYPoint { x: 2014; y: 1 }
                        XYPoint { x: 2015; y: 1 }
                        XYPoint { x: 2016; y: 3 }
                        XYPoint { x: 2017; y: 1 }
                        XYPoint { x: 2018; y: 20 }
                        XYPoint { x: 2019; y: 3 }
                    }
                }
            }

            ScrollBar {
                Layout.fillWidth: true
                policy: ScrollBar.AlwaysOn
                orientation: Qt.Horizontal
                background: Rectangle {
                    color: "black"
                }
                size: valueXAxis.tickCount / lineSeries.count
            }
        }
    }
}
