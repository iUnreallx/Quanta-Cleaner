import QtQuick

Item {
    id: pb

    property string text: ""
    property string iconKind: ""
    property url iconSource
    property bool filled: false
    signal clicked()

    readonly property color fg: filled ? theme.ink : theme.txt

    implicitHeight: 44
    implicitWidth: content.width + 40
    width: implicitWidth
    height: implicitHeight

    opacity: enabled ? 1 : 0.45

    scale: ma.pressed ? 0.95 : (ma.containsMouse ? 1.02 : 1)
    Behavior on scale {
        enabled: quanta_settings.settings_animation
        NumberAnimation { duration: ma.pressed ? 100 : 450; easing.type: Easing.OutBack }
    }

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: pb.filled ? (ma.containsMouse ? Qt.lighter(theme.acc, 1.08) : theme.acc)
                         : (ma.containsMouse ? theme.line : "transparent")
        border.width: pb.filled ? 0 : 1
        border.color: theme.line2
        Behavior on color { ColorAnimation { duration: 200 } }
    }

    Row {
        id: content
        anchors.centerIn: parent
        spacing: 10

        Ico {
            visible: pb.iconKind !== ""
            width: 18
            height: 18
            anchors.verticalCenter: parent.verticalCenter
            kind: pb.iconKind
            color: pb.fg
        }
        TintImage {
            visible: pb.iconKind === "" && pb.iconSource != ""
            width: 18
            height: 18
            anchors.verticalCenter: parent.verticalCenter
            source: pb.iconSource
            color: pb.fg
        }
        Txt {
            anchors.verticalCenter: parent.verticalCenter
            text: pb.text
            color: pb.fg
            font.pixelSize: 15
            font.weight: Font.DemiBold
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: pb.clicked()
    }
}
