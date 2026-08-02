import QtQuick 2.12

Item {
    id: root

    // Configurable properties
    property int edgeWidth: 36        // used when anchoring only to left edge
    property bool vertical: false    // set true for vertical swipe detection
    property int minDistance: 120    // minimum swipe distance to trigger
    property int maxOrthogonal: 80   // max orthogonal movement allowed

    // If placed with anchors.fill: parent the component will cover whole area.
    // Otherwise it can be anchored to an edge (left) and act like before.

    DragHandler {
        id: drag
        target: root
        // axis will be set dynamically in onActiveChanged depending on 'vertical'
        axis: vertical ? DragHandler.YAxis : DragHandler.XAxis
        // generous bounds
        minimumX: -parent.width
        maximumX: parent.width
        minimumY: -parent.height
        maximumY: parent.height

        onReleased: {
            var dx = drag.translation.x
            var dy = drag.translation.y
            if (vertical) {
                // swipe down
                if (dy > minDistance && Math.abs(dx) < maxOrthogonal) {
                    if (mainView !== undefined) {
                        console.debug("SearchSwipeArea | Vertical swipe detected, opening Springboard search")
                        mainView.updateSpringboard("")
                    }
                }
            } else {
                // swipe right
                if (dx > minDistance && Math.abs(dy) < maxOrthogonal) {
                    if (mainView !== undefined) {
                        console.debug("SearchSwipeArea | Horizontal swipe detected, opening Springboard search")
                        mainView.updateSpringboard("")
                    }
                }
            }
        }
    }

    // Keep transparent and non-intrusive by default
    Rectangle {
        anchors.fill: parent
        color: "transparent"
    }
}
