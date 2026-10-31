import QtQuick

Item {
    id: db

    property bool shown: false
    property string value: ""
    property string caption: ""

    property real pc: 0
    property real pk: 0
    property real tv: 0
    property real tc: 0

    width: 260
    height: 190
    opacity: 0
    scale: 0.9

    onShownChanged: {
        if (shown) {
            hideAnim.stop()
            pc = 0
            pk = 0
            tv = 0
            tc = 0
            scale = 0.9
            showAnim.restart()
        } else {
            showAnim.stop()
            hideAnim.restart()
        }
    }

    ParallelAnimation {
        id: showAnim
        NumberAnimation { target: db; property: "opacity"; to: 1; duration: 500 }
        NumberAnimation { target: db; property: "scale"; to: 1; duration: 900; easing.type: Easing.OutBack }
        SequentialAnimation {
            PauseAnimation { duration: 100 }
            NumberAnimation { target: db; property: "pc"; to: 1; duration: 900; easing.type: Easing.OutCubic }
        }
        SequentialAnimation {
            PauseAnimation { duration: 750 }
            NumberAnimation { target: db; property: "pk"; to: 1; duration: 600; easing.type: Easing.OutCubic }
        }
        SequentialAnimation {
            PauseAnimation { duration: 900 }
            NumberAnimation { target: db; property: "tv"; to: 1; duration: 800; easing.type: Easing.OutCubic }
        }
        SequentialAnimation {
            PauseAnimation { duration: 1100 }
            NumberAnimation { target: db; property: "tc"; to: 1; duration: 800 }
        }
    }

    NumberAnimation { id: hideAnim; target: db; property: "opacity"; to: 0; duration: 500 }

    Canvas {
        id: mark
        width: 88
        height: 88
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0

        property color stroke: theme.acc
        property real pc: db.pc
        property real pk: db.pk

        onStrokeChanged: requestPaint()
        onPcChanged: requestPaint()
        onPkChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.strokeStyle = stroke
            ctx.lineCap = "round"
            ctx.lineJoin = "round"
            if (pc > 0) {
                ctx.lineWidth = 3
                ctx.beginPath()
                ctx.arc(44, 44, 34, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * pc, false)
                ctx.stroke()
            }
            if (pk > 0) {
                var total = 16.97 + 31.89
                var d = pk * total
                ctx.lineWidth = 4.4
                ctx.beginPath()
                ctx.moveTo(28, 45)
                if (d <= 16.97) {
                    var t1 = d / 16.97
                    ctx.lineTo(28 + 12 * t1, 45 + 12 * t1)
                } else {
                    ctx.lineTo(40, 57)
                    var t2 = (d - 16.97) / 31.89
                    ctx.lineTo(40 + 21 * t2, 57 - 24 * t2)
                }
                ctx.stroke()
            }
        }
    }

    Txt {
        id: big
        anchors.horizontalCenter: parent.horizontalCenter
        y: 104
        text: db.value
        font.pixelSize: 46
        font.weight: Font.ExtraLight
        font.letterSpacing: -2.3
        opacity: db.tv
        transform: Translate { y: (1 - db.tv) * 10 }
    }

    Txt {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 162
        text: db.caption
        color: theme.txt2
        font.pixelSize: 14
        opacity: db.tc
    }
}
