import QtQuick

Reveal {
    id: glass

    property real radius: 26
    default property alias inside: inner.data

    Rectangle {
        anchors.fill: parent
        radius: glass.radius
        color: theme.card
        border.width: 1
        border.color: theme.line2
    }

    Item {
        id: inner
        anchors.fill: parent
    }
}
