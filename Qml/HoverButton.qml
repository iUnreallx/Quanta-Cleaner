import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

Button {
    id: button

    property bool isActive: false
    property bool isHovered: false
    property bool animationEnabled: quanta_settings.settings_animation

    contentItem: Column {
        anchors.centerIn: parent

        Text {
            id: this_text
            text: button.text
            font.pixelSize: 27
            font.bold: true
            color: isActive ? (quanta_settings.settings_theme === 2 ? "#d4b726" :  "#054300") : theme.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: isHovered ? -15 : -10

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: !animationEnabled ? 0 : 250
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Rectangle {
            id: underline
            anchors.horizontalCenter: parent.horizontalCenter
            height: 3.5
            width: parent.width * 1.2
            color: isHovered ? "#11227C" : "#ffff00"
            radius: 100
            anchors.top: parent.top
            anchors.topMargin: 40
            transform: Translate {y: -10}

            Behavior on color {
                ColorAnimation {
                    duration: !animationEnabled ? 0 : 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    background: Rectangle {
        color: "transparent"
    }

    HoverHandler {
        id: hoverHandler
        target: parent
        onHoveredChanged: isHovered = hovered
    }
}
