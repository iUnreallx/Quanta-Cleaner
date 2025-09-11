import QtQuick 2.15

Rectangle {
    id: about
    anchors.fill: parent
    color: theme.backOver
    anchors.leftMargin: 215

    Text {
        text: "Quanta Cleaner v1.0.0"
        font.bold: true
        font.family: cleanerFont.name
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        color: theme.text
    }

    Image {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 12
        anchors.leftMargin: 345
        width: 45
        height: 45
        source: "assets/images/ico.png"

    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 65
        color: "#4B2022"
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: parent.width - 20
        height: 3
        radius: 10
    }


    Text {
        id: descriptionApp
        text: qsTr("AboutApp")
        font.bold: true
        font.family: cleanerFont.name
        font.pixelSize: 16
        color: theme.text
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        wrapMode: Text.Wrap
        width: parent.width - 20
    }


    Rectangle {
        id: browser_img2
        property bool browser2_hovered: false
        width: 57
        height: 57
        color:  browser2_hovered  ? theme.hover : theme.button
        radius: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: descriptionApp.bottom
        anchors.topMargin: 10

        Image {
            width: 50
            height: 50
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -2
            source: quanta_settings.settings_theme === 2 ? "assets/images/telegram_white.png" : "assets/images/telegram_black.png"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                    Qt.openUrlExternally("https://t.me/unreallx")
                }
        }

        HoverHandler {
            onHoveredChanged: browser_img2.browser2_hovered = hovered
        }
    }



    Rectangle {
        id:  github
        property bool github_hovered: false
        width: 57
        height: 57
        color:  github_hovered  ? theme.hover : theme.button
        radius: 10
        anchors.left: parent.left
        anchors.leftMargin: 75
        anchors.top: descriptionApp.bottom
        anchors.topMargin: 10

        Image {
            width: 50
            height: 50
            anchors.centerIn: parent
            source: quanta_settings.settings_theme === 2 ? "assets/images/github_white.png" : "assets/images/github_black.png"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                    Qt.openUrlExternally("https://github.com/iUnreallx/Quanta-Cleaner")
                }
        }

        HoverHandler {
            onHoveredChanged: github.github_hovered = hovered
        }
    }



}
