import QtQuick as Q
import QtQuick.Controls as Q

import components as C

Q.ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    title: qsTr("chunked")
    font.family: "Poppins"

    background: Q.Rectangle {
        color: ColorScheme.primaryColor.dark
    }
}
