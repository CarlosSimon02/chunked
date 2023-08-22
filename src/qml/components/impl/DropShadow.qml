import QtQuick
import Qt5Compat.GraphicalEffects as Ge

import components as Comp

Ge.DropShadow {
    spread: 0.2
    radius: 10
    samples: 17
    color: Comp.ColorScheme.primaryColor.shadow
}
