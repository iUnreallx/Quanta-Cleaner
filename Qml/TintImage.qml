import QtQuick
import QtQuick.Effects

Item {
    id: ti

    property url source
    property color color: theme.txt
    property int decode: 128

    implicitWidth: 24
    implicitHeight: 24

    Image {
        id: img
        anchors.fill: parent
        source: ti.source
        sourceSize.width: ti.decode
        sourceSize.height: ti.decode
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: img
        colorization: 1.0
        colorizationColor: ti.color
    }
}
