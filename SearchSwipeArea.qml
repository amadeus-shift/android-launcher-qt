import QtQuick 2.12

Item {
    id: root
    // narrow left-edge gesture area so it doesn't block normal interaction
    property int edgeWidth: 36
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: edgeWidth

    // visual debugging (disabled by default)
    // Rectangle { anchors.fill: parent; color: "#00ff00"; opacity: 0.0 }

    DragHandler {
        id: drag
        target: root
        axis: DragHandler.XAxis
        minimumX: -parent.width
        maximumX: parent.width
        onReleased: {
            // require a right swipe of at least 120px and not much vertical movement
            var dx = drag.translation.x
            var dy = drag.translation.y
            if (dx > 120 && Math.abs(dy) < 80) {
                if (mainView !== undefined) {
                    console.debug("SearchSwipeArea | Swipe detected, opening Springboard search")
                    mainView.updateSpringboard("")
                }
            }
        }
    }
}
