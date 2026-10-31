import QtQuick

Canvas {
    id: ic

    property string kind: "check"
    property color color: theme.txt
    property real lw: 1.8
    property real progress: 1

    implicitWidth: 20
    implicitHeight: 20

    onColorChanged: requestPaint()
    onKindChanged: requestPaint()
    onLwChanged: requestPaint()
    onProgressChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        if (width < 2 || height < 2)
            return
        var s = Math.min(width, height) / 24
        ctx.scale(s, s)
        ctx.strokeStyle = color
        ctx.fillStyle = color
        ctx.lineWidth = lw
        ctx.lineCap = "round"
        ctx.lineJoin = "round"

        function line(x1, y1, x2, y2) {
            ctx.beginPath()
            ctx.moveTo(x1, y1)
            ctx.lineTo(x2, y2)
            ctx.stroke()
        }
        function circ(x, y, r) {
            ctx.beginPath()
            ctx.arc(x, y, r, 0, Math.PI * 2)
            ctx.stroke()
        }
        function dot(x, y, r) {
            ctx.beginPath()
            ctx.arc(x, y, r, 0, Math.PI * 2)
            ctx.fill()
        }
        function poly(pts, close) {
            ctx.beginPath()
            ctx.moveTo(pts[0][0], pts[0][1])
            for (var i = 1; i < pts.length; ++i)
                ctx.lineTo(pts[i][0], pts[i][1])
            if (close)
                ctx.closePath()
            ctx.stroke()
        }
        function rrect(x, y, w, h, r) {
            ctx.beginPath()
            ctx.roundedRect(x, y, w, h, r, r)
            ctx.stroke()
        }

        switch (kind) {
        case "overview":
            circ(12, 12, 8.5)
            circ(12, 12, 3)
            break
        case "grid":
            rrect(3.5, 3.5, 7, 7, 2)
            rrect(13.5, 3.5, 7, 7, 2)
            rrect(3.5, 13.5, 7, 7, 2)
            rrect(13.5, 13.5, 7, 7, 2)
            break
        case "sliders":
            line(4, 7, 13, 7)
            line(17, 7, 20, 7)
            line(4, 17, 7, 17)
            line(11, 17, 20, 17)
            circ(15, 7, 2)
            circ(9, 17, 2)
            break
        case "info":
            circ(12, 12, 8.5)
            line(12, 11, 12, 16)
            dot(12, 8, 1.1)
            break
        case "arrow":
            line(5, 12, 19, 12)
            poly([[13, 6], [19, 12], [13, 18]], false)
            break
        case "check":
            var total = 6.364 + 13.435
            var d = progress * total
            if (d <= 0)
                break
            ctx.beginPath()
            ctx.moveTo(5, 12.5)
            if (d <= 6.364) {
                var t1 = d / 6.364
                ctx.lineTo(5 + 4.5 * t1, 12.5 + 4.5 * t1)
            } else {
                ctx.lineTo(9.5, 17)
                var t2 = (d - 6.364) / 13.435
                ctx.lineTo(9.5 + 9.5 * t2, 17 - 9.5 * t2)
            }
            ctx.stroke()
            break
        case "globe":
            circ(12, 12, 9)
            line(3, 12, 21, 12)
            ctx.beginPath()
            ctx.moveTo(12, 3)
            ctx.bezierCurveTo(15, 6.2, 15, 17.8, 12, 21)
            ctx.stroke()
            ctx.beginPath()
            ctx.moveTo(12, 3)
            ctx.bezierCurveTo(9, 6.2, 9, 17.8, 12, 21)
            ctx.stroke()
            break
        case "spark":
            poly([[12, 3], [13.9, 8.1], [19, 10], [13.9, 11.9], [12, 17], [10.1, 11.9], [5, 10], [10.1, 8.1]], true)
            line(19, 3, 19, 7)
            line(17, 5, 21, 5)
            break
        case "power":
            line(12, 3, 12, 11)
            ctx.beginPath()
            ctx.arc(12, 12, 8, -Math.PI * 0.75, -Math.PI * 0.25, true)
            ctx.stroke()
            break
        case "bell":
            ctx.beginPath()
            ctx.moveTo(6, 16)
            ctx.lineTo(6, 11)
            ctx.arc(12, 11, 6, Math.PI, 0, false)
            ctx.lineTo(18, 16)
            ctx.lineTo(19.5, 18)
            ctx.lineTo(4.5, 18)
            ctx.closePath()
            ctx.stroke()
            line(10, 21, 14, 21)
            break
        case "code":
            poly([[8, 8], [4, 12], [8, 16]], false)
            poly([[16, 8], [20, 12], [16, 16]], false)
            line(13.5, 5, 10.5, 19)
            break
        case "send":
            line(21, 3, 10, 14)
            poly([[21, 3], [14, 21], [10, 13], [2, 9]], true)
            break
        case "copy":
            ctx.beginPath()
            ctx.moveTo(5, 15)
            ctx.lineTo(5, 6.5)
            ctx.quadraticCurveTo(5, 4, 7.5, 4)
            ctx.lineTo(15, 4)
            ctx.stroke()
            rrect(9, 9, 11, 11, 2.5)
            break
        case "play":
            poly([[8, 5.5], [19, 12], [8, 18.5]], true)
            break
        case "eye":
            ctx.beginPath()
            ctx.moveTo(2.5, 12)
            ctx.bezierCurveTo(5, 7.5, 8.5, 5.5, 12, 5.5)
            ctx.bezierCurveTo(15.5, 5.5, 19, 7.5, 21.5, 12)
            ctx.bezierCurveTo(19, 16.5, 15.5, 18.5, 12, 18.5)
            ctx.bezierCurveTo(8.5, 18.5, 5, 16.5, 2.5, 12)
            ctx.closePath()
            ctx.stroke()
            circ(12, 12, 3)
            break
        case "trash":
            line(4, 7, 20, 7)
            line(10, 11, 10, 17)
            line(14, 11, 14, 17)
            ctx.beginPath()
            ctx.moveTo(6, 7)
            ctx.lineTo(7, 19)
            ctx.quadraticCurveTo(7, 21, 9, 21)
            ctx.lineTo(15, 21)
            ctx.quadraticCurveTo(17, 21, 17, 19)
            ctx.lineTo(18, 7)
            ctx.stroke()
            poly([[9, 7], [9, 4], [15, 4], [15, 7]], false)
            break
        case "folder":
            poly([[3, 6.5], [9, 6.5], [11, 8.5], [21, 8.5], [21, 19], [3, 19]], true)
            break
        case "x":
            line(6, 6, 18, 18)
            line(18, 6, 6, 18)
            break
        case "dots":
            dot(6, 12, 1.5)
            dot(12, 12, 1.5)
            dot(18, 12, 1.5)
            break
        default:
            break
        }
    }
}
