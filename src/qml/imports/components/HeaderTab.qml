import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Layouts

import components as Comp

Comp.Pane {
    implicitWidth: 200
    implicitHeight: 50
    padding: 0
    horizontalPadding: 15

    IconLabel {
        id: iconLabel
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        text: "Home"
        font.pixelSize: 18
        font.weight: Font.DemiBold
        color: Comp.ColorScheme.secondaryColor.dark
        icon.source: "qrc:/home_icon.svg"
        icon.width: 20
        icon.height: 20
        icon.color: Comp.ColorScheme.accentColor.regular
    }

    background: Item {
        id: root
        layer.enabled: true
        layer.samples: 8

        Shape {
            id: shape
            property int radius: Comp.Consts.commonRadius
            anchors.fill: parent
            vendorExtensionsEnabled: false

            ShapePath {
                fillColor: Comp.ColorScheme.primaryColor.regular
                strokeWidth: 0
                strokeColor: Comp.ColorScheme.primaryColor.regular

                startX: shape.radius; startY: 0
                PathLine { x: shape.width - (shape.radius * 2); y: 0 }
                PathArc {
                    x: shape.width - shape.radius; y: shape.radius
                    radiusX: shape.radius; radiusY: shape.radius
                    direction: PathArc.Clockwise

                }
                PathLine { x: shape.width - shape.radius; y: shape.height - shape.radius }
                PathArc {
                    x: shape.width; y: shape.height
                    radiusX: shape.radius; radiusY: shape.radius
                    direction: PathArc.Counterclockwise

                }
                PathLine { x: 0; y: shape.height }
                PathLine { x: 0; y: shape.radius }
                PathArc {
                    x: shape.radius; y: 0
                    radiusX: shape.radius; radiusY: shape.radius
                    direction: PathArc.Clockwise
                }
            }
        }
    }
}
