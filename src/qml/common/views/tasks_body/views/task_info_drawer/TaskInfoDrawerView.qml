import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "./components" as MComp

Drawer {
    id: drawer
    width: 370
    interactive: false
    padding: 0
    Overlay.modal: null
    modal: false
    edge: Qt.RightEdge
    Material.background: Comp.Globals.color.primary.shade1
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

            Page {
                padding: 15
                background: null
                header: Pane {
                    padding: 15
                    background: Item {
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            height: 1
                            width: parent.width
                            color: Comp.Globals.color.secondary.shade1
                        }
                    }

                    RowLayout {
                        width: parent.width
                        IconLabel {
                            icon.source: "qrc:/close_icon.svg"
                            icon.width: 15
                            icon.height: 15
                            icon.color: Comp.Globals.color.secondary.shade2
                        }

                        IconLabel {
                            Layout.alignment: Qt.AlignRight
                            icon.source: "qrc:/three_dots_icon.svg"
                            icon.width: 18
                            icon.height: 18
                            icon.color: Comp.Globals.color.secondary.shade2
                        }
                    }
                }

                ColumnLayout {
                    width: parent.width
                    spacing: 20

                    ColumnLayout {
                        spacing: 40

                        RowLayout {
                            CheckBox {
                                Layout.leftMargin: -8
                                Layout.alignment: Qt.AlignTop
                            }

                            MComp.TextArea {
                                Layout.fillWidth: true
                                Layout.topMargin: 10
                                text: "HelloOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
                                font.pixelSize: Comp.Globals.fontSize.large
                            }
                        }

                        ColumnLayout {
                            spacing: 10

                            MComp.FieldRowLayout {
                                MComp.Icon {
                                    Layout.alignment: Qt.AlignTop
                                    icon.source: "qrc:/status_icon.svg"
                                    ToolTip.text: "Status"
                                }

                                MComp.TextArea {
                                    Layout.fillWidth: true
                                    color: "green"
                                    text: "Active"
                                    readOnly: true
                                }
                            }

                            MComp.FieldRowLayout {
                                MComp.Icon {
                                    Layout.alignment: Qt.AlignTop
                                    icon.source: "qrc:/check_icon.svg"
                                    ToolTip.text: "Outcome"
                                }

                                MComp.TextArea {
                                    Layout.fillWidth: true
                                    text: "1"
                                }
                            }

                            MComp.FieldRowLayout {
                                MComp.Icon {
                                    Layout.alignment: Qt.AlignTop
                                    icon.source: "qrc:/time_icon.svg"
                                    ToolTip.text: "Time Remaining"
                                }

                                MComp.TextArea {
                                    Layout.fillWidth: true
                                    text: "4h 3m remaining"
                                    readOnly: true
                                }
                            }

                            MComp.FieldRowLayout {
                                MComp.Icon {
                                    Layout.alignment: Qt.AlignTop
                                    icon.source: "qrc:/date_time_icon.svg"
                                    ToolTip.text: "Time Frame"
                                }

                                MComp.TextArea {
                                    Layout.fillWidth: true
                                    text: "29 Sep 2023 03:49 PM -\n29 Sep 2023 03:49 PM\n(5h 2m)"
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
