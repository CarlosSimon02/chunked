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
                headerOptions : RowLayout {
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
                            Layout.margins: 20
                            spacing: 40

                            Text {
                                Layout.fillWidth: true
                                Layout.preferredWidth: width
                                text: "Solve LeetCode Questions"
                                font.pixelSize: Comp.Globals.fontSize.large
                                color: "white"
                                wrapMode: Text.Wrap
                            }

                            ColumnLayout {
                                spacing: 10

                                Repeater {
                                    delegate: RowLayout {
                                        spacing: 16

                                        IconLabel {
                                            Layout.preferredHeight: 22
                                            Layout.alignment: Qt.AlignTop
                                            icon.source: iconSource
                                            icon.width: 18
                                            icon.height: 18
                                            icon.color: Comp.Globals.color.secondary.shade2
                                            display: IconLabel.IconOnly

                                            HoverHandler {
                                                id: hover
                                            }

                                            ToolTip.visible: hover.hovered
                                            ToolTip.text: label
                                        }

                                        Text {
                                            font.pixelSize: Comp.Globals.fontSize.medium
                                            text: value
                                            color: model.color ? model.color : Comp.Globals.color.secondary.shade4
                                        }
                                    }

                                    model: ListModel {
                                        ListElement {
                                            iconSource: "qrc:/status_icon.svg"
                                            label: "Status"
                                            value: "Active"
                                            color: "green"
                                        }

                                        ListElement {
                                            iconSource: "qrc:/category_icon.svg"
                                            label: "Category"
                                            value: "Home"
                                        }

                                        ListElement {
                                            iconSource: "qrc:/time_icon.svg"
                                            label: "Time Remaining"
                                            value: "1h 40m remaining"
                                        }

                                        ListElement {
                                            iconSource: "qrc:/repeat_icon.svg"
                                            label: "Frequeny"
                                            value: "Daily"
                                        }

                                        ListElement {
                                            iconSource: "qrc:/fire_icon.svg"
                                            label: "Streak"
                                            value: "8 days"
                                        }

                                        ListElement {
                                            iconSource: "qrc:/date_time_icon.svg"
                                            label: "Time Fame"
                                            value: "29 Sep 2023 03:49 PM -\n29 Sep 2023 03:49 PM\n(5h 2m)"
                                        }
                                    }
                                }
                            }

                            Comp.ProgressBar {
                                Layout.fillWidth: true
                                value: 50
                                target: 100
                                fontPixelSize: Comp.Globals.fontSize.large
                            }

                            MComp.DateHiglighter {
                                Layout.fillWidth: true
                                Layout.preferredWidth: width
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
