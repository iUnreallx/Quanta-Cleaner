import QtQuick

Item {
    id: rv

    property int order: 0
    property bool shown: true
    readonly property bool animate: quanta_settings.settings_animation
    property real lift: shown ? 0 : 14

    opacity: shown ? 1 : 0
    scale: shown ? 1 : 0.985
    transform: Translate { y: rv.lift }

    Behavior on opacity {
        enabled: rv.animate
        SequentialAnimation {
            PauseAnimation { duration: rv.shown ? 140 + rv.order * 55 : 0 }
            NumberAnimation { duration: rv.shown ? 700 : 250; easing.type: Easing.OutCubic }
        }
    }
    Behavior on scale {
        enabled: rv.animate
        SequentialAnimation {
            PauseAnimation { duration: rv.shown ? 140 + rv.order * 55 : 0 }
            NumberAnimation { duration: rv.shown ? 900 : 250; easing.type: Easing.OutQuint }
        }
    }
    Behavior on lift {
        enabled: rv.animate
        SequentialAnimation {
            PauseAnimation { duration: rv.shown ? 140 + rv.order * 55 : 0 }
            NumberAnimation { duration: rv.shown ? 900 : 250; easing.type: Easing.OutQuint }
        }
    }
}
