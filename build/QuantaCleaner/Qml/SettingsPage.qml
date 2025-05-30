// SettingsPage.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Material 2.15
import QtQuick.Templates as T
import QtQuick.Controls.Material.impl
import Qt.labs.settings 1.1


Rectangle {
    id: settings
    anchors.fill: parent
    anchors.leftMargin: 215
    color: theme.backOver

    property bool animationEnabled: quanta_settings.settings_animation
    onAnimationEnabledChanged: quanta_settings.settings_animation = animationEnabled
    property bool reloadEnabled: quanta_settings.settings_reload
    onReloadEnabledChanged: quanta_settings.settings_reload = reloadEnabled
    property bool notifyEnabled: quanta_settings.settings_notify
    onNotifyEnabledChanged: quanta_settings.settings_notify = notifyEnabled
    property bool debugModeEnabled: quanta_settings.debugMode
    onDebugModeEnabledChanged: quanta_settings.debugMode = debugModeEnabled

    Component.onCompleted: {
        rusButton.checked = quanta_settings.settings_language === "rus"
        engButton.checked = quanta_settings.settings_language === "eng"
        Qt.callLater(() => {
            animationSwitch.disableAnimationInit = false
            animationSwitch.initialized = true
            reloadSwitch.disableReloadInit = false
            reloadSwitch.initialized = true
            notifySwitch.disableNotifyInit = false
            notifySwitch.initialized = true
            debugSwitch.disableDebugInit = false
            debugSwitch.initialized = true
            })
        }

        Text {
            text: qsTr("Settings") + (app.languageVersion ? "" : "")
            color: theme.text
            font.pixelSize: 30
            font.bold: true
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
        }

        ScrollView {
            id: scrollView
            anchors.fill: parent
            anchors.topMargin: 65
            clip: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            contentItem: Flickable {
                    contentWidth: columnContainer.width
                    contentHeight: columnContainer.height
                    boundsBehavior: Flickable.StopAtBounds
                    interactive: true


            Column {
                id: columnContainer
                width: scrollView.width
                spacing: 0

                Connections {
                    target: scrollView
                    function onWidthChanged() {
                        columnContainer.width = scrollView.width
                    }
                }


                //1 btn - language
                Rectangle {
                    id: button_1
                    property bool isButtonHover: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHover ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponent
                        Rectangle {
                            id: rippleInstance
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                            color: theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_1.width - x)
                                const dy = Math.max(y, button_1.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstance
                                property: "diameter"
                                to: rippleInstance.targetDiameter
                                duration: 1000
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstance
                                property: "opacity"
                                to: 0
                                duration: 1000
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: function(mouse) {
                              if (animationEnabled) {
                                var ripple = rippleComponent.createObject(button_1)
                                ripple.startAnimation(mouse.x, mouse.y)
                              }
                        }

                        onExited: {
                            button_1.isButtonHover = false
                        }

                        onEntered: {
                            button_1.isButtonHover = true
                        }

                        onClicked: {
                            if (containsMouse) {
                                main_window.isOverlayVisible = true
                                languageDialog.open()
                            }
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 20
                        leftPadding: 20
                        z: 1

                        Image {
                            source: quanta_settings.settings_theme !== 2 ? "assets/images/lang_black.png"  : "assets/images/lang_white.png"
                            width: 31
                            height: 31
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 35

                            Text {
                                text: qsTr('Language') + (app.languageVersion ? "" : "")
                                color: theme.text
                                font.bold: true
                                font.pixelSize: 18
                            }

                            Text {
                                text: qsTr("ThisLang") + (app.languageVersion ? "" : "")
                                color: theme.text
                                font.pixelSize: 14
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandler
                        onHoveredChanged: button_1.isButtonHover = hoverHandler.hovered
                    }
                }


                // 2 btn - customization
                Rectangle {
                    id: button_2
                    property bool isButtonHover2: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHover2 ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponent2
                        Rectangle {
                            id: rippleInstance2
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                            color:  theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_2.width - x)
                                const dy = Math.max(y, button_2.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2.5
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstance2
                                property: "diameter"
                                to: rippleInstance2.targetDiameter
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance2.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstance2
                                property: "opacity"
                                to: 0
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance2.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea2
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: function(mouse) {
                            if (animationEnabled) {
                                var ripple = rippleComponent2.createObject(button_2)
                                ripple.startAnimation(mouse.x, mouse.y)
                            }
                        }

                        onExited: {
                            button_2.isButtonHover2 = false
                        }

                        onEntered: {
                            button_2.isButtonHover2 = true
                        }

                        onClicked: {
                            if (containsMouse) {
                                themeDialog.open()
                                main_window.isOverlayVisible = true
                            }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        width: parent.width - 70

                        Text {
                            text: qsTr("ThemeMode") + (app.languageVersion ? "" : "")
                            color: theme.text
                            font.bold: true
                            font.pixelSize: 16
                        }

                        Text {
                            text: quanta_settings.settings_theme === 2 ? (qsTr("DarkTheme") + (app.languageVersion ? "" : "")) : (qsTr("LightTheme") + (app.languageVersion ? "" : ""))
                            color: theme.text
                            font.pixelSize: 12
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 20
                        leftPadding: 20
                        z: 1

                        Image {
                            source: quanta_settings.settings_theme !== 2 ? "assets/images/moon_black.png" : "assets/images/moon_white.png"
                            width: 34
                            height: 34
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: 2
                        }
                    }

                    HoverHandler {
                        id: hoverHandler2
                        onHoveredChanged: button_2.isButtonHover2 = hoverHandler2.hovered
                    }
                }


                // 3 btn - animation
                Rectangle {
                    id: button_3
                    property bool isButtonHover3: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHover3 ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponent3
                        Rectangle {
                            id: rippleInstance3
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                            color: theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_3.width - x)
                                const dy = Math.max(y, button_3.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2.5
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstance3
                                property: "diameter"
                                to: rippleInstance3.targetDiameter
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance3.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstance3
                                property: "opacity"
                                to: 0
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance3.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea3
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onReleased: function(mouse) {
                            if (containsMouse && !bounceAnimation.running) {
                                settings.animationEnabled = !settings.animationEnabled
                                var ripple = rippleComponent3.createObject(button_3)
                                ripple.startAnimation(mouse.x, mouse.y)
                            }
                        }

                        onExited: {
                            button_3.isButtonHover3 = false
                        }

                        onEntered: {
                            button_3.isButtonHover3 = true
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        width: parent.width - animationSwitch.width - 110

                        Text {
                            text: qsTr("Animations") + (app.languageVersion ? "" : "")
                            color: theme.text
                            font.bold: true
                            font.pixelSize: 16
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        leftPadding: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: quanta_settings.settings_theme !== 2 ? "assets/images/star_black.png" : "assets/images/star_white.png"
                            width: 31
                            height: 31
                            anchors.left: parent.left
                            anchors.leftMargin: 22
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Switch {
                            id: animationSwitch
                            property bool disableAnimationInit: true
                            property bool initialized: false
                            property bool isHover: false

                            width: 55
                            height: 35
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            checked: settings.animationEnabled

                            MouseArea {
                                id: mouseAreaAn
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true

                                onReleased: function(mouse) {
                                        settings.animationEnabled = !settings.animationEnabled
                                  }
                                }

                            Rectangle {
                                anchors.fill: parent
                                radius: height / 2
                                color: animationSwitch.checked ? "#66e8a3" : "#6e2f2f"
                                border.color: animationSwitch.checked ? "#66e8a3" : "#fc6592"
                                border.width: 2
                            }

                            indicator: Rectangle {
                                color: "transparent"
                                border.color: "transparent"
                            }

                            HoverHandler {
                                id: hoverHandlerAnimation
                                onHoveredChanged: animationSwitch.isHover = hovered
                            }

                            Rectangle {
                                id: circle_animation
                                width: 20
                                height: 20
                                radius: width / 2
                                color: animationSwitch.checked ? (animationSwitch.isHover ? "#a30505" : "#7a0202") : (animationSwitch.isHover ? "#719980" : "#fc6592")
                                border.color: animationSwitch.checked ? (animationSwitch.isHover ? "#a30505" : "#7a0202") : (animationSwitch.isHover ? "#719980" : "#fc6592")
                                border.width: 1
                                anchors.verticalCenter: parent.verticalCenter
                                x: animationSwitch.checked ? 27 : 8
                                scale: animationSwitch.checked ? 1.5 : 1

                                Behavior on color {
                                    enabled: !animationSwitch.disableAnimationInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on border.color {
                                    enabled: !animationSwitch.disableAnimationInit
                                    ColorAnimation {
                                        duration: animationSwitch.checked ? 0 : 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on x {
                                    enabled: !animationSwitch.disableAnimationInit
                                    SequentialAnimation {
                                        id: bounceAnimation
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.OutQuad
                                            to: animationSwitch.checked ? 32 : 2
                                        }
                                        NumberAnimation {
                                            duration: 100
                                            easing.type: Easing.InQuad
                                            to: animationSwitch.checked ? 27 : 8
                                        }
                                    }
                                }

                                Behavior on scale {
                                    enabled: !animationSwitch.disableAnimationInit
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutBounce
                                    }
                                }

                                Rectangle {
                                    id: shadow
                                    width: parent.width * 2
                                    height: parent.height * 2
                                    radius: width / 2
                                    anchors.centerIn: parent
                                    color: animationSwitch.checked ? "transparent" : (animationSwitch.isHover ? "#36ba66" : "transparent")
                                    opacity: 0.2
                                    z: -1
                                }
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandler3
                        onHoveredChanged: button_3.isButtonHover3 = hoverHandler3.hovered
                    }
                }


                //4 btn - reloading
                Rectangle {
                    id: button_reload
                    property bool isButtonHoverrel: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHoverrel ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponentReload
                        Rectangle {
                            id: rippleInstanceReload
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                            color: theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_reload.width - x)
                                const dy = Math.max(y, button_reload.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2.5
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstanceReload
                                property: "diameter"
                                to: rippleInstanceReload.targetDiameter
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstanceReload.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstanceReload
                                property: "opacity"
                                to: 0
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstanceReload.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseAreaReload
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onReleased: function(mouse) {
                            if (containsMouse && !bounceAnimationReload.running) {
                                settings.reloadEnabled = !settings.reloadEnabled
                                if (settings.reloadEnabled) {
                                    app.addToAutostart()
                                } else {
                                    app.removeFromAutostart()
                                }
                                  if (animationEnabled) {
                                    var ripple = rippleComponentReload.createObject(button_reload)
                                    ripple.startAnimation(mouse.x, mouse.y)
                                    }
                            }
                        }

                        onExited: {
                            button_reload.isButtonHoverrel = false
                        }

                        onEntered: {
                            button_reload.isButtonHoverrel = true
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: quanta_settings.settings_theme !== 2 ? "assets/images/exchange_black.png" : "assets/images/exchange_white.png"
                            width: 28
                            height: 28
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - reloadSwitch.width - 110
                            anchors.left: parent.left
                            anchors.leftMargin: 49

                            Text {
                                text: qsTr("Autoloading") + (app.languageVersion ? "" : "")
                                color: theme.text
                                font.bold: true
                                font.pixelSize: 16
                            }
                        }

                        Switch {
                            id: reloadSwitch
                            property bool disableReloadInit: true
                            property bool initialized: false
                            property bool isHover: false

                            width: 55
                            height: 35
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 38
                            checked: settings.reloadEnabled

                            MouseArea {
                                id: mouseAreaReload2
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true

                                onReleased: function(mouse) {
                                        settings.reloadEnabled = !settings.reloadEnabled
                                        if (settings.reloadEnabled) {
                                            app.addToAutostart()
                                        } else {
                                            app.removeFromAutostart()
                                        }
                                }
                            }

                            Rectangle {
                                anchors.fill: parent
                                radius: height / 2
                                color: reloadSwitch.checked ? "#66e8a3" : "#6e2f2f"
                                border.color: reloadSwitch.checked ? "#66e8a3" : "#fc6592"
                                border.width: 2
                            }

                            indicator: Rectangle {
                                color: "transparent"
                                border.color: "transparent"
                            }

                            HoverHandler {
                                id: hoverHandlerReloading
                                onHoveredChanged: reloadSwitch.isHover = hovered
                            }

                            Rectangle {
                                id: reload_animation
                                width: 20
                                height: 20
                                radius: width / 2
                                color: reloadSwitch.checked ? (reloadSwitch.isHover ? "#a30505" : "#7a0202") : (reloadSwitch.isHover ? "#719980" : "#fc6592")
                                border.color: reloadSwitch.checked ? (reloadSwitch.isHover ? "#a30505" : "#7a0202") : (reloadSwitch.isHover ? "#719980" : "#fc6592")
                                border.width: 1
                                anchors.verticalCenter: parent.verticalCenter
                                x: reloadSwitch.checked ? 27 : 8
                                scale: reloadSwitch.checked ? 1.5 : 1

                                Behavior on color {
                                    enabled: !reloadSwitch.disableReloadInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on border.color {
                                    enabled: !reloadSwitch.disableReloadInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on x {
                                    enabled: !reloadSwitch.disableReloadInit
                                    SequentialAnimation {
                                        id: bounceAnimationReload
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.OutQuad
                                            to: reloadSwitch.checked ? 32 : 2
                                        }
                                        NumberAnimation {
                                            duration: 100
                                            easing.type: Easing.InQuad
                                            to: reloadSwitch.checked ? 27 : 8
                                        }
                                    }
                                }

                                Behavior on scale {
                                    enabled: !reloadSwitch.disableReloadInit
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutBounce
                                    }
                                }

                                Rectangle {
                                    id: shadowReload
                                    width: parent.width * 2
                                    height: parent.height * 2
                                    radius: width / 2
                                    anchors.centerIn: parent
                                    color: reloadSwitch.checked ? "transparent" : (reloadSwitch.isHover ? "#36ba66" : "transparent")
                                    opacity: 0.2
                                    z: -1
                                }
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandlerrel
                        onHoveredChanged: button_reload.isButtonHoverrel = hoverHandlerrel.hovered
                    }
                }


                // 5 btn - error
                Rectangle {
                    id: button_5
                    property bool isButtonHover5: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHover5 ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponent5
                        Rectangle {
                            id: rippleInstance5
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                            color: theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_5.width - x)
                                const dy = Math.max(y, button_5.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2.5
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstance5
                                property: "diameter"
                                to: rippleInstance5.targetDiameter
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance5.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstance5
                                property: "opacity"
                                to: 0
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstance5.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea5
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: function(mouse) {
                            if (animationEnabled) {
                                var ripple = rippleComponent5.createObject(button_5)
                                ripple.startAnimation(mouse.x, mouse.y)
                            }
                        }

                        onExited: {
                            button_5.isButtonHover5 = false
                        }

                        onEntered: {
                            button_5.isButtonHover5 = true
                        }

                        onClicked: {
                            if (containsMouse) {
                                errorDialog.open()
                                main_window.isOverlayVisible = true
                            }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        width: parent.width - 70

                        Text {
                            text: qsTr("Report") + (app.languageVersion ? "" : "")
                            color: theme.text
                            font.bold: true
                            font.pixelSize: 16
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 20
                        leftPadding: 17
                        z: 1

                        Image {
                            source: quanta_settings.settings_theme !== 2 ?"assets/images/bug_black.png" : "assets/images/bug_white.png"
                            width: 36
                            height: 36
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    HoverHandler {
                        id: hoverHandler5
                        onHoveredChanged: button_5.isButtonHover5 = hoverHandler5.hovered
                    }
                }


                // 6 btn - notify
                Rectangle {
                    id: button_notify
                    property bool isButtonHoverNotify: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHoverNotify ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponentNotify
                        Rectangle {
                            id: rippleInstanceNotify
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                           color: theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_notify.width - x)
                                const dy = Math.max(y, button_notify.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2.5
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstanceNotify
                                property: "diameter"
                                to: rippleInstanceNotify.targetDiameter
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstanceNotify.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstanceNotify
                                property: "opacity"
                                to: 0
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstanceNotify.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseAreaNotify
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onReleased: function(mouse) {
                            if (containsMouse && !bounceAnimationNotify.running) {
                                settings.notifyEnabled = !settings.notifyEnabled
                                if (animationEnabled) {
                                    var ripple = rippleComponentNotify.createObject(button_notify)
                                    ripple.startAnimation(mouse.x, mouse.y)
                                }
                            }
                        }

                        onExited: button_notify.isButtonHoverNotify = false
                        onEntered: button_notify.isButtonHoverNotify = true
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: quanta_settings.settings_theme !== 2 ? "assets/images/cpu_black.png" : "assets/images/cpu_white.png"
                            width: 28
                            height: 31
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - notifySwitch.width - 110
                            anchors.left: parent.left
                            anchors.leftMargin: 49

                            Text {
                                text: qsTr("Notification") + (app.languageVersion ? "" : "")
                                color: theme.text
                                font.bold: true
                                font.pixelSize: 16
                            }
                        }

                        Switch {
                            id: notifySwitch
                            property bool disableNotifyInit: true
                            property bool initialized: false
                            property bool isHover: false

                            width: 55
                            height: 35
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 38
                            checked: settings.notifyEnabled

                            MouseArea {
                                id: mouseAreaNotify2
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true

                                onReleased: function(mouse) {
                                        settings.notifyEnabled = !settings.notifyEnabled

                              }
                            }

                            Rectangle {
                                anchors.fill: parent
                                radius: height / 2
                                color: notifySwitch.checked ? "#66e8a3" : "#6e2f2f"
                                border.color: notifySwitch.checked ? "#66e8a3" : "#fc6592"
                                border.width: 2
                            }

                            indicator: Rectangle {
                                color: "transparent"
                                border.color: "transparent"
                            }

                            HoverHandler {
                                id: hoverHandlerNotifying
                                onHoveredChanged: notifySwitch.isHover = hovered
                            }

                            Rectangle {
                                id: notify_animation
                                width: 20
                                height: 20
                                radius: width / 2
                                color: notifySwitch.checked ? (notifySwitch.isHover ? "#a30505" : "#7a0202") : (notifySwitch.isHover ? "#719980" : "#fc6592")
                                border.color: notifySwitch.checked ? (notifySwitch.isHover ? "#a30505" : "#7a0202") : (notifySwitch.isHover ? "#719980" : "#fc6592")
                                border.width: 1
                                anchors.verticalCenter: parent.verticalCenter
                                x: notifySwitch.checked ? 27 : 8
                                scale: notifySwitch.checked ? 1.5 : 1

                                Behavior on color {
                                    enabled: !notifySwitch.disableNotifyInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on border.color {
                                    enabled: !notifySwitch.disableNotifyInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on x {
                                    enabled: !notifySwitch.disableNotifyInit
                                    SequentialAnimation {
                                        id: bounceAnimationNotify
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.OutQuad
                                            to: notifySwitch.checked ? 32 : 2
                                        }
                                        NumberAnimation {
                                            duration: 100
                                            easing.type: Easing.InQuad
                                            to: notifySwitch.checked ? 27 : 8
                                        }
                                    }
                                }

                                Behavior on scale {
                                    enabled: !notifySwitch.disableNotifyInit
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutBounce
                                    }
                                }

                                Rectangle {
                                    id: shadowNotify
                                    width: parent.width * 2
                                    height: parent.height * 2
                                    radius: width / 2
                                    anchors.centerIn: parent
                                    color: notifySwitch.checked ? "transparent" : (notifySwitch.isHover ? "#36ba66" : "transparent")
                                    opacity: 0.2
                                    z: -1
                                }
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandlerNotify
                        onHoveredChanged: button_notify.isButtonHoverNotify = hoverHandlerNotify.hovered
                    }
                }


                // 7 btn - debugMode
                Rectangle {
                    id: button_debug_mode
                    property bool isButtonHoverDebug: false
                    width: columnContainer.width
                    height: 65
                    color: isButtonHoverDebug ? theme.backOverHover : theme.backOver
                    clip: true

                    Component {
                        id: rippleComponentDebug
                        Rectangle {
                            id: rippleInstanceDebug
                            z: 5
                            property real diameter: 0
                            property real pressX: 0
                            property real pressY: 0
                            property real targetDiameter: 0
                            opacity: 0.3
                            visible: diameter > 0

                            x: pressX - diameter / 2
                            y: pressY - diameter / 2
                            width: diameter
                            height: diameter
                            radius: diameter / 2
                            color: theme.backOverRipple

                            function startAnimation(x, y) {
                                pressX = x
                                pressY = y
                                const dx = Math.max(x, button_debug_mode.width - x)
                                const dy = Math.max(y, button_debug_mode.height - y)
                                const maxDist = Math.sqrt(dx * dx + dy * dy)
                                targetDiameter = maxDist * 2.5
                                diameter = 0
                                opacity = 0.3
                                animDiameter.start()
                                animOpacity.start()
                            }

                            PropertyAnimation {
                                id: animDiameter
                                target: rippleInstanceDebug
                                property: "diameter"
                                to: rippleInstanceDebug.targetDiameter
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstanceDebug.diameter = 0
                            }

                            PropertyAnimation {
                                id: animOpacity
                                target: rippleInstanceDebug
                                property: "opacity"
                                to: 0
                                duration: 1100
                                easing.type: Easing.OutQuad
                                onStopped: rippleInstanceDebug.destroy()
                            }
                        }
                    }

                    MouseArea {
                        id: mouseAreaDebug
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onReleased: function(mouse) {
                            if (containsMouse && !bounceAnimationDebug.running) {
                                settings.debugModeEnabled = !settings.debugModeEnabled
                                if (animationEnabled) {
                                    var ripple = rippleComponentDebug.createObject(button_debug_mode)
                                    ripple.startAnimation(mouse.x, mouse.y)
                                }
                            }
                        }

                        onExited: button_debug_mode.isButtonHoverDebug = false
                        onEntered: button_debug_mode.isButtonHoverDebug = true
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: quanta_settings.settings_theme !== 2 ? "assets/images/fire_black.png" : "assets/images/fire_white.png"
                            width: 31
                            height: 31
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - debugSwitch.width - 110
                            anchors.left: parent.left
                            anchors.leftMargin: 49

                            Text {
                                text: qsTr("Debug") + (app.languageVersion ? "" : "")
                                color: theme.text
                                font.bold: true
                                font.pixelSize: 16
                            }
                        }

                        Switch {
                            id: debugSwitch
                            property bool disableDebugInit: true
                            property bool initialized: false
                            property bool isHover: false

                            width: 55
                            height: 35
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 38
                            checked: settings.debugModeEnabled

                            Rectangle {
                                anchors.fill: parent
                                radius: height / 2
                                color: debugSwitch.checked ? "#66e8a3" : "#6e2f2f"
                                border.color: debugSwitch.checked ? "#66e8a3" : "#fc6592"
                                border.width: 2
                            }

                            MouseArea {
                                id: mouseAreaDebug2
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor

                                onReleased: function(mouse) {
                                        settings.debugModeEnabled = !settings.debugModeEnabled
                                    }
                                }


                            indicator: Rectangle {
                                color: "transparent"
                                border.color: "transparent"
                            }

                            HoverHandler {
                                id: hoverHandlerDebug
                                onHoveredChanged: debugSwitch.isHover = hovered
                            }



                            Rectangle {
                                id: debug_animation
                                width: 20
                                height: 20
                                radius: width / 2
                                color: debugSwitch.checked ? (debugSwitch.isHover ? "#a30505" : "#7a0202") : (debugSwitch.isHover ? "#719980" : "#fc6592")
                                border.color: debugSwitch.checked ? (debugSwitch.isHover ? "#a30505" : "#7a0202") : (debugSwitch.isHover ? "#719980" : "#fc6592")
                                border.width: 1
                                anchors.verticalCenter: parent.verticalCenter
                                x: debugSwitch.checked ? 27 : 8
                                scale: debugSwitch.checked ? 1.5 : 1

                                Behavior on color {
                                    enabled: !debugSwitch.disableDebugInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on border.color {
                                    enabled: !debugSwitch.disableDebugInit
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Behavior on x {
                                    enabled: !debugSwitch.disableDebugInit
                                    SequentialAnimation {
                                        id: bounceAnimationDebug
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.OutQuad
                                            to: debugSwitch.checked ? 32 : 2
                                        }
                                        NumberAnimation {
                                            duration: 100
                                            easing.type: Easing.InQuad
                                            to: debugSwitch.checked ? 27 : 8
                                        }
                                    }
                                }

                                Behavior on scale {
                                    enabled: !debugSwitch.disableDebugInit
                                    NumberAnimation {
                                        duration: 200
                                        easing.type: Easing.OutBounce
                                    }
                                }

                                Rectangle {
                                    id: shadowDebug
                                    width: parent.width * 2
                                    height: parent.height * 2
                                    radius: width / 2
                                    anchors.centerIn: parent
                                    color: debugSwitch.checked ? "transparent" : (debugSwitch.isHover ? "#36ba66" : "transparent")
                                    opacity: 0.2
                                    z: -1
                                }
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandlerDebugMode
                        onHoveredChanged: button_debug_mode.isButtonHoverDebug = hoverHandlerDebugMode.hovered
                    }
                }


            }
        }
    }





        Popup {
            id:  errorDialog
            focus: true
            width: 500
            height: 200
            z: 22
            x: (parent.width - width) / 2 - 100
            y: (parent.height - height) / 2
            onClosed: main_window.isOverlayVisible = false

            background: Rectangle {
                color: "transparent"
            }

            Rectangle {
                width: 24
                height: 24
                color: theme.button
                anchors.right: parent.right
                anchors.rightMargin: 17
                anchors.top: parent.top
                anchors.topMargin: 12
                radius: 10
                z: 2
                Image {
                    source: "assets/images/parametrs/cross.png"
                    anchors.centerIn: parent
                    width: parent.width - 2
                    height: parent.height - 2
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        main_window.isOverlayVisible = false
                        errorDialog.visible = false
                    }
                }
            }




            Rectangle {
                anchors.fill: parent
                color: theme.background
                radius: 30

                Canvas {
                    id: gradientText1
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -65
                    width: 500
                    height: 50
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)

                        var gradient = ctx.createLinearGradient(0, 0, width, 0)
                        gradient.addColorStop(0, "#FF0000")
                        gradient.addColorStop(1, "#FF8888")

                        ctx.font = "bold 33px '" + cleanerFont.name + "'"
                        ctx.fillStyle = gradient
                        ctx.textAlign = "center"
                        ctx.textBaseline = "middle"
                        ctx.fillText(qsTr("FindError"), width / 2, height / 2)
                    }

                    onWidthChanged: requestPaint()
                    onHeightChanged: requestPaint()
                }

                Canvas {
                    id: gradientText2
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -20
                    width: 500
                    height: 50
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)

                        var gradient = ctx.createLinearGradient(0, 0, width, 0)
                        gradient.addColorStop(0, "#FF0000")
                        gradient.addColorStop(1, "#FF8888")

                        ctx.font = "bold 33px '" + cleanerFont.name + "'"
                        ctx.fillStyle = gradient
                        ctx.textAlign = "center"
                        ctx.textBaseline = "middle"
                        ctx.fillText(qsTr("Support"), width / 2, height / 2)
                    }

                    onWidthChanged: requestPaint()
                    onHeightChanged: requestPaint()
                }


                Rectangle {
                    id: tme
                    property bool tme_hovered: false
                    width: 295
                    height: 57
                    color: tme_hovered  ? theme.hover : theme.button
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    anchors.bottomMargin: 25
                    radius: 10

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("t.me//unreallx")
                        font.bold: true
                        color: theme.text
                        font.pixelSize: 35
                        font.family: cleanerFont.name
                        opacity: 0.8
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                                ClipboardHelper.copyText("t.me//unreallx")
                                main_window.addNotification(qsTr("Copied") + (app.languageVersion ? "" : ""))
                            }
                    }

                    HoverHandler {
                        onHoveredChanged: tme.tme_hovered = hovered
                    }
                }

                Rectangle {
                    id: clipboard
                    property bool  clip_hovered: false
                    width: 57
                    height: 57
                    color: clip_hovered  ? theme.hover : theme.button
                    radius: 10
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 90
                    anchors.bottomMargin: 25

                    Image {
                        width: 50
                        height: 50
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -3
                        source: quanta_settings.settings_theme === 2 ? "assets/images/clipboard_white.png" : "assets/images/clipboard_black.png"
                    }

                    HoverHandler {
                        onHoveredChanged: clipboard.clip_hovered = hovered
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                                ClipboardHelper.copyText("t.me//unreallx")
                                main_window.addNotification(qsTr("Copied") + (app.languageVersion ? "" : ""))
                            }
                    }
                }

                Rectangle {
                    id: browser_img
                    property bool browser_hovered: false
                    width: 57
                    height: 57
                    color:  browser_hovered  ? theme.hover : theme.button
                    radius: 10
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 25
                    anchors.bottomMargin: 25
                    Image {
                        width: 50
                        height: 50
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -1
                        source: quanta_settings.settings_theme === 2 ? "assets/images/browser_white.png" : "assets/images/browser_black.png"
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                                Qt.openUrlExternally("https://t.me/unreallx")
                            }
                    }

                    HoverHandler {
                        onHoveredChanged: browser_img.browser_hovered = hovered
                    }
                }
            }
        }





        Popup {
            id: themeDialog
            modal: true
            focus: true
            dim: false
            width: 400
            height: 240
            z: 22
            x: (parent.width - width) / 2 - 100
            y: (parent.height - height) / 2
            onClosed: main_window.isOverlayVisible = false
            background: Rectangle {
                color: "transparent"
            }

            Rectangle {
                width: 25
                height: 25
                color:  theme.button
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 8
                radius: 10
                z: 2
                Image {
                    source: "assets/images/parametrs/cross.png"
                    anchors.centerIn: parent
                    width: parent.width - 2
                    height: parent.height - 2
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        main_window.isOverlayVisible = false
                        themeDialog.visible = false
                    }
                }
            }


            Rectangle {
                anchors.fill: parent
                color: theme.background
                radius: 25

                    Text {
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("ChooseThemeMode") + (app.languageVersion ? "" : "")
                        color: theme.text
                        font.pixelSize: 20
                        font.bold: true
                    }

                    ButtonGroup {
                        id: buttonGroupTheme
                    }

                    //white theme
                    Rectangle {
                        id: whiteThemeRec
                        property bool whiteThemeRec_hovered: false
                        width: 325
                        height: 70
                        color: whiteThemeRec_hovered  ? theme.hover : theme.button
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.topMargin: 40
                        radius: 10

                        RadioButton {
                            id: whiteButton
                            anchors.centerIn: parent
                            text: qsTr("LightTheme") + (app.languageVersion ? "" : "")
                            font.pixelSize: 20
                            font.bold: true
                            scale: 1.1
                            checked: quanta_settings.settings_theme === 1

                            contentItem: Text {
                                leftPadding: whiteButton.indicator && !whiteButton.mirrored ? whiteButton.indicator.width + whiteButton.spacing : 0
                                rightPadding: whiteButton.indicator && whiteButton.mirrored ? whiteButton.indicator.width +whiteButton.spacing : 0

                                text: whiteButton.text
                                font: whiteButton.font
                                color: theme.text
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            indicator: RadioIndicator {
                                    control: whiteButton
                                    y: 16
                                    x: 5
                                }
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked:  {
                                whiteButton.checked = true
                                darkButton.checked = false
                                quanta_settings.settings_theme = 1
                                applyTheme()
                            }
                        }
                        HoverHandler {
                            onHoveredChanged: whiteThemeRec.whiteThemeRec_hovered = hovered
                        }
                    }

                    //dark theme
                    Rectangle {
                        id: darkThemeRec
                        property bool darkThemeRec_hovered: false
                        width: 325
                        height: 70
                        color: darkThemeRec_hovered ? theme.hover : theme.button
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.bottomMargin: 25
                        radius: 10

                        RadioButton {
                            id: darkButton
                            anchors.centerIn: parent
                            text: qsTr("DarkTheme") + (app.languageVersion ? "" : "")
                            font.pixelSize: 20
                            font.bold: true
                            scale: 1.1
                            checked: quanta_settings.settings_theme === 2
                            contentItem: Text {
                                leftPadding: darkButton.indicator && !darkButton.mirrored ? darkButton.indicator.width + darkButton.spacing : 0
                                rightPadding: darkButton.indicator && darkButton.mirrored ? darkButton.indicator.width + darkButton.spacing : 0
                                text: darkButton.text
                                font: darkButton.font
                                color: theme.text
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                            indicator: RadioIndicator {
                                    control: darkButton
                                    y: 16
                                    x: 5
                                }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                darkButton.checked = true
                                whiteButton.checked = false
                                quanta_settings.settings_theme = 2
                                applyTheme()
                            }
                        }
                        HoverHandler {
                            onHoveredChanged: darkThemeRec.darkThemeRec_hovered = hovered
                        }
                    }
                }
        }






        Popup {
            id: languageDialog
            dim: false
            modal: true
            focus: true
            width: 400
            height: 240
            z: 22
            x: (parent.width - width) / 2 - 100
            y: (parent.height - height) / 2
            onClosed: main_window.isOverlayVisible = false
            background: Rectangle {
                color: "transparent"
            }

            Rectangle {
                width: 25
                height: 25
                color:  theme.button
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 8
                radius: 10
                z: 2
                Image {
                    source: "assets/images/parametrs/cross.png"
                    anchors.centerIn: parent
                    width: parent.width - 2
                    height: parent.height - 2
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        main_window.isOverlayVisible = false
                        languageDialog.visible = false
                    }
                }
            }



            Rectangle {
                anchors.fill: parent
                color: theme.background
                radius: 25

                    Text {
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("ChooseLang") + (app.languageVersion ? "" : "")
                        color: theme.text
                        font.pixelSize: 20
                        font.bold: true
                    }

                    // ButtonGroup {
                    //     id: buttonGroupLanguage
                    // }

                    Rectangle {
                        id: rusLangRec
                        property bool rusLangRec_hovered: false
                        width: 325
                        height: 70
                        color: rusLangRec_hovered  ? theme.hover : theme.button
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.topMargin: 40
                        radius: 10

                        RadioButton {
                            id: rusButton
                            anchors.centerIn: parent
                            text: "Русский"
                            font.pixelSize: 20
                            font.bold: true
                            scale: 1.1

                            contentItem: Text {
                                leftPadding: rusButton.indicator && !rusButton.mirrored ? rusButton.indicator.width + rusButton.spacing : 0
                                rightPadding: rusButton.indicator && rusButton.mirrored ? rusButton.indicator.width + rusButton.spacing : 0

                                text: rusButton.text
                                font: rusButton.font
                                color: theme.text
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            indicator: RadioIndicator {
                                    control: rusButton
                                    y: 16
                                    x: 5
                                }
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked:  {
                                app.setLanguage("rus")
                                quanta_settings.settings_language = "rus"
                                rusButton.checked = true
                                engButton.checked = false
                            }
                        }
                        HoverHandler {
                            onHoveredChanged: rusLangRec.rusLangRec_hovered = hovered
                        }
                    }

                    Rectangle {
                        id: engLangRec
                        property bool engLangRec_hovered: false
                        width: 325
                        height: 70
                        color: engLangRec_hovered ? theme.hover : theme.button
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.bottomMargin: 25
                        radius: 10

                        RadioButton {
                            id: engButton
                            anchors.centerIn: parent
                            text: "English"
                            font.pixelSize: 20
                            font.bold: true
                            scale: 1.1
                            contentItem: Text {
                                leftPadding: engButton.indicator && !engButton.mirrored ? engButton.indicator.width + engButton.spacing : 0
                                rightPadding: engButton.indicator && engButton.mirrored ? engButton.indicator.width + engButton.spacing : 0
                                text: engButton.text
                                font: engButton.font
                                color: theme.text
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            indicator: RadioIndicator {
                                control: engButton
                                y: 16
                                x: 5
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                app.setLanguage("eng")
                                quanta_settings.settings_language = "eng"
                                engButton.checked = true
                                rusButton.checked = false

                            }
                        }
                        HoverHandler {
                            onHoveredChanged: engLangRec.engLangRec_hovered = hovered
                        }
                    }
                }
        }
}
