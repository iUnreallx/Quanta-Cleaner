import QtQuick

Item {
    id: tg

    property bool checked: false
    signal toggled(bool value)

    width: 50
    height: 30

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: tg.checked ? theme.acc : theme.line2
        Behavior on color { ColorAnimation { duration: 300 } }
    }

    Rectangle {
        id: knob
        y: 3
        width: ma.pressed ? 30 : 24
        height: 24
        radius: 12
        color: "#ffffff"
        x: tg.checked ? tg.width - width - 3 : 3

        Behavior on x {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: 550; easing.type: Easing.OutBack; easing.overshoot: 1.3 }
        }
        Behavior on width {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: 180 }
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: tg.toggled(!tg.checked)
    }
}
