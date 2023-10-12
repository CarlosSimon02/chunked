import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import components.buttons as Btn

//always name the id of the drawer as "drawer"
Page {
    id: page
    property Component headerOptions

    padding: 0
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

            Btn.LinkButton {
                icon.source: "qrc:/close_icon.svg"
                icon.width: 15
                icon.height: 15

                onClicked: {
                    drawer.close()
                    backdrop.close()
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: Number.POSITIVE_INFINITY

                Loader {
                    Layout.alignment: Qt.AlignRight
                    sourceComponent: page.headerOptions
                }
            }
        }
    }
}
