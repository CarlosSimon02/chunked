import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import app

import "./views/main"
import "./views/goal_info"

import components as Comp

ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Chunked")
    font.family: "Poppins"

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.dark
    }

    GoalsDataAccess {
        id: goalsDataAccess
    }

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.maximumWidth: 1700
            Layout.maximumHeight: 1080
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            Layout.margins: 15

            StackView {
                id: stackView
                anchors.fill: parent

                popEnter: null
                popExit: null
                pushEnter: null
                pushExit: null
                replaceEnter: null
                replaceExit: null

                initialItem: MainView {}
            }

            Component {
                id: goalInfoView

                GoalInfoView {}
            }
        }
    }
}
