import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn
import "./components" as MComp

Drawer {
    id: drawer
    width: 370
    interactive: false
    padding: 0
    Overlay.modal: null
    modal: false
    edge: Qt.RightEdge
    Material.background: Comp.Globals.color.primary.shade2
    Material.roundedScale: Material.NotRounded
    Material.accent: Comp.Globals.color.accent.shade1

    //To prevent drawer from closing when clicked
    MouseArea {
        anchors.fill: parent
        onClicked: drawer.focus = true
    }

    Connections {
        target: window
        function onWidthChanged() {
            if(drawer.opened && sideMenuView.visible) {
                drawer.close()
                backdrop.close()
            }
        }
    }

    Connections {
        target: backdrop
        function onTapped() {
            drawer.close()
        }
    }

    Loader {
        id: loader
        anchors.fill: parent

        Component {
            id: content

            Comp.DrawerContent {
                headerOptions: RowLayout {
                    Btn.LinkButton {
                        Layout.alignment: Qt.AlignRight
                        icon.source: "qrc:/three_dots_icon.svg"
                        icon.width: 18
                        icon.height: 18
                    }
                }

                ScrollView {
                    id: scrollView
                    anchors.fill: parent

                    ColumnLayout {
                        width: scrollView.width

                        ColumnLayout {
                            spacing: 30
                            Layout.margins: 20

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
                                    text: "This is a sample Task"
                                }

                                Text {
                                    id: timeStatus
    //                                text: Comp.Utils.getTimeStatus(scrollView.startDateTime,
    //                                                               scrollView.endDateTime,
    //                                                               progressBar.value === 1)
                                    text: "1h 1m remaining"
                                    font.pixelSize: Comp.Globals.fontSize.medium
                                    color: Comp.Globals.color.secondary.shade2
                                }
                            }

                            ColumnLayout {
                                spacing: 10

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/status_icon.svg"
                                    label: "Status"
                                    value: "Active"
                                    color: "green"
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/check_icon.svg"
                                    label: "Outcomes"
                                    value: "1"
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/date_time_icon.svg"
                                    label: "Date and Time"
                                    value: "29 Sep 2023 03:49 PM"
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/timer_icon.svg"
                                    label: "Duration"
                                    value: "1h"
                                }
                            }

                            RowLayout {
                                Layout.alignment: Qt.AlignRight

                                Text {
                                    text: "Done"
                                    font.pixelSize: Comp.Globals.fontSize.medium
                                    color: Comp.Globals.color.secondary.shade2
                                }

                                CheckBox {

                                }
                            }
                        }
                    }
                }
            }
        }
    }

    onAboutToShow: {
        backdrop.open()
        loader.sourceComponent = content
    }

    onClosed: loader.sourceComponent = null
}
