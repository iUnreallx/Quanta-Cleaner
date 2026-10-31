import QtQuick

Canvas {
    id: lg

    property bool tile: true
    property color accent: theme.acc

    implicitWidth: 64
    implicitHeight: 64

    onAccentChanged: requestPaint()
    onTileChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        if (width < 2)
            return
        var a = accent
        var rad = Math.PI / 180

        function arc(cx, cy, r, startDeg, span, alpha, w) {
            ctx.globalAlpha = alpha
            ctx.lineWidth = w
            ctx.beginPath()
            ctx.arc(cx, cy, r, startDeg * rad, startDeg * rad + span, false)
            ctx.stroke()
        }

        if (tile) {
            var k = width / 64
            ctx.scale(k, k)

            var bg = ctx.createLinearGradient(0, 0, 0, 64)
            bg.addColorStop(0, "#2a2a33")
            bg.addColorStop(1, "#0a0a0d")
            ctx.fillStyle = bg
            ctx.beginPath()
            ctx.roundedRect(0, 0, 64, 64, 18, 18)
            ctx.fill()

            var glow = ctx.createRadialGradient(32, 32, 0, 32, 32, 28)
            glow.addColorStop(0, Qt.rgba(a.r, a.g, a.b, 0.45))
            glow.addColorStop(1, Qt.rgba(a.r, a.g, a.b, 0))
            ctx.fillStyle = glow
            ctx.beginPath()
            ctx.arc(32, 32, 28, 0, Math.PI * 2)
            ctx.fill()

            ctx.lineCap = "round"
            ctx.strokeStyle = a
            arc(32, 32, 17, -90, 40 / 17, 0.35, 8)
            arc(32, 32, 17, -90, 40 / 17, 1, 4.4)
            arc(32, 32, 17, 70.4, 24 / 17, 0.62, 4.4)
            arc(32, 32, 17, 176.5, 19 / 17, 0.34, 4.4)

            ctx.fillStyle = "#ffffff"
            ctx.globalAlpha = 0.35
            ctx.beginPath()
            ctx.arc(44.1, 44, 5, 0, Math.PI * 2)
            ctx.fill()
            ctx.globalAlpha = 1
            ctx.beginPath()
            ctx.arc(44.1, 44, 2.7, 0, Math.PI * 2)
            ctx.fill()
            ctx.beginPath()
            ctx.arc(32, 32, 4.4, 0, Math.PI * 2)
            ctx.fill()

            ctx.globalAlpha = 0.14
            ctx.strokeStyle = "#ffffff"
            ctx.lineWidth = 1.2
            ctx.beginPath()
            ctx.roundedRect(0.6, 0.6, 62.8, 62.8, 17.4, 17.4)
            ctx.stroke()
        } else {
            var m = width / 32
            ctx.scale(m, m)
            ctx.lineCap = "round"
            ctx.strokeStyle = a
            ctx.fillStyle = a
            arc(16, 16, 10.5, -90, 25 / 10.5, 1, 3.2)
            arc(16, 16, 10.5, 70.4, 15 / 10.5, 0.6, 3.2)
            arc(16, 16, 10.5, 176.3, 12 / 10.5, 0.34, 3.2)
            ctx.globalAlpha = 1
            ctx.beginPath()
            ctx.arc(16, 16, 3, 0, Math.PI * 2)
            ctx.fill()
            ctx.beginPath()
            ctx.arc(23.2, 23.6, 2, 0, Math.PI * 2)
            ctx.fill()
        }
    }
}
