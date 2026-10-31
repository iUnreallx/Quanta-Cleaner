import QtQuick

Reveal {
    id: bc

    property string size: "c"
    property string iconName: "temp"
    property string title: ""
    property real mb: 0
    property bool known: true
    property real maxMb: 1
    property real share: 0
    property bool active: true

    signal toggled()
    signal moreClicked()

    readonly property bool isRow: size === "b" || size === "e"
    readonly property bool isBig: size === "a"
    readonly property int pad: isBig ? 22 : (isRow ? 18 : 14)
    readonly property int tileS: isBig ? 68 : (isRow ? 56 : 40)
    readonly property int tileR: isBig ? 22 : (isRow ? 18 : 13)
    readonly property int iconS: isBig ? 38 : (isRow ? 30 : 22)
    readonly property int checkS: isBig || isRow ? 26 : 22
    readonly property bool hovered: ma.containsMouse || moreMa.containsMouse

    Item {
        id: body
        width: parent.width
        height: parent.height
        y: bc.hovered ? -4 : 0
        scale: ma.pressed ? 0.96 : 1
        opacity: bc.active ? 1 : 0.55

        Behavior on y {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: 500; easing.type: Easing.OutBack }
        }
        Behavior on scale {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: ma.pressed ? 100 : 500; easing.type: Easing.OutBack }
        }
        Behavior on opacity { NumberAnimation { duration: 400 } }

        Rectangle {
            id: bg
            anchors.fill: parent
            radius: 26
            color: bc.active ? Qt.tint(theme.card, Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.09)) : theme.card
            border.width: bc.active ? 1.5 : 1
            border.color: bc.active ? theme.acc : theme.line2
            Behavior on color { ColorAnimation { duration: 400 } }
            Behavior on border.color { ColorAnimation { duration: 400 } }
        }

        RadialFill {
            anchors.fill: parent
            visible: bc.hovered
            clipRadius: 26
            rpx: 160
            cx: ma.mouseX / Math.max(1, width)
            cy: ma.mouseY / Math.max(1, height)
            stops: [
                { p: 0, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.22) },
                { p: 0.7, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0) },
                { p: 1, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0) }
            ]
        }

        Rectangle {
            id: tile
            x: bc.pad
            y: bc.isRow ? (parent.height - height) / 2 : bc.pad
            width: bc.tileS
            height: bc.tileS
            radius: bc.tileR
            color: bc.active ? Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.14) : theme.line
            Behavior on color { ColorAnimation { duration: 400 } }

            TintImage {
                anchors.centerIn: parent
                width: bc.iconS
                height: bc.iconS
                source: "assets/images/min/" + bc.iconName + ".png"
                color: bc.active ? theme.acc : theme.txt3
            }
        }

        Rectangle {
            id: check
            width: bc.checkS
            height: bc.checkS
            radius: width / 2
            anchors.right: parent.right
            anchors.rightMargin: bc.pad
            y: bc.isRow ? (parent.height - height) / 2 : bc.pad
            color: bc.active ? theme.acc : "transparent"
            border.width: bc.active ? 0 : 1.5
            border.color: theme.line2
            Behavior on color { ColorAnimation { duration: 400 } }

            Ico {
                anchors.centerIn: parent
                width: bc.checkS * 0.58
                height: width
                kind: "check"
                lw: 3.2
                color: theme.ink
                progress: bc.active ? 1 : 0
                Behavior on progress {
                    enabled: quanta_settings.settings_animation
                    NumberAnimation { duration: 400; easing.type: Easing.OutCubic }
                }
            }
        }

        Rectangle {
            id: more
            width: 26
            height: 26
            radius: 13
            anchors.right: check.left
            anchors.rightMargin: 8
            y: check.y + (check.height - height) / 2
            color: moreMa.containsMouse ? theme.line2 : theme.line
            opacity: bc.hovered ? 1 : 0
            visible: opacity > 0.01
            Behavior on opacity { NumberAnimation { duration: 250 } }

            Ico {
                anchors.centerIn: parent
                width: 16
                height: 16
                kind: "dots"
                color: theme.txt
            }
        }

        Item {
            id: texts
            x: bc.isRow ? bc.pad + bc.tileS + 16 : bc.pad
            width: bc.isRow ? check.x - 16 - x - (bc.hovered ? 34 : 0) : parent.width - bc.pad * 2
            height: col.height
            y: bc.isRow ? (parent.height - height) / 2 : parent.height - bc.pad - height
            clip: bc.isRow

            Column {
                id: col
                width: parent.width
                spacing: 2

                Item {
                    width: parent.width
                    height: nameTxt.implicitHeight

                    Txt {
                        id: nameTxt
                        text: bc.title
                        color: bc.isBig ? theme.txt : theme.txt2
                        font.pixelSize: bc.isBig ? 17 : (bc.isRow ? 14 : 13)
                        font.weight: Font.Medium
                        elide: Text.ElideRight
                        width: Math.min(implicitWidth, parent.width - (shareTxt.visible ? shareTxt.implicitWidth + 8 : 0))
                    }
                    Txt {
                        id: shareTxt
                        visible: bc.isBig || bc.isRow
                        anchors.left: nameTxt.right
                        anchors.leftMargin: 8
                        anchors.baseline: nameTxt.baseline
                        text: Math.round(bc.share * 100) + "%"
                        color: theme.txt3
                        font.pixelSize: 12
                    }
                }

                Item {
                    width: parent.width
                    height: valueTxt.implicitHeight

                    Txt {
                        id: valueTxt
                        text: bc.known ? bc.mb.toFixed(1) : "—"
                        font.pixelSize: bc.isBig ? 76 : (bc.isRow ? 34 : 22)
                        font.weight: bc.isBig ? Font.ExtraLight : Font.Light
                        font.letterSpacing: bc.isBig ? -3.8 : (bc.isRow ? -1.7 : -1.1)
                    }
                    Txt {
                        visible: bc.known
                        x: valueTxt.implicitWidth + 4
                        y: valueTxt.baselineOffset - baselineOffset
                        text: "MB"
                        color: theme.txt3
                        font.pixelSize: bc.isBig ? 18 : 13
                    }
                }

                Rectangle {
                    visible: bc.isBig || bc.isRow
                    width: parent.width
                    height: bc.isBig ? 8 : 4
                    radius: height / 2
                    color: theme.line
                    clip: true

                    Rectangle {
                        width: bc.known ? parent.width * Math.max(0.02, Math.min(1, bc.mb / Math.max(0.001, bc.maxMb))) : 0
                        height: parent.height
                        radius: height / 2
                        color: theme.acc
                        Behavior on width {
                            enabled: quanta_settings.settings_animation
                            NumberAnimation { duration: 700; easing.type: Easing.OutQuint }
                        }
                    }
                }
            }
        }

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: bc.toggled()
        }

        MouseArea {
            id: moreMa
            x: more.x
            y: more.y
            width: more.width
            height: more.height
            enabled: more.visible
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: bc.moreClicked()
        }
    }
}
