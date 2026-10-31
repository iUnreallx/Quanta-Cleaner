import QtQuick

Item {
    id: seg

    property var options: []
    property int currentIndex: 0
    signal picked(int index)

    implicitWidth: row.width + 6
    implicitHeight: 36
    width: implicitWidth
    height: implicitHeight

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "transparent"
        border.width: 1
        border.color: theme.line2
    }

    Rectangle {
        id: hl
        y: 3
        height: 30
        radius: 15
        color: theme.raise
        border.width: 1
        border.color: theme.line2
        x: {
            var n = btns.count
            var it = btns.itemAt(seg.currentIndex)
            return 3 + (it ? it.x : 0)
        }
        width: {
            var n = btns.count
            var it = btns.itemAt(seg.currentIndex)
            return it ? it.width : 40
        }
        Behavior on x {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: 600; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.16, 1, 0.3, 1, 1, 1] }
        }
        Behavior on width {
            enabled: quanta_settings.settings_animation
            NumberAnimation { duration: 600; easing.type: Easing.BezierSpline; easing.bezierCurve: [0.16, 1, 0.3, 1, 1, 1] }
        }
    }

    Row {
        id: row
        x: 3
        y: 3

        Repeater {
            id: btns
            model: seg.options
            delegate: Item {
                id: b
                required property int index
                required property string modelData
                width: lbl.implicitWidth + 30
                height: 30

                Txt {
                    id: lbl
                    anchors.centerIn: parent
                    text: b.modelData
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                    color: seg.currentIndex === b.index ? theme.txt : theme.txt3
                    Behavior on color { ColorAnimation { duration: 300 } }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: seg.picked(b.index)
                }
            }
        }
    }
}
