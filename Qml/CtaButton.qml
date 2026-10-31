import QtQuick

Item {
    id: cta

    property string text: ""
    property real progress: 0
    property bool busy: false
    signal clicked()

    readonly property bool hot: ma.containsMouse && !busy

    height: 56
    width: lbl.implicitWidth + 30 + 18 + 40 + 9

    Behavior on width {
        enabled: quanta_settings.settings_animation
        NumberAnimation { duration: 600; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.16, 1, 0.3, 1, 1, 1] }
    }

    scale: ma.pressed ? 0.96 : (hot ? 1.025 : 1)
    Behavior on scale {
        enabled: quanta_settings.settings_animation
        NumberAnimation { duration: ma.pressed ? 100 : 500; easing.type: Easing.OutBack }
    }

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: cta.hot ? Qt.lighter(theme.acc, 1.08) : theme.acc
        opacity: cta.busy ? 0.92 : 1
        Behavior on color { ColorAnimation { duration: 200 } }
    }

    Rectangle {
        visible: cta.progress > 0.001
        height: parent.height
        width: Math.max(height, parent.width * cta.progress)
        radius: height / 2
        color: Qt.rgba(1, 1, 1, 0.28)
    }

    Txt {
        id: lbl
        x: 30
        anchors.verticalCenter: parent.verticalCenter
        text: cta.text
        color: theme.ink
        font.pixelSize: 16
        font.weight: Font.DemiBold
    }

    Rectangle {
        id: circle
        width: 40
        height: 40
        radius: 20
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        color: Qt.rgba(theme.ink.r, theme.ink.g, theme.ink.b, 0.18)

        Ico {
            id: arrow
            width: 18
            height: 18
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: cta.hot ? 3 : 0
            kind: "arrow"
            color: theme.ink
            lw: 2.4
            Behavior on anchors.horizontalCenterOffset {
                enabled: quanta_settings.settings_animation
                NumberAnimation { duration: 500; easing.type: Easing.OutQuint }
            }

            NumberAnimation on rotation {
                from: 0
                to: 360
                duration: 1100
                loops: Animation.Infinite
                running: cta.busy
                onRunningChanged: if (!running) arrow.rotation = 0
            }
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        enabled: !cta.busy
        cursorShape: Qt.PointingHandCursor
        onClicked: cta.clicked()
    }
}
