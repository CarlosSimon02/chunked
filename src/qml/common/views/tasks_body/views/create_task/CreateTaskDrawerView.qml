import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import app

import components as Comp

Drawer {
    id: drawer
    width: 380
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
                id: drawerContent

                ScrollView {
                    id: createTaskScrollView
                    anchors.fill: parent
                    leftPadding: 15

                    CreateTaskView {
                        id: createTaskView2
                        topPadding: 30
                        rightPadding: 30
                        width: createTaskScrollView.width

                        onOutcomesChanged: createTaskView.outcomes = createTaskView2.outcomes
                        onDateTimeChanged: createTaskView.dateTime = createTaskView2.dateTime
                        onDurationChanged: createTaskView.duration = createTaskView2.duration
                    }
                }

                Component.onCompleted: {
                    createTaskView2.outcomes = createTaskView.outcomes
                    createTaskView2.dateTime = createTaskView.dateTime
                    createTaskView2.duration = createTaskView.duration
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
