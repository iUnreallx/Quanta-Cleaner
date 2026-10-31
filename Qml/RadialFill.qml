import QtQuick

Canvas {
    id: c

    property var stops: []
    property real cx: 0.5
    property real cy: 0.5
    property real rx: 0.7
    property real ry: 0.7
    property real rpx: 0
    property real clipRadius: 0

    onStopsChanged: requestPaint()
    onCxChanged: requestPaint()
    onCyChanged: requestPaint()
    onRxChanged: requestPaint()
    onRyChanged: requestPaint()
    onRpxChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        if (width < 2 || height < 2 || stops.length < 2)
            return
        var sx = rpx > 0 ? rpx : rx * width
        var sy = rpx > 0 ? rpx : ry * height
        if (sx < 1 || sy < 1)
            return
        if (clipRadius > 0) {
            ctx.beginPath()
            ctx.roundedRect(0, 0, width, height, clipRadius, clipRadius)
            ctx.clip()
        }
        ctx.save()
        ctx.translate(cx * width, cy * height)
        ctx.scale(sx, sy)
        var g = ctx.createRadialGradient(0, 0, 0, 0, 0, 1)
        for (var i = 0; i < stops.length; ++i)
            g.addColorStop(stops[i].p, stops[i].c)
        ctx.fillStyle = g
        ctx.fillRect(-cx * width / sx, -cy * height / sy, width / sx, height / sy)
        ctx.restore()
    }
}
