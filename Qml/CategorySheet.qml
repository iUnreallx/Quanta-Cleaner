import QtQuick
import QtQuick.Controls

Popup {
    id: pop

    property int cat: 0

    modal: true
    focus: true
    padding: 0
    anchors.centerIn: Overlay.overlay
    width: Math.min(440, main_window.width - 48)
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    Overlay.modal: Rectangle { color: Qt.rgba(0, 0, 0, 0.55) }

    enter: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 250 }
            NumberAnimation { property: "scale"; from: 0.94; to: 1; duration: 450; easing.type: Easing.OutBack }
        }
    }
    exit: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; to: 0; duration: 180 }
            NumberAnimation { property: "scale"; to: 0.97; duration: 180 }
        }
    }

    background: Rectangle {
        radius: 28
        color: theme.surface
        border.width: 1
        border.color: theme.line2
    }

    contentItem: Item {
        id: body
        implicitHeight: col.height + 48

        Column {
            id: col
            x: 24
            y: 24
            width: parent.width - 48
            spacing: 18

            Item {
                width: parent.width
                height: 60

                Rectangle {
                    id: tile
                    width: 60
                    height: 60
                    radius: 20
                    color: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.14)

                    TintImage {
                        anchors.centerIn: parent
                        width: 34
                        height: 34
                        source: "assets/images/min/" + main_window.catIcons[pop.cat] + ".png"
                        color: theme.acc
                    }
                }
                Column {
                    x: 60 + 16
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Txt {
                        text: main_window.catNames[pop.cat]
                        font.pixelSize: 19
                        font.weight: Font.DemiBold
                        font.letterSpacing: -0.4
                    }
                    Txt {
                        text: pop.cat === 1 ? "—" : (main_window.avail[pop.cat].toFixed(1) + " MB")
                        color: theme.acc
                        font.pixelSize: 15
                        font.weight: Font.Medium
                    }
                }
                Rectangle {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: 34
                    height: 34
                    radius: 17
                    color: xMa.containsMouse ? theme.line2 : theme.line
                    Ico {
                        anchors.centerIn: parent
                        width: 16
                        height: 16
                        kind: "x"
                        color: theme.txt
                    }
                    MouseArea {
                        id: xMa
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: pop.close()
                    }
                }
            }

            Txt {
                width: parent.width
                text: main_window.catInfo[pop.cat]
                color: theme.txt2
                font.pixelSize: 15
                lineHeight: 1.3
                wrapMode: Text.Wrap
            }

            Rectangle {
                width: parent.width
                height: 56
                radius: 28
                color: "transparent"
                border.width: 1
                border.color: theme.line2

                Txt {
                    x: 22
                    anchors.verticalCenter: parent.verticalCenter
                    text: str.includeIt
                    font.pixelSize: 15
                    font.weight: Font.Medium
                }
                PillToggle {
                    anchors.right: parent.right
                    anchors.rightMargin: 13
                    anchors.verticalCenter: parent.verticalCenter
                    checked: main_window.catOn[pop.cat]
                    onToggled: function (v) { main_window.setOn(pop.cat, v) }
                }
            }

            Flow {
                width: parent.width
                spacing: 10

                PillButton {
                    text: str.spotClean
                    iconKind: "play"
                    filled: true
                    enabled: main_window.phase === "idle"
                    onClicked: {
                        main_window.spotClean(pop.cat)
                        pop.close()
                    }
                }
                PillButton {
                    text: str.openLog
                    iconKind: "eye"
                    onClicked: {
                        pop.close()
                        main_window.openLog(pop.cat)
                    }
                }
                PillButton {
                    text: str.clearLog
                    iconKind: "trash"
                    onClicked: main_window.clearLog(pop.cat)
                }
            }
        }
    }
}
