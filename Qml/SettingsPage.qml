// SettingsPage.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.0
import Qt.labs.settings 1.1


    Rectangle {
        id: settings
        anchors.fill: parent
        anchors.leftMargin: 215
        color: "#000"

        property bool animationEnabled: quanta_settings.settings_animation
        onAnimationEnabledChanged: quanta_settings.settings_animation = animationEnabled
        property bool reloadEnabled: quanta_settings.settings_reload
        onReloadEnabledChanged: quanta_settings.settings_reload = reloadEnabled
        property bool notifyEnabled: quanta_settings.settings_notify
        onNotifyEnabledChanged: quanta_settings.settings_notify = notifyEnabled
        property bool debugModeEnabled: quanta_settings.debugMode
        onDebugModeEnabledChanged: quanta_settings.debugMode = debugModeEnabled

        Component.onCompleted: {
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
            text: qsTr("Настройки")
            color: "white"
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
                    color: isButtonHover ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainer
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRect
                            color: "white"
                            opacity: 0.0
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransform
                                origin.x: rippleRect.width / 2
                                origin.y: rippleRect.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            if (animationEnabled) {
                                var mx = mouseX;
                                var my = mouseY;
                                var d1 = Math.sqrt(mx * mx + my * my);
                                var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                                var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                                var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                                var maxD = Math.max(d1, d2, d3, d4);
                                rippleRect.width = 2 * maxD;
                                rippleRect.height = 2 * maxD;
                                rippleRect.x = mx - maxD;
                                rippleRect.y = my - maxD;
                                scaleTransform.xScale = 0;
                                scaleTransform.yScale = 0;
                                rippleRect.opacity = 0.2;
                                rippleRect.visible = true;
                                rippleAnimation.start();
                            }
                        }

                        onExited: {
                            rippleAnimation.stop();
                            fadeOutAnimation.start();
                            button_1.isButtonHover = false;
                        }

                        onEntered: {
                            button_1.isButtonHover = true;
                        }

                        onClicked: {
                            if (containsMouse) {
                                main_window.isOverlayVisible = true;
                                languageDialog.open();
                            }
                        }
                    }

                    NumberAnimation {
                        id: rippleAnimation
                        target: scaleTransform
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        duration: 500
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransform.xScale >= 1 && !mouseArea.pressed) {
                                fadeOutAnimation.start();
                            }
                        }
                    }

                    NumberAnimation {
                        id: fadeOutAnimation
                        target: rippleRect
                        property: "opacity"
                        from: rippleRect.opacity
                        to: 0
                        duration: 300
                        onStopped: {
                            rippleRect.visible = false;
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 20
                        leftPadding: 20
                        z: 1

                        Image {
                            source: "assets/images/lang_white.png"
                            width: 31
                            height: 31
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 35

                            Text {
                                text: qsTr('Язык')
                                color: "white"
                                font.bold: true
                                font.pixelSize: 18
                            }

                            Text {
                                text: qsTr("Русский")
                                color: "white"
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
                    color: isButtonHover2 ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainer2
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRect2
                            color: "white"
                            opacity: 0.0
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransform2
                                origin.x: rippleRect2.width / 2
                                origin.y: rippleRect2.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea2
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            if (animationEnabled) {
                                var mx = mouseX;
                                var my = mouseY;
                                var d1 = Math.sqrt(mx * mx + my * my);
                                var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                                var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                                var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                                var maxD = Math.max(d1, d2, d3, d4);
                                rippleRect2.width = 2 * maxD;
                                rippleRect2.height = 2 * maxD;
                                rippleRect2.x = mx - maxD;
                                rippleRect2.y = my - maxD;
                                scaleTransform2.xScale = 0;
                                scaleTransform2.yScale = 0;
                                rippleRect2.opacity = 0.2;
                                rippleRect2.visible = true;
                                rippleAnimation2.start();
                            }
                        }

                        onExited: {
                            rippleAnimation2.stop();
                            fadeOutAnimation2.start();
                            button_2.isButtonHover2 = false;
                        }

                        onEntered: {
                            button_2.isButtonHover2 = true;
                        }

                        onClicked: {
                            if (containsMouse) {
                                // main_window.isOverlayVisible = true;
                            }
                        }
                    }

                    NumberAnimation {
                        id: rippleAnimation2
                        target: scaleTransform2
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        duration: 500
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransform2.xScale >= 1 && !mouseArea2.pressed) {
                                fadeOutAnimation2.start();
                            }
                        }
                    }

                    NumberAnimation {
                        id: fadeOutAnimation2
                        target: rippleRect2
                        property: "opacity"
                        from: rippleRect2.opacity
                        to: 0
                        duration: 300
                        onStopped: {
                            rippleRect2.visible = false;
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        width: parent.width - 70

                        Text {
                            text: qsTr("Оформление")
                            color: "white"
                            font.bold: true
                            font.pixelSize: 16
                        }

                        Text {
                            text: qsTr("Тёмная тема")
                            color: "white"
                            font.pixelSize: 12
                        }
                    }

                    Row {
                        anchors.fill: parent
                        spacing: 20
                        leftPadding: 20
                        z: 1

                        Image {
                            source: "assets/images/moon_white.png"
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
                    color: isButtonHover3 ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainer3
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRect3
                            color: "white"
                            opacity: 0.2
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransform3
                                origin.x: rippleRect3.width / 2
                                origin.y: rippleRect3.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea3
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            var mx = mouseX;
                            var my = mouseY;
                            var d1 = Math.sqrt(mx * mx + my * my);
                            var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                            var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                            var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                            var maxD = Math.max(d1, d2, d3, d4);
                            rippleRect3.width = 2 * maxD;
                            rippleRect3.height = 2 * maxD;
                            rippleRect3.x = mx - maxD;
                            rippleRect3.y = my - maxD;
                            scaleTransform3.xScale = 0;
                            scaleTransform3.yScale = 0;
                            rippleRect3.visible = true;
                            rippleAnimation3.duration = 500;
                            rippleAnimation3.start();
                        }

                        onReleased: {
                            if (containsMouse && !bounceAnimation.running) {
                                settings.animationEnabled = !settings.animationEnabled
                            }
                        }

                        onExited: {
                            rippleAnimation3.stop();
                            rippleRect3.visible = false;
                            button_3.isButtonHover3 = false;
                        }

                        onEntered: {
                            button_3.isButtonHover3 = true;
                        }
                    }

                    NumberAnimation {
                        id: rippleAnimation3
                        target: scaleTransform3
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransform3.xScale >= 1 && !mouseArea3.pressed) {
                                rippleRect3.visible = false;
                            }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        width: parent.width - animationSwitch.width - 110

                        Text {
                            text: qsTr("Анимации")
                            color: "white"
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
                            source: "assets/images/star_white.png"
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
                    color: isButtonHoverrel ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainerReload
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRectReload
                            color: "white"
                            opacity: 0.2
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransformReload
                                origin.x: rippleRectReload.width / 2
                                origin.y: rippleRectReload.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    MouseArea {
                        id: mouseAreaReload
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            if (animationEnabled) {
                                var mx = mouseX;
                                var my = mouseY;
                                var d1 = Math.sqrt(mx * mx + my * my);
                                var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                                var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                                var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                                var maxD = Math.max(d1, d2, d3, d4);
                                rippleRectReload.width = 2 * maxD;
                                rippleRectReload.height = 2 * maxD;
                                rippleRectReload.x = mx - maxD;
                                rippleRectReload.y = my - maxD;
                                scaleTransformReload.xScale = 0;
                                scaleTransformReload.yScale = 0;
                                rippleRectReload.visible = true;
                                rippleAnimationReload.duration = 500;
                                rippleAnimationReload.start();
                            }
                        }

                        onReleased: {
                            if (containsMouse && !bounceAnimationReload.running) {
                                settings.reloadEnabled = !settings.reloadEnabled
                                if (settings.reloadEnabled) {
                                    app.addToAutostart()
                                } else {
                                    app.removeFromAutostart()
                                }
                            }
                        }


                        onExited: {
                            rippleAnimationReload.stop();
                            rippleRectReload.visible = false;
                            button_reload.isButtonHoverrel = false;
                        }

                        onEntered: {
                            button_reload.isButtonHoverrel = true;
                        }
                    }

                    NumberAnimation {
                        id: rippleAnimationReload
                        target: scaleTransformReload
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransformReload.xScale >= 1 && !mouseAreaReload.pressed) {
                                rippleRectReload.visible = false;
                            }
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: "assets/images/exchange_white.png"
                            width: 28
                            height: 28
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - reloadSwitch.width - 110
                            anchors.left: parent.left
                            anchors.leftMargin:  49

                            Text {
                                text: qsTr("Автозагрузка")
                                color: "white"
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
                    color: isButtonHover5 ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainer5
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRect5
                            color: "white"
                            opacity: 0.0
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransform5
                                origin.x: rippleRect5.width / 2
                                origin.y: rippleRect5.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        width: parent.width - 70

                        Text {
                            text: qsTr("Сообщить об ошибке")
                            color: "white"
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
                            source: "assets/images/bug_white.png"
                            width: 36
                            height: 36
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: mouseArea5
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            if (animationEnabled) {
                                var mx = mouseX;
                                var my = mouseY;
                                var d1 = Math.sqrt(mx * mx + my * my);
                                var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                                var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                                var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                                var maxD = Math.max(d1, d2, d3, d4);

                                rippleRect5.width = 2 * maxD;
                                rippleRect5.height = 2 * maxD;
                                rippleRect5.x = mx - maxD;
                                rippleRect5.y = my - maxD;

                                scaleTransform5.xScale = 0;
                                scaleTransform5.yScale = 0;

                                rippleRect5.opacity = 0.2;
                                rippleRect5.visible = true;

                                rippleAnimation5.start();
                            }
                        }

                        onExited: {
                            rippleAnimation5.stop();
                            fadeOutAnimation5.start();
                            button_5.isButtonHover5 = false;
                        }

                        onEntered: {
                            button_5.isButtonHover5 = true;
                        }

                        onClicked: {
                            if (containsMouse) {
                                //
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandler5
                        onHoveredChanged: button_5.isButtonHover5 = hoverHandler5.hovered
                    }

                    NumberAnimation {
                        id: rippleAnimation5
                        target: scaleTransform5
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        duration: 500
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransform5.xScale >= 1 && !mouseArea5.pressed) {
                                fadeOutAnimation5.start();
                            }
                        }
                    }

                    NumberAnimation {
                        id: fadeOutAnimation5
                        target: rippleRect5
                        property: "opacity"
                        from: rippleRect5.opacity
                        to: 0
                        duration: 300
                        onStopped: {
                            rippleRect5.visible = false;
                        }
                    }
                }


                // 6 btn - notify
                Rectangle {
                    id: button_notify
                    property bool isButtonHoverNotify: false

                    width: columnContainer.width
                    height: 65
                    color: isButtonHoverNotify ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainerNotify
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRectNotify
                            color: "white"
                            opacity: 0.2
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransformNotify
                                origin.x: rippleRectNotify.width / 2
                                origin.y: rippleRectNotify.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    MouseArea {
                        id: mouseAreaNotify
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            if (animationEnabled) {
                                var mx = mouseX;
                                var my = mouseY;
                                var d1 = Math.sqrt(mx * mx + my * my);
                                var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                                var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                                var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                                var maxD = Math.max(d1, d2, d3, d4);
                                rippleRectNotify.width = 2 * maxD;
                                rippleRectNotify.height = 2 * maxD;
                                rippleRectNotify.x = mx - maxD;
                                rippleRectNotify.y = my - maxD;
                                scaleTransformNotify.xScale = 0;
                                scaleTransformNotify.yScale = 0;
                                rippleRectNotify.visible = true;
                                rippleAnimationNotify.duration = 500;
                                rippleAnimationNotify.start();
                            }
                        }

                        onReleased: {
                            if (containsMouse && !bounceAnimationNotify.running) {
                                settings.notifyEnabled = !settings.notifyEnabled
                            }
                        }

                        onExited: {
                            rippleAnimationNotify.stop();
                            rippleRectNotify.visible = false;
                            button_notify.isButtonHoverNotify = false;
                        }

                        onEntered: {
                            button_notify.isButtonHoverNotify = true;
                        }
                    }

                    NumberAnimation {
                        id: rippleAnimationNotify
                        target: scaleTransformNotify
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransformNotify.xScale >= 1 && !mouseAreaNotify.pressed) {
                                rippleRectNotify.visible = false;
                            }
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: "assets/images/cpu_white.png"
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
                                text: qsTr("Расположение уведомлений")
                                color: "white"
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
                    color: isButtonHoverDebug ? "#111111" : "black"
                    clip: true

                    Item {
                        id: rippleContainerDebug
                        anchors.fill: parent
                        z: 0

                        Rectangle {
                            id: rippleRectDebug
                            color: "white"
                            opacity: 0.2
                            visible: false
                            radius: width / 2
                            transform: Scale {
                                id: scaleTransformDebug
                                origin.x: rippleRectDebug.width / 2
                                origin.y: rippleRectDebug.height / 2
                                xScale: 0
                                yScale: 0
                            }
                        }
                    }

                    MouseArea {
                        id: mouseAreaDebug
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onPressed: {
                            if (animationEnabled) {
                                var mx = mouseX;
                                var my = mouseY;
                                var d1 = Math.sqrt(mx * mx + my * my);
                                var d2 = Math.sqrt(mx * mx + (parent.height - my) * (parent.height - my));
                                var d3 = Math.sqrt((parent.width - mx) * (parent.width - mx) + my * my);
                                var d4 = Math.sqrt((parent.width - mx) * (parent.width - mx) + (parent.height - my) * (parent.height - my));
                                var maxD = Math.max(d1, d2, d3, d4);
                                rippleRectDebug.width = 2 * maxD;
                                rippleRectDebug.height = 2 * maxD;
                                rippleRectDebug.x = mx - maxD;
                                rippleRectDebug.y = my - maxD;
                                scaleTransformDebug.xScale = 0;
                                scaleTransformDebug.yScale = 0;
                                rippleRectDebug.visible = true;
                                rippleAnimationDebug.duration = 500;
                                rippleAnimationDebug.start();
                            }
                        }

                        onReleased: {
                            if (containsMouse && !bounceAnimationDebug.running) {
                                settings.debugModeEnabled = !settings.debugModeEnabled
                            }
                        }

                        onExited: {
                            rippleAnimationDebug.stop();
                            rippleRectDebug.visible = false;
                            button_debug_mode.isButtonHoverDebug = false;
                        }

                        onEntered: {
                            button_debug_mode.isButtonHoverDebug = true;
                        }
                    }

                    NumberAnimation {
                        id: rippleAnimationDebug
                        target: scaleTransformDebug
                        properties: "xScale,yScale"
                        from: 0
                        to: 1
                        easing.type: Easing.OutQuad
                        onStopped: {
                            if (scaleTransformDebug.xScale >= 1 && !mouseAreaDebug.pressed) {
                                rippleRectDebug.visible = false;
                            }
                        }
                    }

                    Row {
                        width: parent.width
                        spacing: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            source: "assets/images/fire_white.png"
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
                                text: qsTr("Режим откладки")
                                color: "white"
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
}


