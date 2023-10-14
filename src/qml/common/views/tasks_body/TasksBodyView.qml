import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn
import components.delegates as Dlg
import "./components" as MComp
import "./views/create_task"
import "./views/filter"
import "./views/task_info_drawer"

RowLayout {
    id: rowLayout
    spacing: 0

    property int parentGoalId: 0
    property bool isSubGoal: false

    Material.accent: Comp.Globals.color.accent.shade1

    ListView {
        id: listView
        Layout.fillWidth: true
        Layout.fillHeight: true
        leftMargin: 30
        rightMargin: 30
        topMargin: 30
        bottomMargin: 30
        spacing: 10
        clip: true
        header: RowLayout {
            width: parent.width
            spacing: 10

            MComp.CreateTaskTextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                Layout.bottomMargin: 10
            }

            Comp.NavBarDelegate {
                Layout.preferredWidth: 45
                Layout.preferredHeight: 45
                Layout.bottomMargin: 10
                icon.source: "qrc:/edit_icon.svg"
                visible: !columnLayout.visible

            }

            Comp.NavBarDelegate {
                Layout.preferredWidth: 45
                Layout.preferredHeight: 45
                Layout.bottomMargin: 10
                icon.source: "qrc:/filter_icon.svg"
                visible: !columnLayout.visible

                onClicked: filterDrawerView.open()
            }
        }

        section.property: "date"
        section.delegate: Label {
            topPadding: 10
            bottomPadding: 10
            required property string section
            text: section
            color: Comp.Globals.color.secondary.shade2
            font.pixelSize: Comp.Globals.fontSize.small
        }

        ScrollBar.vertical: ScrollBar {
            parent: listView
            x: listView.width - width
            height: listView.height
        }

        delegate: Dlg.TaskItemDelegate {
            width: ListView.view.width -
                   ListView.view.leftMargin -
                   ListView.view.rightMargin
            date: "Today"
            onClicked: taskInfoDrawerView.open()
        }

        model: ListModel {
            ListElement {
                date: "Today"
            }

            ListElement {
                date: "Today"
            }

            ListElement {
                date: "Today"
            }
        }
    }

    Rectangle {
        Layout.fillHeight: true
        Layout.preferredWidth: 1
        color: Comp.Globals.color.secondary.shade1
        visible: columnLayout.visible
    }

    ColumnLayout {
        id: columnLayout
        Layout.preferredWidth: 380
        Layout.maximumWidth: 380
        Layout.leftMargin: 30
        visible: !rowLayout.parentGoalId && window.width > 1200

        Comp.NavBar {
            id: navBar
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            Layout.topMargin: 30
            clip: false

            delegate: Comp.NavBarDelegate {
                width: navBar.height
                height: navBar.height
                icon.source: model.icon
                icon.width: 20
                icon.height: 20

                onClicked: {
                    ListView.view.currentIndex = model.index
                }
            }

            model: ListModel {
                ListElement {
                    icon: "qrc:/edit_icon.svg"
                }

                ListElement {
                    icon: "qrc:/filter_icon.svg"
                }
            }
        }

        StackLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: 380
            currentIndex: navBar.currentIndex

            ScrollView {
                id: createTaskScrollView
                CreateTaskView {
                    topPadding: 30
                    rightPadding: 30
                    width: createTaskScrollView.width
                }
            }

            ScrollView {
                id: scrollView

                Pane {
                    width: scrollView.width
                    padding: 0
                    topPadding: 30
                    rightPadding: 30

                    FilterView {
                        id: filterView
                        width: parent.width
                    }
                }
            }
        }
    }



    FilterDrawerView {
        id: filterDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }

    TaskInfoDrawerView {
        id: taskInfoDrawerView
        y: topBarView.height
        height: parent.height - topBarView.height
    }
}
