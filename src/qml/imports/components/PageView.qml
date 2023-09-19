import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import components as Comp

Comp.Pane {
    background: Item {
        Shape {
            id: shape
            property int radius: 15
            anchors.fill: parent
            vendorExtensionsEnabled: false
            smooth: true
            antialiasing: true

            ShapePath {
                fillColor: Comp.ColorScheme.primaryColor.regular
                strokeWidth: 0
                strokeColor: Comp.ColorScheme.primaryColor.regular

                startX: 0; startY: 0
                PathLine { x: shape.width - shape.radius; y: 0 }
                PathArc {
                    x: shape.width; y: shape.radius
                    radiusX: shape.radius; radiusY: shape.radius
                    direction: PathArc.Clockwise

                }
                PathLine { x: shape.width; y: shape.height - shape.radius }
                PathArc {
                    x: shape.width - shape.radius; y: shape.height
                    radiusX: shape.radius; radiusY: shape.radius
                    direction: PathArc.Clockwise
                }
                PathLine { x: shape.radius; y: shape.height }
                PathArc {
                    x: 0; y: shape.height - shape.radius
                    radiusX: shape.radius; radiusY: shape.radius
                    direction: PathArc.Clockwise
                }
                PathLine { x: 0; y: 0 }
            }
        }
    }
}
