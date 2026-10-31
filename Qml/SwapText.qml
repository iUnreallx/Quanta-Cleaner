import QtQuick

Item {
    id: sw

    property string text: ""
    property color color: theme.txt2
    property int pixelSize: 13
    property int weight: Font.Medium
    property int align: Text.AlignHCenter
    readonly property bool animate: quanta_settings.settings_animation

    property string shown: ""
    property bool ready: false

    clip: true
    implicitHeight: pixelSize + 6
    implicitWidth: label.implicitWidth

    Component.onCompleted: {
        shown = text
        ready = true
    }

    function swapNow() {
        shown = text
        label.y = height
    }

    onTextChanged: {
        if (!ready || !animate || width <= 0) {
            shown = text
            return
        }
        swapAnim.restart()
    }

    Txt {
        id: label
        width: sw.width
        text: sw.shown
        color: sw.color
        font.pixelSize: sw.pixelSize
        font.weight: sw.weight
        horizontalAlignment: sw.align
        elide: Text.ElideRight
    }

    SequentialAnimation {
        id: swapAnim
        ParallelAnimation {
            NumberAnimation { target: label; property: "y"; to: -sw.height; duration: 200; easing.type: Easing.InCubic }
            NumberAnimation { target: label; property: "opacity"; to: 0; duration: 200 }
        }
        ScriptAction { script: sw.swapNow() }
        ParallelAnimation {
            NumberAnimation { target: label; property: "y"; to: 0; duration: 380; easing.type: Easing.OutCubic }
            NumberAnimation { target: label; property: "opacity"; to: 1; duration: 300 }
        }
    }
}
