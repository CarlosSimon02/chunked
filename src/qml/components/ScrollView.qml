import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T

import components.impl as Impl

Impl.ScrollView {
    id: scrollView

    TapHandler {
        onTapped: scrollView.focus = false
    }
}
