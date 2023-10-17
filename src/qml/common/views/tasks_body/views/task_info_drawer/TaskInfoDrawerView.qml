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
                id: drawerContent

                property Task task: dbAccess.getTaskItem(drawer.itemId)
                property date dateTime: task.dateTime

                headerOptions: RowLayout {
                    Btn.LinkButton {
                        Layout.preferredHeight: 27
                        Layout.alignment: Qt.AlignTop
                        icon.source: "qrc:/three_dots_icon.svg"
                        icon.width: 18
                        icon.height: 18

                        onClicked: menu.open()

                        Menu {
                            id: menu
                            Material.background: Material.color(Material.Grey, Material.Shade900)
                            Material.elevation: 15

                            MenuItem {
                                text: qsTr("Edit")
                                onTriggered: {
                                    editTaskDialogView.itemId = drawer.itemId
                                    editTaskDialogView.open()
                                }

                                Material.accent: Material.color(Material.Lime, Material.Shade900)
                            }

                            MenuItem {
                                text: qsTr("Delete")
                                onTriggered: {
                                    drawer.close()
                                    listView.model.removeRow(model.index)
                                }

                                Material.foreground: Material.Red
                            }
                        }
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
                                    text: drawerContent.task.name
                                }

                                Text {
                                    id: timeStatus
                                    text: Comp.Utils.getTimeStatus(drawerContent.dateTime,
                                                                   Comp.Utils.getEndDateTime(drawerContent.dateTime, drawerContent.task.duration),
                                                                   drawerContent.task.done)
                                    font.pixelSize: Comp.Globals.fontSize.medium
                                    color: Comp.Globals.color.secondary.shade2
                                }
                            }

                            ColumnLayout {
                                spacing: 10

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/status_icon.svg"
                                    label: "Status"
                                    value: Comp.Globals.statusTypes[Comp.Utils.getStatus(drawerContent.dateTime,
                                                                                         Comp.Utils.getEndDateTime(drawerContent.dateTime, drawerContent.task.duration),
                                                                                         drawerContent.task.done)]
                                    color: Comp.Globals.statusColors[Comp.Utils.getStatus(drawerContent.dateTime,
                                                                                          Comp.Utils.getEndDateTime(drawerContent.dateTime, drawerContent.task.duration),
                                                                                          drawerContent.task.done)]
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/check_icon.svg"
                                    label: "Outcomes"
                                    value: drawerContent.task.outcomes
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/date_time_icon.svg"
                                    label: "Date and Time"
                                    value: drawerContent.dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/timer_icon.svg"
                                    label: "Duration"
                                    value: (Math.floor(drawerContent.task.duration / 60)).toString() +  "h" +
                                           ((drawerContent.task.duration % 60) ? " " + (drawerContent.task.duration % 60).toString() + "m" : "")
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
                                    checked: drawerContent.task.done
                                    onCheckedChanged: {
                                        dbAccess.updateValue("tasks","done",drawer.itemId,checked)
                                        drawerContent.task = dbAccess.getTaskItem(drawer.itemId)
                                        listView.model.refresh()
                                    }
                                }
                            }
                        }
                    }
                }

                Connections {
                    target: editTaskDialogView

                    function onAccepted() {
                        drawerContent.task = dbAccess.getTaskItem(drawer.itemId)
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
