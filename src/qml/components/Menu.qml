import QtQuick
import QtQuick.Controls.Basic as Ctrl

import components as Comp
import components.impl as Impl

Ctrl.Menu {
    id: menu

//    delegate: Comp.ItemDelegate {
//        width: 100
//        height: 40

//        text: menu.textRole ?
//                  Array.isArray(menu.model) ?
//                      modelData[menu.textRole] :
//                      model[menu.textRole] :
//                  modelData

//        highlighted: text === menu.displayText
//    }

    background: Rectangle {
        color: Comp.ColorScheme.primaryColor.light
        radius: Comp.Consts.commonRadius

        layer.enabled: true
        layer.effect: Impl.DropShadow {}
    }
}
