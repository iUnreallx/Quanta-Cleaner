import QtQuick

Item {
    id: nb

    property string title: ""
    property string body: ""
    property string leftText: ""
    property string rightText: ""
    property bool rich: false
    property var segs: []

    property bool on: false
    property real ringP: 0
    property real checkP: 0
    property real barT: 0
    property real iconK: 0
    property real dragDy: 0
    property bool dragging: false

    readonly property bool animate: quanta_settings.settings_animation
    readonly property real cardH: 15 + row1.height + (rich ? 15 + 9 + 9 + footer.height : 0) + 15

    width: Math.min(396, (parent ? parent.width : 400) * 0.94)
    height: cardH
    x: parent ? (parent.width - width) / 2 : 0
    y: -height - 60
    z: 95
    visible: opacity > 0.01
    opacity: 0
    scale: 0.9

    transform: Translate { y: nb.dragDy }

    Behavior on dragDy {
        enabled: !nb.dragging
        NumberAnimation { duration: 400; easing.type: Easing.OutBack }
    }

    function present(t, b, isRich, l, r, s) {
        hideTimer.stop()
        hideAnim.stop()
        title = t
        body = b
        rich = isRich
        leftText = l || ""
        rightText = r || ""
        segs = s || []
        dragDy = 0
        ringP = 0
        checkP = 0
        barT = 0
        iconK = 0
        on = false
        y = -height - 40
        scale = 0.9
        opacity = 0
        enterDelay.restart()
    }

    function hide() {
        hideTimer.stop()
        enterAnim.stop()
        on = false
        hideAnim.restart()
    }

    Timer {
        id: enterDelay
        interval: 30
        onTriggered: {
            nb.on = true
            enterAnim.restart()
            hideTimer.interval = nb.rich ? 4600 : 3200
            hideTimer.restart()
        }
    }

    Timer {
        id: hideTimer
        onTriggered: nb.hide()
    }

    ParallelAnimation {
        id: enterAnim
        NumberAnimation { target: nb; property: "y"; to: 10; duration: nb.animate ? 900 : 1; easing.type: Easing.OutBack; easing.overshoot: 1.15 }
        NumberAnimation { target: nb; property: "scale"; to: 1; duration: nb.animate ? 900 : 1; easing.type: Easing.OutBack; easing.overshoot: 1.15 }
        NumberAnimation { target: nb; property: "opacity"; to: 1; duration: 350 }
        SequentialAnimation {
            PauseAnimation { duration: 200 }
            NumberAnimation { target: nb; property: "iconK"; to: 1; duration: nb.animate ? 900 : 1; easing.type: Easing.OutBack; easing.overshoot: 1.5 }
        }
        SequentialAnimation {
            PauseAnimation { duration: 400 }
            NumberAnimation { target: nb; property: "ringP"; to: 1; duration: nb.animate ? 1100 : 1; easing.type: Easing.OutCubic }
        }
        SequentialAnimation {
            PauseAnimation { duration: 1150 }
            NumberAnimation { target: nb; property: "checkP"; to: 1; duration: nb.animate ? 500 : 1; easing.type: Easing.OutCubic }
        }
        SequentialAnimation {
            PauseAnimation { duration: 550 }
            NumberAnimation { target: nb; property: "barT"; to: 1; duration: nb.animate ? 1600 : 1 }
        }
    }

    ParallelAnimation {
        id: hideAnim
        NumberAnimation { target: nb; property: "y"; to: -nb.height - 50; duration: 500; easing.type: Easing.InCubic }
        NumberAnimation { target: nb; property: "scale"; to: 0.94; duration: 500 }
        NumberAnimation { target: nb; property: "opacity"; to: 0; duration: 350 }
    }

    Rectangle {
        id: s2
        width: parent.width
        height: nb.cardH
        radius: 30
        color: theme.card
        border.width: 0.5
        border.color: theme.line2
        opacity: nb.on ? 0.4 : 0
        scale: nb.on ? 0.88 : 0.9
        y: nb.on ? 19 : 0
        Behavior on opacity { SequentialAnimation { PauseAnimation { duration: 120 } NumberAnimation { duration: 500 } } }
        Behavior on scale { SequentialAnimation { PauseAnimation { duration: 120 } NumberAnimation { duration: 700; easing.type: Easing.OutBack } } }
        Behavior on y { SequentialAnimation { PauseAnimation { duration: 120 } NumberAnimation { duration: 700; easing.type: Easing.OutBack } } }
    }

    Rectangle {
        id: s1
        width: parent.width
        height: nb.cardH
        radius: 30
        color: theme.card
        border.width: 0.5
        border.color: theme.line2
        opacity: nb.on ? 0.75 : 0
        scale: nb.on ? 0.94 : 0.9
        y: nb.on ? 10 : 0
        Behavior on opacity { SequentialAnimation { PauseAnimation { duration: 120 } NumberAnimation { duration: 500 } } }
        Behavior on scale { SequentialAnimation { PauseAnimation { duration: 120 } NumberAnimation { duration: 700; easing.type: Easing.OutBack } } }
        Behavior on y { SequentialAnimation { PauseAnimation { duration: 120 } NumberAnimation { duration: 700; easing.type: Easing.OutBack } } }
    }

    Rectangle {
        id: card
        width: parent.width
        height: nb.cardH
        radius: 30
        color: Qt.rgba(theme.surface.r, theme.surface.g, theme.surface.b, 0.96)
        border.width: 0.5
        border.color: theme.line2

        RadialFill {
            anchors.fill: parent
            clipRadius: 30
            cx: 0.16
            cy: 0
            rx: 0.62
            ry: 130 / Math.max(1, nb.cardH)
            stops: [
                { p: 0, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.32) },
                { p: 1, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0) }
            ]
        }

        Item {
            id: row1
            x: 15
            y: 15
            width: parent.width - 32
            height: Math.max(46, textCol.height)

            Item {
                id: icon
                width: 46
                height: 46
                scale: 0.3 + 0.7 * nb.iconK
                rotation: -24 * (1 - nb.iconK)
                opacity: Math.min(1, nb.iconK * 2)

                QuantaLogo {
                    anchors.fill: parent
                    tile: true
                }
            }

            Column {
                id: textCol
                x: 59
                width: parent.width - 59 - (nb.rich ? 55 : 0)
                spacing: 2

                Item {
                    width: parent.width
                    height: 16

                    Txt {
                        text: "QUANTA"
                        color: theme.txt3
                        font.pixelSize: 12
                        font.weight: Font.Medium
                        font.letterSpacing: 0.4
                    }
                    Txt {
                        anchors.right: parent.right
                        text: str.now
                        color: theme.txt3
                        font.pixelSize: 12
                        font.weight: Font.Medium
                    }
                }

                Txt {
                    width: parent.width
                    text: nb.title
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                    font.letterSpacing: -0.2
                    elide: Text.ElideRight
                }

                Txt {
                    visible: text !== ""
                    width: parent.width
                    text: nb.body
                    color: theme.txt2
                    font.pixelSize: 15
                    wrapMode: Text.Wrap
                    maximumLineCount: 3
                    elide: Text.ElideRight
                }
            }

            Canvas {
                id: ring
                visible: nb.rich
                width: 42
                height: 42
                x: parent.width - width
                y: 2

                property color stroke: theme.acc
                property color track: theme.line2
                property real p: nb.ringP

                onStrokeChanged: requestPaint()
                onTrackChanged: requestPaint()
                onPChanged: requestPaint()

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    ctx.lineWidth = 3.5
                    ctx.lineCap = "round"
                    ctx.strokeStyle = track
                    ctx.beginPath()
                    ctx.arc(21, 21, 18, 0, Math.PI * 2)
                    ctx.stroke()
                    if (p > 0) {
                        ctx.strokeStyle = stroke
                        ctx.beginPath()
                        ctx.arc(21, 21, 18, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * p, false)
                        ctx.stroke()
                    }
                }

                Ico {
                    anchors.centerIn: parent
                    width: 19
                    height: 19
                    kind: "check"
                    lw: 3.2
                    color: theme.acc
                    progress: nb.checkP
                }
            }
        }

        Row {
            id: bar
            visible: nb.rich
            x: 15
            y: 15 + row1.height + 15
            width: parent.width - 30
            height: 9
            spacing: 3

            readonly property real totalG: {
                var s = 0
                for (var i = 0; i < nb.segs.length; ++i)
                    s += nb.segs[i].g
                return s > 0 ? s : 1
            }

            Repeater {
                model: nb.segs
                delegate: Rectangle {
                    id: seg
                    required property int index
                    required property var modelData
                    readonly property real local: Math.max(0, Math.min(1, (nb.barT * 1600 - index * 70) / 800))
                    width: Math.max(4, (bar.width - (nb.segs.length - 1) * 3) * modelData.g / bar.totalG)
                    height: 9
                    radius: 4.5
                    color: theme.acc
                    opacity: modelData.o
                    transform: Scale { origin.x: 0; xScale: 1 - Math.pow(1 - seg.local, 3) }
                }
            }
        }

        Item {
            id: footer
            visible: nb.rich
            x: 15
            y: 15 + row1.height + 15 + 9 + 9
            width: parent.width - 30
            height: 18

            Txt {
                text: nb.leftText
                color: theme.txt2
                font.pixelSize: 13
                anchors.verticalCenter: parent.verticalCenter
            }
            Txt {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: nb.rightText
                color: theme.acc
                font.pixelSize: 15
                font.weight: Font.DemiBold
                font.letterSpacing: -0.3
            }
        }

        HoverHandler {
            id: hh
            onHoveredChanged: {
                if (!nb.on)
                    return
                if (hovered)
                    hideTimer.stop()
                else
                    hideTimer.restart()
            }
        }

        DragHandler {
            id: dh
            target: null
            xAxis.enabled: false
            cursorShape: Qt.PointingHandCursor
            onActiveChanged: {
                if (active) {
                    nb.dragging = true
                    hideTimer.stop()
                } else {
                    nb.dragging = false
                    if (nb.dragDy < -24) {
                        nb.hide()
                    } else {
                        nb.dragDy = 0
                        hideTimer.interval = 2600
                        hideTimer.restart()
                    }
                }
            }
            onTranslationChanged: {
                if (active)
                    nb.dragDy = Math.min(14, translation.y)
            }
        }
    }
}
