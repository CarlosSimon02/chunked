import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

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

    property int itemId
    property Task task: dbAccess.getTaskItem(itemId)
    property date startDateTime
    property date endDateTime

    onTaskChanged: {
        startDateTime = Date.fromLocaleString(Qt.locale(),
                                              drawer.task.dateTime,
                                              "yyyy-MM-dd hh:mm:ss")
        endDateTime = Date.fromLocaleString(Qt.locale(),
                                            drawer.task.dateTime,
                                            "yyyy-MM-dd hh:mm:ss")
        endDateTime.setMinutes(endDateTime.getMinutes() + drawer.task.duration)
    }

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
                            spacing: 40
                            Layout.margins: 20

                            ColumnLayout {
                                spacing: 8

                                Text {
                                    id: taskName
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: width
                                    wrapMode: Text.Wrap
                                    font.pixelSize: Comp.Globals.fontSize.large
                                    font.weight: Font.DemiBold
                                    color: "white"
                                    text: drawer.task.name
                                }

                                Text {
                                    id: timeStatus
                                    text: Comp.Utils.getTimeStatus(drawer.startDateTime,
                                                                   drawer.endDateTime,
                                                                   drawer.task.done)
                                    font.pixelSize: Comp.Globals.fontSize.medium
                                    color: Comp.Globals.color.secondary.shade2
                                }
                            }

                            ColumnLayout {
                                spacing: 10

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/status_icon.svg"
                                    label: "Status"
                                    value: Comp.Globals.statusTypes[Comp.Utils.getStatus(drawer.startDateTime,
                                                                                         drawer.endDateTime,
                                                                                         drawer.task.done)]
                                    color: Comp.Globals.statusColors[Comp.Utils.getStatus(drawer.startDateTime,
                                                                                          drawer.endDateTime,
                                                                                          drawer.task.done)]
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/check_icon.svg"
                                    label: "Outcomes"
                                    value: drawer.task.outcomes
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/date_time_icon.svg"
                                    label: "Date and Time"
                                    value: drawer.task.startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/timer_icon.svg"
                                    label: "Duration"
                                    value: (Math.floor(drawer.task.duration / 60)).toString() +  "h" +
                                           ((drawer.task.duration % 60) ? " " + (drawer.task.duration % 60).toString() + "m" : "")
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
                                    checked: drawer.task.done
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
