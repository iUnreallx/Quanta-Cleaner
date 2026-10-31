import QtQuick
import QtQuick.Controls

Popup {
    id: pop

    property int cat: 0
    readonly property string file: main_window.logFiles[cat]

    modal: true
    focus: true
    padding: 0
    anchors.centerIn: Overlay.overlay
    width: Math.min(900, main_window.width - 56)
    height: Math.min(560, main_window.height - 96)
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

    onOpened: {
        logsviewer.loadLogs(file)
        logText.text = logsviewer.logs.length > 0 ? logsviewer.logs.join("\n") : str.logEmpty
    }
    onClosed: {
        logText.text = ""
        logsviewer.clearLogs()
    }

    function reload() {
        logsviewer.loadLogs(file)
        logText.text = logsviewer.logs.length > 0 ? logsviewer.logs.join("\n") : str.logEmpty
    }

    background: Rectangle {
        radius: 28
        color: theme.surface
        border.width: 1
        border.color: theme.line2
    }

    contentItem: Item {
        Item {
            id: bar
            width: parent.width
            height: 64

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
                    kind: "eye"
                    color: theme.acc
                }
            }
            Txt {
                x: 22 + 36 + 12
                anchors.verticalCenter: parent.verticalCenter
                text: main_window.catNames[pop.cat]
                font.pixelSize: 17
                font.weight: Font.DemiBold
                font.letterSpacing: -0.3
            }
            Txt {
                anchors.right: closeBtn.left
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                text: pop.file
                color: theme.txt3
                font.family: theme.monoFamily
                font.pixelSize: 12
            }
            Rectangle {
                id: closeBtn
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                width: 34
                height: 34
                radius: 17
                color: closeMa.containsMouse ? theme.line2 : theme.line
                Ico {
                    anchors.centerIn: parent
                    width: 16
                    height: 16
                    kind: "x"
                    color: theme.txt
                }
                MouseArea {
                    id: closeMa
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: pop.close()
                }
            }
        }

        Rectangle {
            id: well
            x: 14
            y: bar.height
            width: parent.width - 28
            height: parent.height - bar.height - 14
            radius: 18
            color: theme.bg
            border.width: 1
            border.color: theme.line
            clip: true

            Item {
                id: gutter
                width: 46
                height: parent.height
                clip: true

                Txt {
                    id: nums
                    x: 0
                    y: 10 - logFlick.contentY
                    width: parent.width - 10
                    horizontalAlignment: Text.AlignRight
                    color: theme.txt3
                    font.family: theme.monoFamily
                    font.pixelSize: 13
                    text: {
                        var n = Math.max(1, logText.lineCount)
                        var s = ""
                        for (var i = 1; i <= n; ++i)
                            s += i + (i < n ? "\n" : "")
                        return s
                    }
                }
            }

            Flickable {
                id: logFlick
                x: gutter.width
                width: parent.width - gutter.width
                height: parent.height
                contentWidth: Math.max(width, logText.implicitWidth + 28)
                contentHeight: logText.implicitHeight + 20
                flickableDirection: Flickable.HorizontalAndVerticalFlick
                boundsBehavior: Flickable.StopAtBounds
                clip: true

                TextEdit {
                    id: logText
                    x: 8
                    y: 10
                    readOnly: true
                    selectByMouse: true
                    wrapMode: TextEdit.NoWrap
                    color: theme.txt
                    selectionColor: theme.acc
                    selectedTextColor: theme.ink
                    font.family: theme.monoFamily
                    font.pixelSize: 13
                }
            }
        }
    }
}
