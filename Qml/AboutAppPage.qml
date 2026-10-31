import QtQuick
import QtQuick.Controls

Item {
    id: page

    property bool shown: false
    property real v1: 0
    property real v2: 0
    property real v3: 0

    anchors.fill: parent
    opacity: shown ? 1 : 0
    visible: opacity > 0.01
    Behavior on opacity { NumberAnimation { duration: page.shown ? 0 : 200 } }

    onShownChanged: {
        if (shown) {
            countAnim.stop()
            v1 = 0
            v2 = 0
            v3 = 0
            v1Anim.to = main_window.catCount
            v2Anim.to = quanta_settings.stat_freed
            v3Anim.to = quanta_settings.stat_runs
            countAnim.restart()
        }
    }

    ParallelAnimation {
        id: countAnim
        NumberAnimation { id: v1Anim; target: page; property: "v1"; duration: 900; easing.type: Easing.OutCubic }
        NumberAnimation { id: v2Anim; target: page; property: "v2"; duration: 1400; easing.type: Easing.OutCubic }
        NumberAnimation { id: v3Anim; target: page; property: "v3"; duration: 1100; easing.type: Easing.OutCubic }
    }

    Flickable {
        id: fl
        anchors.fill: parent
        contentWidth: width
        contentHeight: content.height + 90 + 110
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Column {
            id: content
            x: (fl.width - width) / 2
            y: 90
            width: Math.min(560, fl.width - 80)
            spacing: 0

            Reveal {
                width: parent.width
                height: 134
                shown: page.shown
                order: 0

                Item {
                    id: big
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 112
                    height: 112

                    RadialFill {
                        id: halo
                        anchors.centerIn: parent
                        width: 220
                        height: 220
                        rpx: 100
                        stops: [
                            { p: 0, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.42) },
                            { p: 1, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0) }
                        ]
                        SequentialAnimation on opacity {
                            running: page.shown && quanta_settings.settings_animation
                            loops: Animation.Infinite
                            NumberAnimation { to: 0.45; duration: 2000; easing.type: Easing.InOutSine }
                            NumberAnimation { to: 1; duration: 2000; easing.type: Easing.InOutSine }
                        }
                    }

                    QuantaLogo {
                        anchors.fill: parent
                        tile: true
                    }
                }
            }

            Reveal {
                width: parent.width
                height: 60
                shown: page.shown
                order: 1
                Txt {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 6
                    text: "Quanta Cleaner"
                    font.pixelSize: 40
                    font.weight: Font.DemiBold
                    font.letterSpacing: -1.6
                }
            }

            Reveal {
                width: parent.width
                height: 40
                shown: page.shown
                order: 2
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 28
                    width: ver.implicitWidth + 24
                    radius: 14
                    color: "transparent"
                    border.width: 1
                    border.color: theme.line2
                    Text {
                        id: ver
                        anchors.centerIn: parent
                        text: "v1.2.0"
                        color: theme.txt2
                        font.family: theme.monoFamily
                        font.pixelSize: 12
                    }
                }
            }

            Reveal {
                width: parent.width
                height: about.implicitHeight + 30
                shown: page.shown
                order: 3
                Txt {
                    id: about
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 18
                    width: Math.min(420, parent.width)
                    text: str.aboutShort
                    color: theme.txt2
                    font.pixelSize: 15
                    lineHeight: 1.3
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                }
            }

            Item {
                width: parent.width
                height: 18 + 92 + 22

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 18
                    spacing: 12

                    Repeater {
                        model: 3
                        delegate: GlassCard {
                            required property int index
                            readonly property real val: index === 0 ? page.v1 : (index === 1 ? page.v2 : page.v3)
                            readonly property string cap: index === 0 ? str.categories : (index === 1 ? str.mbFreed : str.cleanups)
                            width: (content.width - 24) / 3
                            height: 92
                            radius: 24
                            shown: page.shown
                            order: 4 + index

                            Txt {
                                x: 16
                                y: 14
                                text: Math.round(val).toLocaleString(Qt.locale(), "f", 0)
                                font.pixelSize: 34
                                font.weight: Font.Light
                                font.letterSpacing: -1.7
                            }
                            Txt {
                                x: 16
                                y: 58
                                width: parent.width - 24
                                text: cap
                                color: theme.txt2
                                font.pixelSize: 13
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
            }

            Reveal {
                width: parent.width
                height: 48
                shown: page.shown
                order: 7

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10

                    PillButton {
                        text: "Telegram"
                        iconKind: "send"
                        height: 48
                        onClicked: Qt.openUrlExternally("https://t.me/unreallx")
                    }
                    PillButton {
                        text: "GitHub"
                        iconSource: "assets/images/github_white.png"
                        height: 48
                        onClicked: Qt.openUrlExternally("https://github.com/iUnreallx/Quanta-Cleaner")
                    }
                }
            }
        }
    }
}
