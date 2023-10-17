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

    property int row

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
                                    editTaskDialogView.open()
                                }

                                Material.accent: Material.color(Material.Lime, Material.Shade900)
                            }

                            MenuItem {
                                text: qsTr("Delete")
                                onTriggered: {
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
                                    text: listView.itemAtIndex(drawer.row).taskName
                                }

                                Text {
                                    id: timeStatus
                                    text: Comp.Utils.getTimeStatus(listView.itemAtIndex(drawer.row).dateTime,
                                                                   Comp.Utils.getEndDateTime(listView.itemAtIndex(drawer.row).dateTime, listView.itemAtIndex(drawer.row).duration),
                                                                   listView.itemAtIndex(drawer.row).done)
                                    font.pixelSize: Comp.Globals.fontSize.medium
                                    color: Comp.Globals.color.secondary.shade2
                                }
                            }

                            ColumnLayout {
                                spacing: 10

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/status_icon.svg"
                                    label: "Status"
                                    value: Comp.Globals.statusTypes[Comp.Utils.getStatus(listView.itemAtIndex(drawer.row).dateTime,
                                                                                         Comp.Utils.getEndDateTime(listView.itemAtIndex(drawer.row).dateTime, listView.itemAtIndex(drawer.row).duration),
                                                                                         listView.itemAtIndex(drawer.row).dones)]
                                    color: Comp.Globals.statusColors[Comp.Utils.getStatus(listView.itemAtIndex(drawer.row).dateTime,
                                                                                          Comp.Utils.getEndDateTime(listView.itemAtIndex(drawer.row).dateTime, listView.itemAtIndex(drawer.row).duration),
                                                                                          listView.itemAtIndex(drawer.row).done)]
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/check_icon.svg"
                                    label: "Outcomes"
                                    value: listView.itemAtIndex(drawer.row).outcomes
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/date_time_icon.svg"
                                    label: "Date and Time"
                                    value: listView.itemAtIndex(drawer.row).dateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
                                }

                                Comp.ContentIconLabelData {
                                    iconSource: "qrc:/timer_icon.svg"
                                    label: "Duration"
                                    value: (Math.floor(listView.itemAtIndex(drawer.row).duration / 60)).toString() +  "h" +
                                           ((listView.itemAtIndex(drawer.row).duration % 60) ? " " + (listView.itemAtIndex(drawer.row).duration % 60).toString() + "m" : "")
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
                                    checked: listView.itemAtIndex(drawer.row).done
                                    onCheckedChanged: listView.itemAtIndex(drawer.row).done = checked
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
