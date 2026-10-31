import QtQuick
import QtQuick.Controls

Item {
    id: page

    property bool shown: false

    anchors.fill: parent
    opacity: shown ? 1 : 0
    visible: opacity > 0.01
    Behavior on opacity { NumberAnimation { duration: page.shown ? 0 : 200 } }

    readonly property bool wide: content.width >= 720

    Flickable {
        id: fl
        anchors.fill: parent
        contentWidth: width
        contentHeight: content.height + 84 + 110
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        Column {
            id: content
            x: (fl.width - width) / 2
            y: 84
            width: Math.min(880, fl.width - 80)
            spacing: 12

            Reveal {
                width: parent.width
                height: head.height + 14
                shown: page.shown
                order: 0

                Column {
                    id: head
                    spacing: 6
                    Txt {
                        text: str.navSettings
                        font.pixelSize: 34
                        font.weight: Font.DemiBold
                        font.letterSpacing: -1.4
                    }
                    Txt {
                        text: str.sSub
                        color: theme.txt2
                        font.pixelSize: 15
                    }
                }
            }

            GlassCard {
                width: parent.width
                height: 20 + 24 + 12 + swFlow.height + 24
                shown: page.shown
                order: 1

                Txt {
                    x: 22
                    y: 20
                    text: str.accentColor
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                    font.letterSpacing: -0.3
                }
                Txt {
                    anchors.right: parent.right
                    anchors.rightMargin: 22
                    y: 21
                    text: main_window.accentNames[main_window.accentIndex]
                    color: theme.acc
                    font.pixelSize: 14
                    font.weight: Font.Medium
                }

                Flow {
                    id: swFlow
                    x: 22
                    y: 20 + 24 + 12
                    width: parent.width - 44
                    spacing: 14

                    Repeater {
                        model: main_window.accentDefs
                        delegate: Item {
                            id: sw
                            required property int index
                            required property var modelData
                            readonly property bool sel: main_window.accentIndex === index

                            width: 64
                            height: 64

                            Rectangle {
                                id: dotc
                                anchors.centerIn: parent
                                width: 52
                                height: 52
                                radius: 26
                                color: sw.modelData.c
                                scale: swMa.pressed ? 0.92 : (swMa.containsMouse ? 1.08 : 1)
                                y: swMa.containsMouse ? -4 : 0
                                Behavior on scale {
                                    enabled: quanta_settings.settings_animation
                                    NumberAnimation { duration: swMa.pressed ? 100 : 500; easing.type: Easing.OutBack }
                                }

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 64 - 8
                                    height: width
                                    radius: width / 2
                                    color: "transparent"
                                    border.width: 2.5
                                    border.color: sw.modelData.c
                                    opacity: sw.sel ? 1 : 0
                                    scale: sw.sel ? 1 : 0.8
                                    Behavior on opacity { NumberAnimation { duration: 300 } }
                                    Behavior on scale {
                                        enabled: quanta_settings.settings_animation
                                        NumberAnimation { duration: 500; easing.type: Easing.OutBack }
                                    }
                                }

                                Ico {
                                    anchors.centerIn: parent
                                    width: 22
                                    height: 22
                                    kind: "check"
                                    lw: 3.2
                                    color: sw.modelData.k
                                    progress: sw.sel ? 1 : 0
                                    Behavior on progress {
                                        enabled: quanta_settings.settings_animation
                                        NumberAnimation { duration: 450; easing.type: Easing.OutCubic }
                                    }
                                }
                            }

                            MouseArea {
                                id: swMa
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: function (mouse) {
                                    var p = swMa.mapToItem(null, mouse.x, mouse.y)
                                    main_window.chooseAccent(sw.index, p.x, p.y)
                                }
                            }
                        }
                    }
                }
            }

            Flow {
                id: duo
                width: parent.width
                spacing: 12

                readonly property real colW: page.wide ? (width - 12) * 0.46 : width
                readonly property real colW2: page.wide ? (width - 12) - colW : width

                GlassCard {
                    width: duo.colW
                    height: 20 + 24 + 12 + 124 + 22
                    shown: page.shown
                    order: 2

                    Txt {
                        x: 22
                        y: 20
                        text: str.theme
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                        font.letterSpacing: -0.3
                    }

                    Row {
                        x: 18
                        y: 20 + 24 + 12
                        width: parent.width - 36
                        spacing: 10

                        Repeater {
                            model: 2
                            delegate: Item {
                                id: th
                                required property int index
                                readonly property bool isDark: index === 0
                                readonly property bool sel: (quanta_settings.settings_theme === 2) === isDark

                                width: (parent.width - 10) / 2
                                height: 124

                                Rectangle {
                                    anchors.fill: parent
                                    radius: 18
                                    color: "transparent"
                                    border.width: th.sel ? 2 : 1
                                    border.color: th.sel ? theme.acc : theme.line2
                                    scale: thMa.pressed ? 0.97 : 1
                                    y: thMa.containsMouse ? -3 : 0
                                    Behavior on border.color { ColorAnimation { duration: 300 } }
                                    Behavior on scale { NumberAnimation { duration: 400; easing.type: Easing.OutBack } }
                                    Behavior on y { NumberAnimation { duration: 400; easing.type: Easing.OutBack } }

                                    Rectangle {
                                        x: 7
                                        y: 7
                                        width: parent.width - 14
                                        height: 92
                                        radius: 12
                                        color: th.isDark ? "#09090c" : "#f4f4f7"

                                        Rectangle {
                                            anchors.centerIn: parent
                                            anchors.verticalCenterOffset: -2
                                            width: 44
                                            height: 44
                                            radius: 22
                                            color: "transparent"
                                            border.width: 5
                                            border.color: theme.acc
                                        }
                                        Rectangle {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 9
                                            width: 34
                                            height: 8
                                            radius: 4
                                            color: theme.acc
                                        }
                                    }

                                    Txt {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 7
                                        text: th.isDark ? str.dark : str.light
                                        color: th.sel ? theme.txt : theme.txt2
                                        font.pixelSize: 13
                                        font.weight: Font.Medium
                                    }
                                }

                                MouseArea {
                                    id: thMa
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: quanta_settings.settings_theme = th.isDark ? 2 : 1
                                }
                            }
                        }
                    }
                }

                GlassCard {
                    id: beh
                    width: duo.colW2
                    height: 20 + 24 + 6 + rowsCol.height + 12
                    shown: page.shown
                    order: 3

                    Txt {
                        x: 22
                        y: 20
                        text: str.behavior
                        font.pixelSize: 16
                        font.weight: Font.DemiBold
                        font.letterSpacing: -0.3
                    }

                    Column {
                        id: rowsCol
                        x: 10
                        y: 20 + 24 + 6
                        width: parent.width - 20

                        SettingRow {
                            icon: "globe"
                            label: str.language
                            SegControl {
                                anchors.verticalCenter: parent.verticalCenter
                                options: ["RU", "EN"]
                                currentIndex: quanta_settings.settings_language === "rus" ? 0 : 1
                                onPicked: function (i) { main_window.setLanguage(i === 0 ? "rus" : "eng") }
                            }
                        }
                        SettingRow {
                            icon: "spark"
                            label: str.animations
                            PillToggle {
                                anchors.verticalCenter: parent.verticalCenter
                                checked: quanta_settings.settings_animation
                                onToggled: function (v) { quanta_settings.settings_animation = v }
                            }
                        }
                        SettingRow {
                            icon: "power"
                            label: str.startup
                            PillToggle {
                                anchors.verticalCenter: parent.verticalCenter
                                checked: quanta_settings.settings_reload
                                onToggled: function (v) {
                                    quanta_settings.settings_reload = v
                                    if (v)
                                        app.addToAutostart()
                                    else
                                        app.removeFromAutostart()
                                }
                            }
                        }
                        SettingRow {
                            icon: "bell"
                            label: str.notifications
                            PillToggle {
                                anchors.verticalCenter: parent.verticalCenter
                                checked: quanta_settings.settings_notify
                                onToggled: function (v) { quanta_settings.settings_notify = v }
                            }
                        }
                        SettingRow {
                            icon: "code"
                            label: str.debugMode
                            PillToggle {
                                anchors.verticalCenter: parent.verticalCenter
                                checked: quanta_settings.debugMode
                                onToggled: function (v) { quanta_settings.debugMode = v }
                            }
                        }
                    }
                }
            }

            GlassCard {
                width: parent.width
                height: 72
                shown: page.shown
                order: 4

                Rectangle {
                    x: 22
                    anchors.verticalCenter: parent.verticalCenter
                    width: 36
                    height: 36
                    radius: 12
                    color: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.14)
                    Ico {
                        anchors.centerIn: parent
                        width: 20
                        height: 20
                        kind: "send"
                        color: theme.acc
                    }
                }
                Txt {
                    x: 22 + 36 + 13
                    anchors.verticalCenter: parent.verticalCenter
                    text: str.reportError
                    font.pixelSize: 15
                    font.weight: Font.Medium
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    PillButton {
                        text: str.copy
                        iconKind: "copy"
                        onClicked: {
                            ClipboardHelper.copyText("https://t.me/unreallx")
                            main_window.addNotification(str.copied)
                        }
                    }
                    PillButton {
                        text: str.open
                        iconKind: "send"
                        filled: true
                        onClicked: Qt.openUrlExternally("https://t.me/unreallx")
                    }
                }
            }
        }
    }

    component SettingRow: Item {
        id: sr
        property string icon: ""
        property string label: ""
        default property alias control: slot.data

        width: parent ? parent.width : 300
        height: 56

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: rowMa.containsMouse ? theme.line : "transparent"
            Behavior on color { ColorAnimation { duration: 250 } }
        }
        MouseArea {
            id: rowMa
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton
        }

        Rectangle {
            id: tile
            x: 12
            anchors.verticalCenter: parent.verticalCenter
            width: 36
            height: 36
            radius: 12
            color: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.14)
            Ico {
                anchors.centerIn: parent
                width: 20
                height: 20
                kind: sr.icon
                color: theme.acc
            }
        }
        Txt {
            x: 12 + 36 + 13
            anchors.verticalCenter: parent.verticalCenter
            text: sr.label
            font.pixelSize: 15
            font.weight: Font.Medium
        }
        Item {
            id: slot
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: childrenRect.width
            height: 40
        }
    }
}
