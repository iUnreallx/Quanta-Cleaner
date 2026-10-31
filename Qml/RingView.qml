import QtQuick

Item {
    id: ring

    property bool mainMode: true          // true - главная страница, false - тусклый фон других страниц
    property bool animOn: true
    property bool darkMode: theme.dark
    property string phase: "idle"         // idle | run | done
    property real prog: 0                 // 0..1 - прогресс очистки
    property var weights: []              // «вес» категории (МБ или минимум)
    property var catOn: []              // включена ли категория
    property var bands: []                // [старт, конец] участка прогресса категории, или null
    property color acc: theme.acc
    property color dotCol: theme.dot
    property color dimCol: theme.txt3

    property int hoverIdx: -1
    property bool centerHover: false
    readonly property real baseRadius: Math.max(90, Math.min(width * 0.28, height * 0.245, height * 0.45 - 142))

    signal categoryClicked(int idx)
    signal centerClicked()

    readonly property real tau: Math.PI * 2
    readonly property real stub: 0.018
    readonly property int particleCount: 600

    property var st: ({
        shake: 0, pulse: 0, breath: 0, hcv: 0, doneT: -1,
        mx: -1e4, my: -1e4,
        tI: Date.now(), last: Date.now(),
        cp: [], sparks: [], rings: [], lay: [],
        explode: false,
        geo: { cx: 0, cy: 0, R: 100 },
        S: { x: 0.5, y: 0.46, s: 1, a: 1 }
    })

    function ez(t) { return 1 - Math.pow(1 - t, 3) }
    function ezio(t) { return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2 }
    function clamp(v, a, b) { return Math.max(a, Math.min(b, v)) }
    function rgba(c, a) { return Qt.rgba(c.r, c.g, c.b, a) }

    function relayout() {
        var n = catOn.length
        var tot = 0
        var offN = 0
        var i
        for (i = 0; i < n; ++i) {
            if (catOn[i])
                tot += weights[i] || 0
            else
                offN++
        }
        if (tot <= 0)
            tot = 1
        var rest = 1 - offN * stub
        var a = 0
        var lay = []
        for (i = 0; i < n; ++i) {
            var len = catOn[i] ? (weights[i] || 0) / tot * rest : stub
            lay.push({ i: i, a0: a, len: len })
            a += len
        }
        st.lay = lay
    }

    function initP(regrow) {
        var cp = st.cp
        var i
        if (!(regrow && cp.length)) {
            cp = []
            for (i = 0; i < particleCount; ++i) {
                cp.push({
                    a: Math.random() * tau, r: 1.2 + Math.random(),
                    w: (Math.random() < 0.5 ? -1 : 1) * (0.0005 + Math.random() * 0.0016),
                    cat: -1, state: 0, g: 1, q: 0, r0: 0,
                    sz: 0.6 + Math.random() * 1.1, dl: Math.random(),
                    key: 0, lx: NaN, ly: NaN
                })
            }
            st.cp = cp
        }
        for (i = 0; i < cp.length; ++i) {
            cp[i].cat = -1
            cp[i].state = 0
        }
        var idx = []
        for (i = 0; i < cp.length; ++i)
            idx.push(i)
        idx.sort(function () { return Math.random() - 0.5 })
        var sumAll = 0
        for (i = 0; i < weights.length; ++i)
            sumAll += weights[i] || 0
        if (sumAll <= 0)
            sumAll = 1
        var k = 0
        for (i = 0; i < weights.length; ++i) {
            var n = Math.max(8, Math.round(340 * (particleCount / 720) * (weights[i] || 0) / sumAll))
            for (var j = 0; j < n && k < idx.length; ++j, ++k) {
                var p = cp[idx[k]]
                p.cat = i
                p.g = regrow ? 0 : 1
                p.key = Math.random()
            }
        }
    }

    function curCat() {
        for (var i = 0; i < bands.length; ++i) {
            var b = bands[i]
            if (b && prog >= b[0] && prog < b[1])
                return i
        }
        return -1
    }

    function headFrac() {
        if (phase === "done")
            return 1
        if (phase !== "run")
            return 0
        var i = curCat()
        if (i < 0)
            return 1
        var b = bands[i]
        var f = (prog - b[0]) / (b[1] - b[0])
        var L = st.lay[i]
        return L.a0 + L.len * f
    }

    function computeHover() {
        var hv = -1
        var ch = false
        if (mainMode && st.mx > -1e3 && phase === "idle") {
            var g = st.geo
            var dx = st.mx - g.cx
            var dy = st.my - g.cy
            var d = Math.sqrt(dx * dx + dy * dy)
            if (d < g.R * 0.84) {
                ch = true
            } else if (Math.abs(d - g.R) < 26) {
                var a = Math.atan2(dy, dx) + Math.PI / 2
                if (a < 0)
                    a += tau
                var f = a / tau
                for (var i = 0; i < st.lay.length; ++i) {
                    var L = st.lay[i]
                    if (f >= L.a0 && f < L.a0 + L.len) {
                        hv = L.i
                        break
                    }
                }
            }
        }
        if (hv !== hoverIdx)
            hoverIdx = hv
        if (ch !== centerHover)
            centerHover = ch
    }

    function pointer(x, y) {
        st.mx = x
        st.my = y
        computeHover()
        if (!fa.running)
            cv.requestPaint()
    }

    function explodeAt(cx, cy, Rr) {
        var sp = st.sparks
        var lay = st.lay
        for (var q = 0; q < lay.length; ++q) {
            var L = lay[q]
            if (!catOn[L.i])
                continue
            var n = Math.round(L.len * 130)
            for (var k = 0; k < n; ++k) {
                var a = (L.a0 + Math.random() * L.len) * tau - Math.PI / 2
                var s = 1.5 + Math.random() * 7
                var tg = (Math.random() - 0.5) * 2
                sp.push({
                    x: cx + Math.cos(a) * Rr, y: cy + Math.sin(a) * Rr,
                    vx: Math.cos(a) * s - Math.sin(a) * tg, vy: Math.sin(a) * s + Math.cos(a) * tg,
                    l: 1, dl: 0.006 + Math.random() * 0.012, sz: 0.8 + Math.random() * 2.2,
                    g: 0.02, white: Math.random() < 0.3, str: true, tw: undefined
                })
            }
        }
        for (var m = 0; m < 120; ++m) {
            sp.push({
                x: Math.random() * width, y: height * (0.2 + Math.random() * 0.9),
                vx: (Math.random() - 0.5) * 0.3, vy: -(0.15 + Math.random() * 0.5),
                l: 1, dl: 0.003 + Math.random() * 0.005, sz: 0.7 + Math.random() * 1.8,
                g: -0.001, white: Math.random() < 0.5, str: false, tw: Math.random() * 6
            })
        }
    }

    function frame(ctx, W, H) {
        var now = Date.now()
        var dt = Math.min(0.05, Math.max(0.001, (now - st.last) / 1000))
        st.last = now
        var f = dt * 60
        ctx.clearRect(0, 0, W, H)
        if (W < 10 || H < 10)
            return

        var acc = ring.acc
        var dotC = ring.dotCol
        var dimC = ring.dimCol
        var isDark = ring.darkMode
        var prg = ring.prog
        var ph = ring.phase

        var saved = false
        if (st.shake > 0.25 && animOn) {
            ctx.save()
            saved = true
            ctx.translate((Math.random() - 0.5) * st.shake, (Math.random() - 0.5) * st.shake)
        }

        var ti = (now - st.tI) / 1000
        var I = animOn ? ti : 9
        var S = st.S
        var tgt = mainMode ? { x: 0.5, y: 0.46, s: 1, a: 1 } : { x: 0.5, y: 0.5, s: 1.55, a: 0.13 }
        var k6 = animOn ? 1 - Math.pow(1 - 0.06, f) : 1
        S.x += (tgt.x - S.x) * k6
        S.y += (tgt.y - S.y) * k6
        S.s += (tgt.s - S.s) * k6
        S.a += (tgt.a - S.a) * k6
        st.breath *= Math.pow(0.94, f)
        st.pulse *= Math.pow(0.95, f)

        var ia = Math.min(1, ti * 1.2)
        var mx = st.mx
        var my = st.my
        var par = 0
        var par2 = 0
        var cx = W * S.x + par
        var cy = H * S.y + par2
        var Rr = baseRadius * S.s * (1 + st.breath * 0.035 + st.pulse * 0.012)
        st.geo = { cx: cx - par, cy: cy - par2, R: Rr }
        var LW = 7 + st.pulse * 3
        var GAP = 0.07
        var head = headFrac()
        if (st.doneT >= 0)
            st.doneT += dt

        computeHover()
        var hover = hoverIdx
        var ctrHover = centerHover
        st.hcv += ((ctrHover ? 1 : 0) - st.hcv) * (animOn ? 1 - Math.pow(1 - 0.12, f) : 1)

        var lay = st.lay
        var i

        if (st.hcv > 0.01) {
            var g0 = ctx.createRadialGradient(cx, cy, 0, cx, cy, Rr * 0.84)
            g0.addColorStop(0, acc)
            g0.addColorStop(1, rgba(acc, 0))
            ctx.globalAlpha = 0.16 * st.hcv * S.a
            ctx.fillStyle = g0
            ctx.beginPath()
            ctx.arc(cx, cy, Rr * 0.84, 0, tau)
            ctx.fill()
        }

        if (hover >= 0 && lay[hover]) {
            var HL = lay[hover]
            var h0 = HL.a0 * tau - Math.PI / 2
            var h1 = (HL.a0 + HL.len) * tau - Math.PI / 2
            ctx.globalAlpha = 0.12 * S.a
            ctx.fillStyle = acc
            ctx.beginPath()
            ctx.arc(cx, cy, Rr * 1.28, h0, h1, false)
            ctx.arc(cx, cy, Rr * 0.84, h1, h0, true)
            ctx.closePath()
            ctx.fill()
        }

        var NT = 120
        var RT = Rr * 1.2
        ctx.lineCap = "round"
        for (i = 0; i < NT; ++i) {
            var fr = i / NT
            var ang = fr * tau - Math.PI / 2
            var c = Math.cos(ang)
            var s = Math.sin(ang)
            var appear = clamp((I * 1.1 - fr * 0.9) / 0.3, 0, 1)
            if (appear <= 0)
                continue
            var br = 0.2
            var len = 5
            if (ph === "idle") {
                var cf = (now / 1000 * 0.12) % 1
                var dd = (cf - fr + 1) % 1
                if (dd < 0.14) {
                    var kk = 1 - dd / 0.14
                    br += kk * 0.75
                    len += kk * 7
                }
            }
            if (ph === "run") {
                if (fr <= head) {
                    br = 0.8
                    len = 9
                }
                var d2 = Math.abs(fr - head)
                if (d2 < 0.04) {
                    var k2 = 1 - d2 / 0.04
                    br = Math.max(br, 0.5 + k2 * 0.5)
                    len += k2 * 8
                }
            }
            if (ph === "done" || st.doneT >= 0) {
                var w = st.doneT * 0.9 - fr * 0.9
                if (w > 0 && w < 0.7) {
                    var k3 = Math.sin(w / 0.7 * Math.PI)
                    br = Math.max(0.35, k3)
                    len += k3 * 10
                } else {
                    br = Math.max(br, 0.38)
                }
            }
            if (hover >= 0 && lay[hover]) {
                var HH = lay[hover]
                if (fr >= HH.a0 && fr < HH.a0 + HH.len) {
                    br = 1
                    len += 9
                } else {
                    br *= 0.6
                }
            }
            ctx.globalAlpha = br * appear * S.a
            ctx.strokeStyle = br > 0.45 ? acc : dimC
            ctx.lineWidth = br > 0.45 ? 1.7 : 1
            var l2 = len * appear
            ctx.beginPath()
            ctx.moveTo(cx + c * RT, cy + s * RT)
            ctx.lineTo(cx + c * (RT + l2), cy + s * (RT + l2))
            ctx.stroke()
        }

        ctx.globalCompositeOperation = isDark ? "lighter" : "source-over"
        var cp = st.cp
        var bd = ring.bands
        for (i = 0; i < cp.length; ++i) {
            var p = cp[i]
            if (p.state === 2)
                continue
            var born = clamp((I - 0.5 - p.dl * 0.9) / 0.9, 0, 1)
            if (born <= 0)
                continue
            if (p.state === 0) {
                if (animOn)
                    p.a += p.w * f
                if (ph === "run" && p.cat >= 0 && catOn[p.cat] && bd[p.cat]) {
                    var b = bd[p.cat]
                    if (prg >= b[0] + p.key * (b[1] - b[0]) * 0.98) {
                        p.state = 1
                        p.q = 0
                        p.r0 = p.r
                    }
                }
            }
            var r = p.r
            var a = p.a
            var al = 0.32
            var col = dotC
            var size = p.sz
            if (p.state === 1) {
                p.q += 0.024 * f
                var e = ez(Math.min(1, p.q))
                r = p.r0 + (1 - p.r0) * e
                a = p.a + p.q * 1.8
                al = 1 - Math.pow(Math.min(1, p.q), 3)
                col = acc
                size *= 1.6
                if (p.q >= 1) {
                    p.state = 2
                    st.pulse = Math.min(1, st.pulse + 0.1)
                    continue
                }
            } else if (p.cat >= 0) {
                if (catOn[p.cat]) {
                    p.g = Math.min(1, p.g + 0.012 * f)
                    if (p.g > 0.4) {
                        col = acc
                        size *= 1.7
                        al = 0.95
                    }
                } else {
                    al = 0.12
                }
            }
            if (hover >= 0 && p.state === 0) {
                if (p.cat === hover) {
                    size *= 1.5
                    al = 1
                } else {
                    al *= 0.55
                }
            }
            var rr = r * Rr * (0.55 + 0.45 * ez(born))
            var x = cx + Math.cos(a) * rr
            var y = cy + Math.sin(a) * rr
            var ddx = x - mx
            var ddy = y - my
            var dd2 = Math.sqrt(ddx * ddx + ddy * ddy) || 1
            if (dd2 < 120) {
                var fo = Math.pow(1 - dd2 / 120, 2) * 18
                x += ddx / dd2 * fo
                y += ddy / dd2 * fo
            }
            if (p.state === 1 && !isNaN(p.lx)) {
                ctx.globalAlpha = al * 0.6 * S.a
                ctx.strokeStyle = col
                ctx.lineWidth = size * 1.2
                ctx.beginPath()
                ctx.moveTo(p.lx, p.ly)
                ctx.lineTo(x, y)
                ctx.stroke()
            }
            p.lx = x
            p.ly = y
            ctx.globalAlpha = al * born * S.a
            ctx.fillStyle = col
            ctx.beginPath()
            ctx.arc(x, y, size, 0, tau)
            ctx.fill()
        }
        ctx.globalCompositeOperation = "source-over"

        ctx.globalAlpha = 0.5 * S.a * ia
        ctx.strokeStyle = dimC
        ctx.lineWidth = 1
        ctx.beginPath()
        ctx.arc(cx, cy, Rr * 0.84, 0, tau)
        ctx.stroke()

        ctx.lineCap = "round"
        for (i = 0; i < lay.length; ++i) {
            var L = lay[i]
            var ci = L.i
            var a0 = L.a0 * tau - Math.PI / 2 + GAP / 2
            var span = Math.max(0.01, L.len * tau - GAP)
            var draw = ezio(clamp((I - 0.25 - L.a0 * 0.9) / 0.9, 0, 1))
            if (draw <= 0)
                continue
            var hv = hover === ci
            var on = catOn[ci]
            ctx.strokeStyle = acc
            if (hv && on) {
                ctx.lineWidth = LW * 1.6 + 10
                ctx.globalAlpha = 0.16 * S.a
                ctx.beginPath()
                ctx.arc(cx, cy, Rr, a0, a0 + span * draw, false)
                ctx.stroke()
            }
            ctx.lineWidth = LW * (hv ? 1.6 : 1)
            ctx.globalAlpha = (on ? (hv ? 0.6 : (hover >= 0 ? 0.14 : 0.26)) : 0.07) * S.a * ia
            ctx.beginPath()
            ctx.arc(cx, cy, Rr, a0, a0 + span * draw, false)
            ctx.stroke()
            var bb = bd[ci]
            var fl = 0
            if (bb)
                fl = ph === "done" ? 1 : (ph === "run" ? clamp((prg - bb[0]) / (bb[1] - bb[0]), 0, 1) : 0)
            if (fl > 0) {
                ctx.globalAlpha = (hover >= 0 && !hv ? 0.5 : 1) * S.a * ia
                ctx.beginPath()
                ctx.arc(cx, cy, Rr, a0, a0 + span * fl, false)
                ctx.stroke()
            }
            if (hv && on) {
                ctx.globalAlpha = 0.95 * S.a
                ctx.beginPath()
                ctx.arc(cx, cy, Rr, a0, a0 + span * draw, false)
                ctx.stroke()
            }
        }

        ctx.globalCompositeOperation = isDark ? "lighter" : "source-over"
        if (ph === "run" || (ph === "idle" && I > 1.4 && hover < 0)) {
            var hf = ph === "run" ? head : ((now / 1000 * 0.12) % 1)
            var ha = hf * tau - Math.PI / 2
            for (var t = 0; t < 26; ++t) {
                var tt = t / 26
                var an = ha - tt * 0.9
                ctx.globalAlpha = (1 - tt) * (ph === "run" ? 0.7 : 0.4) * S.a
                ctx.strokeStyle = acc
                ctx.lineWidth = LW * (1 - tt * 0.5)
                ctx.beginPath()
                ctx.arc(cx, cy, Rr, an - 0.04, an, false)
                ctx.stroke()
            }
            var hx = cx + Math.cos(ha) * Rr
            var hy = cy + Math.sin(ha) * Rr
            var hg = ctx.createRadialGradient(hx, hy, 0, hx, hy, 28)
            hg.addColorStop(0, acc)
            hg.addColorStop(1, rgba(acc, 0))
            ctx.globalAlpha = (ph === "run" ? 0.9 : 0.5) * S.a
            ctx.fillStyle = hg
            ctx.beginPath()
            ctx.arc(hx, hy, 28, 0, tau)
            ctx.fill()
            ctx.globalAlpha = S.a
            ctx.fillStyle = "#ffffff"
            ctx.beginPath()
            ctx.arc(hx, hy, 3.2, 0, tau)
            ctx.fill()
            if (ph === "run" && animOn) {
                var nx = Math.cos(ha)
                var ny = Math.sin(ha)
                for (var q = 0; q < 3; ++q) {
                    var o = (Math.random() - 0.3) * 3.2
                    var bq = 1 + Math.random() * 3
                    st.sparks.push({
                        x: hx, y: hy,
                        vx: nx * o + ny * bq + (Math.random() - 0.5), vy: ny * o - nx * bq + (Math.random() - 0.5),
                        l: 1, dl: 0.035 + Math.random() * 0.03, sz: 0.6 + Math.random() * 1.4,
                        g: 0.03, white: Math.random() < 0.45, str: false, tw: undefined
                    })
                }
            }
        }

        if (st.explode) {
            st.explode = false
            explodeAt(cx, cy, Rr)
        }

        var sp = st.sparks
        var w2 = 0
        var damp = Math.pow(0.985, f)
        for (i = 0; i < sp.length; ++i) {
            var k = sp[i]
            k.x += k.vx * f
            k.y += k.vy * f
            k.vx *= damp
            k.vy = k.vy * damp + k.g * f
            k.l -= k.dl * f
            if (k.l <= 0)
                continue
            sp[w2++] = k
            var sa = Math.max(0, k.l)
            if (k.tw !== undefined) {
                k.tw += 0.12 * f
                sa *= 0.5 + 0.5 * Math.sin(k.tw)
            }
            ctx.globalAlpha = sa * S.a
            if (k.str) {
                ctx.strokeStyle = k.white ? "#ffffff" : acc
                ctx.lineWidth = k.sz * 0.9
                ctx.beginPath()
                ctx.moveTo(k.x, k.y)
                ctx.lineTo(k.x - k.vx * 3, k.y - k.vy * 3)
                ctx.stroke()
            } else {
                ctx.fillStyle = k.white ? "#ffffff" : acc
                ctx.beginPath()
                ctx.arc(k.x, k.y, k.sz, 0, tau)
                ctx.fill()
            }
        }
        sp.length = w2
        if (sp.length > 1000)
            sp.splice(0, sp.length - 1000)

        var rs = st.rings
        var w3 = 0
        for (i = 0; i < rs.length; ++i) {
            var rg = rs[i]
            if (rg.d > 0) {
                rg.d -= dt
                rs[w3++] = rg
                continue
            }
            rg.k += 0.011 * f
            if (rg.k >= 1)
                continue
            rs[w3++] = rg
            var ee = ez(rg.k)
            var small = rg.s > 0
            ctx.strokeStyle = acc
            ctx.globalAlpha = (1 - rg.k) * 0.6 * S.a * (small ? rg.s : 1)
            ctx.lineWidth = 1.4
            ctx.beginPath()
            ctx.arc(cx, cy, Rr * (small ? 0.6 : 1.02) + Rr * ee * (small ? 0.5 : 1.1), 0, tau)
            ctx.stroke()
        }
        rs.length = w3

        ctx.globalAlpha = 1
        ctx.globalCompositeOperation = "source-over"
        if (saved)
            ctx.restore()
        st.shake *= Math.pow(0.9, f)
    }

    onPhaseChanged: {
        if (phase === "run") {
            st.breath = -1.8
            st.shake = 4
            st.doneT = -1
        } else if (phase === "done") {
            st.doneT = 0
            st.explode = true
            st.shake = 18
            st.pulse = 1
            st.breath = 1.2
            st.rings.push({ k: 0, s: 0, d: 0 }, { k: 0, s: 0, d: 0.2 }, { k: 0, s: 0, d: 0.42 }, { k: 0, s: 0, d: 0.7 })
        } else {
            st.doneT = -1
            initP(true)
        }
        cv.requestPaint()
    }

    onWeightsChanged: {
        relayout()
        initP(true)
        cv.requestPaint()
    }
    onCatOnChanged: {
        relayout()
        initP(true)
        cv.requestPaint()
    }
    onMainModeChanged: {
        st.mx = -1e4
        st.my = -1e4
        hoverIdx = -1
        centerHover = false
        cv.requestPaint()
    }
    onAccChanged: cv.requestPaint()
    onDarkModeChanged: cv.requestPaint()

    Component.onCompleted: {
        relayout()
        initP(false)
        st.tI = Date.now()
    }

    Canvas {
        id: cv
        anchors.fill: parent
        onPaint: ring.frame(getContext("2d"), width, height)
    }

    FrameAnimation {
        id: fa
        running: ring.visible && ring.width > 0 && (ring.animOn || ring.phase !== "idle")
        onTriggered: cv.requestPaint()
    }

    MouseArea {
        anchors.fill: parent
        enabled: ring.mainMode
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        cursorShape: (ring.hoverIdx >= 0 || ring.centerHover) ? Qt.PointingHandCursor : Qt.ArrowCursor
        onPositionChanged: function (mouse) { ring.pointer(mouse.x, mouse.y) }
        onExited: ring.pointer(-1e4, -1e4)
        onClicked: {
            if (!ring.mainMode || ring.phase !== "idle")
                return
            if (ring.hoverIdx >= 0) {
                ring.categoryClicked(ring.hoverIdx)
            } else if (ring.centerHover) {
                ring.st.rings.push({ k: 0, s: 0.6, d: 0 })
                ring.centerClicked()
            }
        }
    }
}
