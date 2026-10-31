import QtQuick

Item {
    id: page

    property bool shown: false
    property var ring

    anchors.fill: parent
    opacity: shown ? 1 : 0
    visible: opacity > 0.01
    Behavior on opacity { NumberAnimation { duration: page.shown ? 350 : 200 } }

    readonly property int hov: ring ? ring.hoverIdx : -1
    readonly property bool ctr: ring ? ring.centerHover : false
    readonly property bool run: main_window.phase === "run"
    readonly property bool done: main_window.phase === "done"

    readonly property string lblText: hov >= 0 ? main_window.catNames[hov] : str.canBeCleaned
    readonly property real odoValue: hov >= 0 ? main_window.avail[hov]
                                              : (run ? main_window.startTotal * (1 - main_window.prog)
                                                     : (done ? 0 : main_window.totalMb))
    readonly property string subTextValue: {
        if (hov >= 0)
            return main_window.catOn[hov] ? str.hintOff : str.hintOn
        if (ctr && !run && !done)
            return str.hintGo
        if (run) {
            var c = ring ? ring.curCat() : -1
            return c >= 0 ? main_window.catNames[c] : str.cleaning
        }
        if (done)
            return str.freed + " " + main_window.freedLast.toFixed(1) + " MB"
        return main_window.activeCount + " / " + main_window.catCount + " " + str.categories
    }

    Item {
        id: num
        width: 360
        height: lbl.height + 12 + odo.height + 14 + sub.height
        x: (parent.width - width) / 2
        y: parent.height * 0.46 - height / 2
        opacity: main_window.finVisible ? 0 : 1
        scale: main_window.finVisible ? 0.92 : (page.ctr && !page.run && !page.done ? 1.04 : 1)

        Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.InOutCubic } }
        Behavior on scale {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: 800; easing.type: Easing.OutQuint }
        }

        SwapText {
            id: lbl
            width: parent.width
            text: page.lblText
            pixelSize: 13
            weight: Font.Medium
        }

        Row {
            id: odoRow
            anchors.horizontalCenter: parent.horizontalCenter
            y: lbl.height + 12
            spacing: 8

            Odometer {
                id: odo
                value: page.odoValue
                fontSize: Math.max(44, Math.min(96, page.ring ? page.ring.baseRadius * 0.5 : 80))
            }
            Txt {
                text: "MB"
                color: theme.txt2
                font.pixelSize: 20
                anchors.top: parent.top
                anchors.topMargin: 13
            }
        }

        SwapText {
            id: sub
            width: parent.width
            y: lbl.height + 12 + odo.height + 14
            text: page.subTextValue
            pixelSize: 13
            weight: Font.Normal
        }
    }

    DoneBadge {
        x: (parent.width - width) / 2
        y: parent.height * 0.46 - height / 2
        shown: main_window.finVisible
        value: main_window.freedLast.toFixed(1) + " MB"
        caption: str.freed
    }

    CtaButton {
        id: cta
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 92
        text: page.done ? str.allClean : (page.run ? str.cleaning : str.clean)
        busy: page.run || page.done
        progress: page.run ? main_window.prog : 0
        opacity: page.shown ? 1 : 0
        onClicked: main_window.startClean()
    }
}
