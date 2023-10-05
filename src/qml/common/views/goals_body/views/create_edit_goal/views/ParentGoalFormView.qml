import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import components as Comp
import "../components" as MComp

ScrollView {
    id: scrollView
    contentHeight: columnLayout.height

    MouseArea {
        width: scrollView.width
        height: scrollView.height
        onClicked: { scrollView.focus = false}
    }

    ColumnLayout {
        id: columnLayout
        width: scrollView.width

        ColumnLayout {
            Layout.margins: 30
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            MComp.FieldColumnLayout {
                MComp.FieldLabel {
                    text: "Parent Goal"
                }

                Comp.GoalNamesTreeViewComboBox {
                    Layout.maximumWidth: 500
                    Layout.fillWidth: true
                }
            }
        }
    }
}
