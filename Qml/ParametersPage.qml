import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: page

    property bool shown: false

    anchors.fill: parent
    opacity: shown ? 1 : 0
    visible: opacity > 0.01
    Behavior on opacity { NumberAnimation { duration: page.shown ? 0 : 200 } }

    readonly property bool wide: content.width >= 700
    readonly property var sizes: ["a", "b", "c", "c", "c", "c", "c", "c", "e"]

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
            spacing: 26

            Reveal {
                width: parent.width
                height: Math.max(head.height, sum.height)
                shown: page.shown
                order: 0

                Column {
                    id: head
                    spacing: 6
                    Txt {
                        text: str.navClean
                        font.pixelSize: 34
                        font.weight: Font.DemiBold
                        font.letterSpacing: -1.4
                    }
                    Txt {
                        text: str.pSub
                        color: theme.txt2
                        font.pixelSize: 15
                    }
                }

                Rectangle {
                    id: sum
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 44
                    width: sumRow.width + 40
                    radius: 22
                    color: theme.card
                    border.width: 1
                    border.color: theme.line2

                    Row {
                        id: sumRow
                        anchors.centerIn: parent
                        spacing: 6
                        Txt {
                            anchors.baseline: sumVal.baseline
                            text: str.toClean
                            color: theme.txt2
                            font.pixelSize: 15
                        }
                        Txt {
                            id: sumVal
                            text: main_window.totalMb.toFixed(1)
                            font.pixelSize: 20
                            font.weight: Font.DemiBold
                            font.letterSpacing: -0.6
                        }
                        Txt {
                            anchors.baseline: sumVal.baseline
                            text: "MB"
                            color: theme.txt2
                            font.pixelSize: 15
                        }
                    }
                }
            }

            GridLayout {
                id: grid
                width: parent.width
                columns: page.wide ? 4 : 2
                rowSpacing: 12
                columnSpacing: 12

                Repeater {
                    model: main_window.catCount
                    delegate: BentoCard {
                        id: card
                        required property int index
                        readonly property string sz: page.sizes[index]

                        shown: page.shown
                        order: index + 1
                        size: sz
                        iconName: main_window.catIcons[index]
                        title: main_window.catNames[index]
                        mb: main_window.avail[index]
                        known: index !== 1
                        maxMb: main_window.maxMb
                        share: main_window.sumAll > 0 ? main_window.avail[index] / main_window.sumAll : 0
                        active: main_window.catOn[index]

                        Layout.fillWidth: true
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: sz === "a" ? 252 : 120
                        Layout.columnSpan: sz === "a" ? 2 : (sz === "b" ? 2 : (sz === "e" ? (page.wide ? 4 : 2) : 1))
                        Layout.rowSpan: sz === "a" ? 2 : 1

                        onToggled: main_window.toggleCat(index)
                        onMoreClicked: main_window.openSheet(index)
                    }
                }
            }

            GlassCard {
                width: parent.width
                height: 72
                shown: page.shown
                order: 10

                Txt {
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    text: str.logsTitle
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    PillButton {
                        text: str.openLogsFolder
                        iconKind: "folder"
                        onClicked: folderHelper.openLogsFolder()
                    }
                    PillButton {
                        text: str.deleteAllLogs
                        iconKind: "trash"
                        onClicked: {
                            folderHelper.deleteLogsFolder()
                            main_window.addNotification(str.deleteSuccess)
                        }
                    }
                }
            }
        }
    }
}
