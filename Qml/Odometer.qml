import QtQuick

Item {
    id: odo

    property real value: 0
    property real fontSize: 96
    property color color: theme.txt
    readonly property bool animate: quanta_settings.settings_animation
    readonly property string txt: (value < 0 ? 0 : value).toFixed(1)
    readonly property real spacing: -0.045 * fontSize
    property real digitW: fontSize * 0.56

    width: row.width
    height: fontSize
    clip: true

    function recalc() {
        var m = 0
        for (var i = 0; i < meas.count; ++i) {
            var it = meas.itemAt(i)
            if (it)
                m = Math.max(m, it.implicitWidth)
        }
        if (m > 0)
            digitW = m + spacing
    }

    Repeater {
        id: meas
        model: 10
        delegate: Txt {
            required property int index
            visible: false
            text: String(index)
            font.pixelSize: odo.fontSize
            font.weight: Font.ExtraLight
            font.letterSpacing: odo.spacing
            onImplicitWidthChanged: odo.recalc()
        }
        onItemAdded: odo.recalc()
    }

    Row {
        id: row

        Repeater {
            model: odo.txt.length

            delegate: Item {
                id: col
                required property int index
                readonly property string ch: odo.txt.charAt(index)
                readonly property bool isPt: ch === "."

                width: isPt ? odo.fontSize * 0.26 : odo.digitW
                height: odo.fontSize
                clip: true

                Txt {
                    visible: col.isPt
                    anchors.fill: parent
                    text: "."
                    color: odo.color
                    font.pixelSize: odo.fontSize
                    font.weight: Font.ExtraLight
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Column {
                    id: strip
                    visible: !col.isPt
                    y: col.isPt ? 0 : -parseInt(col.ch) * odo.fontSize

                    Behavior on y {
                        enabled: odo.animate
                        SequentialAnimation {
                            PauseAnimation { duration: col.index * 45 }
                            NumberAnimation {
                                duration: 1000
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: [0.16, 1, 0.3, 1, 1, 1]
                            }
                        }
                    }

                    Repeater {
                        model: 10
                        delegate: Txt {
                            required property int index
                            width: col.width
                            height: odo.fontSize
                            text: String(index)
                            color: odo.color
                            font.pixelSize: odo.fontSize
                            font.weight: Font.ExtraLight
                            font.letterSpacing: odo.spacing
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }
}
