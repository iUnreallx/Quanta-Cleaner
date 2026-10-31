import QtQuick

Rectangle {
    id: dock

    property string current: "main"
    signal go(string page)

    readonly property var items: [
        { id: "main", icon: "overview", label: str.navOverview },
        { id: "params", icon: "grid", label: str.navClean },
        { id: "settings", icon: "sliders", label: str.navSettings },
        { id: "about", icon: "info", label: str.navAbout }
    ]

    height: 58
    width: row.width + 12
    radius: height / 2
    color: theme.card
    border.width: 1
    border.color: theme.line2

    Row {
        id: row
        x: 6
        y: 6
        spacing: 4

        Repeater {
            model: dock.items

            delegate: Item {
                id: it
                required property var modelData
                readonly property bool active: dock.current === modelData.id
                readonly property bool hot: ma.containsMouse

                height: 46
                width: active ? 13 + 20 + 9 + lb.implicitWidth + 15 : 46
                clip: true

                Behavior on width {
                    enabled: quanta_settings.settings_animation
                    NumberAnimation { duration: 700; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.16, 1, 0.3, 1, 1, 1] }
                }

                scale: ma.pressed ? 0.93 : 1
                Behavior on scale {
                    enabled: quanta_settings.settings_animation
                    NumberAnimation { duration: ma.pressed ? 100 : 500; easing.type: Easing.OutBack }
                }

                Rectangle {
                    anchors.fill: parent
                    radius: height / 2
                    color: it.active ? theme.acc : (it.hot ? theme.line : "transparent")
                    Behavior on color { ColorAnimation { duration: 300 } }
                }

                Ico {
                    x: 13
                    anchors.verticalCenter: parent.verticalCenter
                    width: 20
                    height: 20
                    kind: it.modelData.icon
                    color: it.active ? theme.ink : (it.hot ? theme.txt : theme.txt2)
                }

                Txt {
                    id: lb
                    x: 42
                    anchors.verticalCenter: parent.verticalCenter
                    text: it.modelData.label
                    color: theme.ink
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    opacity: it.active ? 1 : 0
                    Behavior on opacity {
                        enabled: quanta_settings.settings_animation
                        SequentialAnimation {
                            PauseAnimation { duration: it.active ? 120 : 0 }
                            NumberAnimation { duration: 350 }
                        }
                    }
                }

                MouseArea {
                    id: ma
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: dock.go(it.modelData.id)
                }
            }
        }
    }
}
