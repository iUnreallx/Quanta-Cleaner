//parametrs page
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15


Rectangle {
    id: parametrs
    anchors.fill: parent
    color: "#000"

    Component.onCompleted: {
        tempRadio.checked = quanta_settings.parametr_block1_active
        tempRadio2.checked = quanta_settings.parametr_block2_active
        tempRadio3.checked = quanta_settings.parametr_block3_active
        tempRadio4.checked = quanta_settings.parametr_block4_active
        tempRadio5.checked = quanta_settings.parametr_block5_active
        tempRadio6.checked = quanta_settings.parametr_block6_active
        tempRadio7.checked = quanta_settings.parametr_block7_active
        tempRadio8.checked = quanta_settings.parametr_block8_active
        tempRadio9.checked = quanta_settings.parametr_block9_active
    }

    property bool flicking: false
    property bool animationEnabled: quanta_settings.settings_animation

    property int taskComplete: 0
    property double tempSize: 0

    property var tempLogPopup: null
    property bool hover_tmp: false
    property bool is_temp_override: false
    property bool info_block1_hover: false

    property bool hover_sxs: false
    property bool is_xsx_override: false
    property bool info_block2_hover: false

    property bool hover_wintemp: false
    property bool is_wintemp_override: false
    property bool info_block3_hover: false

    property bool hover_fonts: false
    property bool is_fonts_override: false
    property bool info_block4_hover: false

    property bool hover_bin: false
    property bool is_bin_override: false
    property bool info_block5_hover: false

    property bool hover_update: false
    property bool is_update_override: false
    property bool info_block6_hover: false

    property bool hover_event: false
    property bool is_event_override: false
    property bool info_block7_hover: false

    property bool hover_dumps: false
    property bool is_dumps_override: false
    property bool info_block8_hover: false

    property bool hover_point: false
    property bool is_point_override: false
    property bool info_block9_hover: false

    property bool border_block1: false


    Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 215
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width
            height: 70
            color: "#000"
            z: 2

            Text {
                id: parameters_text
                text: qsTr("Параметры")
                color: "white"
                font.pixelSize: 30
                font.bold: true
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
        }

        Flickable {
            id: scrollArea
            z: 5
            anchors.left: parent.left
            anchors.leftMargin: 230
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 70
            anchors.bottom: parent.bottom
            width: parent.width - 225
            height: parent.height - 50
            contentWidth: parent.width
            contentHeight: flowLayout.implicitHeight + 15
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.VerticalFlick
            clip: true

            Flow {
                id: flowLayout
                width: parent.width - 230
                spacing: 10
                flow: Flow.LeftToRight


                //FIRST GLOBAL OBJECT
                Rectangle {
                    id: glowRect1
                    width: parent.width <= 470 ? 453 : 220
                    border.color: "#282928"
                    border.width: 2
                    height: 220
                    color: "black"
                    clip: true
                    z: 2
                    property bool justClosed: false

                    Image {
                        source: "assets/images/par_black2.png"
                        width: 100
                        height: 100
                        y: 20
                        x: 15
                        z: 2
                    }

                    Text {
                        id: box_1
                        color: "white"
                        text: qsTr("Параметры очистки")
                        font.pixelSize: 18
                        font.bold: true
                        font.family: cleanerFont.name
                        y: 130
                        x: 15
                        z: 5
                    }

                    Text {
                        id: box_1_gray
                        color: "gray"
                        text: qsTr("Конфигурация и настройка\nпараметров очистки")
                        font.pixelSize: 13
                        font.bold: false
                        font.family: cleanerFont.name
                        y: 155
                        x: 15
                        z: 5
                    }

                    Canvas {
                        id: gradientCanvas
                        anchors.fill: parent
                        z: 10
                        visible: glowArea1.containsMouse && !glowArea1.pressed && !parametersDialog.visible

                        property real currentMouseX: glowArea1.mouseX
                        property real currentMouseY: glowArea1.mouseY

                        onCurrentMouseXChanged: if (visible) requestPaint()
                        onCurrentMouseYChanged: if (visible) requestPaint()
                        onVisibleChanged: if (visible) requestPaint()

                        onPaint: {
                            if (animationEnabled) {
                                if (!visible) return;

                                const ctx = getContext("2d");
                                ctx.clearRect(0, 0, width, height);

                                const gradient = ctx.createRadialGradient(
                                    currentMouseX, currentMouseY, 0,
                                    currentMouseX, currentMouseY, Math.max(width, height) / 2
                                );
                                gradient.addColorStop(0, "gold");
                                gradient.addColorStop(1, "transparent");

                                ctx.strokeStyle = gradient;
                                ctx.lineWidth = 3;
                                ctx.strokeRect(1, 1, width - 2, height - 2);
                            }
                        }
                    }

                    Canvas {
                        id: glowCircle1
                        width: 100
                        height: 100
                        visible: glowArea1.containsMouse && !glowArea1.pressed && !parametersDialog.visible
                        z: 0
                        x: Math.max(-width / 2, Math.min(glowArea1.mouseX - width / 2, glowArea1.width - width / 2))
                        y: Math.max(-height / 2, Math.min(glowArea1.mouseY - height / 2, glowArea1.height - height / 2))

                        onXChanged: requestPaint()
                        onYChanged: requestPaint()
                        onVisibleChanged: requestPaint()

                        onPaint: {
                            if (animationEnabled) {
                                if (!visible) return;

                                const ctx = getContext("2d");
                                ctx.clearRect(0, 0, width, height);

                                const gradient = ctx.createRadialGradient(
                                    width / 2, height / 2, 0,
                                    width / 2, height / 2, 50
                                );

                                gradient.addColorStop(0.0, "rgba(9, 144, 30, 0.8)");
                                gradient.addColorStop(1.0, "rgba(0, 0, 0, 0.8)");

                                ctx.fillStyle = gradient;
                                ctx.beginPath();
                                ctx.arc(width / 2, height / 2, 50, 0, Math.PI * 2);
                                ctx.closePath();
                                ctx.fill();
                            }
                        }
                    }

                    MouseArea {
                        id: glowArea1
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        z: 4

                        onClicked: {
                            main_window.isOverlayVisible = true;
                            parametersDialog.open();
                        }

                        onEntered: {
                            parametrs.border_block1 = true;
                        }

                        onExited: {
                            parametrs.border_block1 = false;
                        }
                    }
                }


            //SECOND GLOBAL OBJECT
            Rectangle {
                id: glowRect2
                width: parent.width <= 470 ? 453 : 220
                border.color: "#282928"
                border.width: 2
                height: 220
                color: "black"
                clip: true
                z: 2
                property bool justClosed: false

                Image {
                    source: "assets/images/parametrs/notes_white.png"
                    width: 90
                    height: 90
                    y: 20
                    x: 10
                    z: 2
                }

                Text {
                    id: box_2
                    color: "white"
                    text: qsTr("Управление логами")
                    font.pixelSize: 18
                    font.bold: true
                    font.family: cleanerFont.name
                    y: 130
                    x: 15
                    z: 5
                }

                Text {
                    id: box_2_gray
                    color: "gray"
                    text: qsTr("Управление параметрами и\nповедением логов")
                    font.pixelSize: 13
                    font.bold: false
                    font.family: cleanerFont.name
                    y: 155
                    x: 15
                    z: 5
                }

                Canvas {
                    id: gradientCanvas2
                    anchors.fill: parent
                    z: 10
                    visible: glowArea2.containsMouse && !glowArea2.pressed && !parametersDialog.visible

                    property real currentMouseX: glowArea2.mouseX
                    property real currentMouseY: glowArea2.mouseY

                    onCurrentMouseXChanged: if (visible) requestPaint()
                    onCurrentMouseYChanged: if (visible) requestPaint()
                    onVisibleChanged: if (visible) requestPaint()

                    onPaint: {
                        if (animationEnabled) {
                            if (!visible) return;

                            const ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);

                            const gradient = ctx.createRadialGradient(
                                currentMouseX, currentMouseY, 0,
                                currentMouseX, currentMouseY, Math.max(width, height) / 2
                            );
                            gradient.addColorStop(0, "gold");
                            gradient.addColorStop(1, "transparent");

                            ctx.strokeStyle = gradient;
                            ctx.lineWidth = 3;
                            ctx.strokeRect(1, 1, width - 2, height - 2);
                        }
                    }
                }

                Canvas {
                    id: glowCircle2
                    width: 100
                    height: 100
                    visible: glowArea2.containsMouse && !glowArea2.pressed && !parametersDialog.visible
                    z: 0
                    x: Math.max(-width / 2, Math.min(glowArea2.mouseX - width / 2, glowArea2.width - width / 2))
                    y: Math.max(-height / 2, Math.min(glowArea2.mouseY - height / 2, glowArea2.height - height / 2))

                    onXChanged: requestPaint()
                    onYChanged: requestPaint()
                    onVisibleChanged: requestPaint()

                    onPaint: {
                        if (animationEnabled) {
                            if (!visible) return;

                            const ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);

                            const gradient = ctx.createRadialGradient(
                                width / 2, height / 2, 0,
                                width / 2, height / 2, 50
                            );

                            gradient.addColorStop(0.0, "rgba(9, 144, 30, 0.8)");
                            gradient.addColorStop(1.0, "rgba(0, 0, 0, 0.8)");

                            ctx.fillStyle = gradient;
                            ctx.beginPath();
                            ctx.arc(width / 2, height / 2, 50, 0, Math.PI * 2);
                            ctx.closePath();
                            ctx.fill();
                        }
                    }
                }

                MouseArea {
                    id: glowArea2
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    z: 4

                    onClicked: {
                        // main_window.isOverlayVisible = true;
                        // parametersDialog.open();
                    }

                    onEntered: {
                        parametrs.border_block1 = true;
                    }

                    onExited: {
                        parametrs.border_block1 = false;
                    }
                }
            }
        }
    }

        Popup {
            id: parametersDialog
            focus: true
            width: parent.width - 50
            height: parent.height - 50
            z: 23
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            onClosed: {
                main_window.isOverlayVisible = false;
            }


            background: Rectangle {
                color: "transparent"
            }

            Rectangle {
                width: 25
                height: 25
                color: "#382022"
                anchors.right: parent.right
                anchors.rightMargin: 15
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
                        parametersDialog.visible = false
                    }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "#241415"
                radius: 15
                clip: true

                Flickable {
                    id: flickable
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    clip: true
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: temp_block.y + temp_block.height + second.height + 20 + third.height + 15 + four.height + 10 + five.height + 5 + six.height + 10 + seven.height + 10 + eigth.height + 10 + nine.height + 10

                    boundsBehavior: Flickable.StopAtBounds

                    onMovementStarted: parametrs.flicking = true
                    onMovementEnded: parametrs.flicking = false

                    maximumFlickVelocity: 3000
                    flickDeceleration: 2000

                    Rectangle {
                        id: contentColumn
                        anchors.fill: parent
                        color: "transparent"


///////////////////////1 object////////////
                Rectangle {
                    id: temp_block
                    width: parent.width - 30
                    height: parametrs.is_temp_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    radius: 10


                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }


                Text {
                    id: p_page_clean
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 10
                    anchors.leftMargin: 15
                    text: qsTr("Очистка временных
файлов")
                    font.bold: true
                    color: "#66E8A3"
                    font.pixelSize: 33
                    font.family: cleanerFont.name
                    z: 2
                }


                Text {
                    id: parametrs_tmp
                    text: ""
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 25
                    font.pixelSize: 16
                    visible: false
                }

                Rectangle {
                    id: overrideToggle
                    color: "transparent"
                    width: 43
                    height: 43
                    anchors.top: parent.top
                    anchors.topMargin: 28
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    radius: 6

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            parametrs.is_temp_override = !parametrs.is_temp_override
                            console.log(parametrs.is_temp_override)
                        }
                    }

                    property real angle: 0

                    Image {
                        id: chevronImage
                        source: "assets/images/parametrs/chevron.png"
                        width: 32
                        height: 32
                        anchors.centerIn: parent

                        transform: Rotation {
                            id: rotation
                            origin.x: chevronImage.width / 2
                            origin.y: chevronImage.height / 2
                            angle: overrideToggle.angle
                        }
                    }

                    Behavior on angle {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Connections {
                        target: parametrs
                        function onIs_temp_overrideChanged() {
                            overrideToggle.angle = parametrs.is_temp_override ? -90 : 0
                        }
                    }
                }

                //4 buttons for interactive
                Rectangle {
                    id: infoindicator
                    color: "#6E2F2F"
                    border.width: 2
                    border.color: "#66E8A3"
                    width: 43
                    height: 43
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    radius: 6
                    visible:  opacity > 0
                    opacity: parametrs.is_temp_override ? 1 : 0
                    z: 1
                    Behavior on opacity {
                        NumberAnimation { id: opacityAnim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                    }
                    Timer {
                        id: hoverCheckTimer
                        interval: 100
                        repeat: false
                        onTriggered: {
                            if (!infoindicator.containsMouse && !info_popup.containsMouse) {
                                parametrs.info_block1_hover = false
                            }
                        }
                    }

                    HoverHandler {
                        id: hoverHandler
                        onHoveredChanged: {
                            if (hovered) {
                                parametrs.info_block1_hover = true
                            } else {
                                hoverCheckTimer.start()
                            }
                        }
                    }


                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                    }

                    Connections {
                        target: parametrs
                        function onIs_temp_overrideChanged() {
                            opacityAnim1.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 350;
                        }
                    }

                    Image {
                        source: "assets/images/parametrs/sign.png"
                        width: 32
                        height: 32
                        anchors.centerIn: parent
                    }
                }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 18
                        anchors.left: parent.left
                        anchors.leftMargin: 65
                        opacity: parametrs.is_temp_override ? 1 : 0
                        z: 1
                        color: "#66E8A3"
                        text: "Инфо"
                        font.pixelSize: 24
                        font.family: cleanerFontRegular.name
                        font.letterSpacing: -1

                        Behavior on opacity {
                             NumberAnimation { id: opacityAnim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                         }
                         Connections {
                             target: parametrs
                             function onIs_temp_overrideChanged() {
                                 opacityAnim2.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 450;
                             }
                         }
                }

                    Rectangle {
                        id: info_popup
                        parent: contentColumn
                        color: "#6E2F2F"
                        radius: 6
                        border.width: 3
                        border.color: "#66E8A3"
                        visible: parametrs.info_block1_hover
                        z: 100

                        width: Math.min(textItem.implicitWidth + 20, 310)
                        height: textItem.implicitHeight + 20

                        x: infoindicator.mapToItem(flickable, 0, 0).x + infoindicator.width + 35
                        property real baseY: infoindicator.mapToItem(flickable, 0, 0).y

                        y: baseY + 92

                        Text {
                            id: textItem
                            anchors.centerIn: parent
                            width: Math.min(300, implicitWidth)
                            text: qsTr("Эта функция автоматически очищает временную папку (Temp), удаляя ненужные файлы и освобождая место на диске. Это помогает ускорить работу системы и предотвратить накопление мусора.")
                            color: "white"
                            font.pixelSize: 16
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }


                    Rectangle {
                        id: rocketCleanindicator
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 138
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_temp_override ? 1 : 0
                        z: 1

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tmp.clearTempFolder(2, true)

                            }
                        }

                        Behavior on opacity {
                             NumberAnimation { id: opacityAnimROCK; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                         }
                         Connections {
                             target: parametrs
                             function onIs_temp_overrideChanged() {
                                 opacityAnimROCK.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 550;
                             }
                         }


                        Image {
                            source: "assets/images/parametrs/rocket.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 29
                            anchors.left: parent.left
                            anchors.leftMargin: 190
                            opacity: parametrs.is_temp_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Точечная"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_temp_overrideChanged() {
                                     opacityAnim3.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 650;
                                 }
                             }
                    }


                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 9
                            anchors.left: parent.left
                            anchors.leftMargin: 194
                            opacity: parametrs.is_temp_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "очистка"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                NumberAnimation { id: opacityAnim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                            }
                            Connections {
                                target: parametrs
                                function onIs_temp_overrideChanged() {
                                    opacityAnim4.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 750;
                                }
                            }
                    }

                        Rectangle {
                            id: logsViewindicator
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 298
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_temp_override ? 1 : 0
                            z: 1



                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (!parametrs.tempLogPopup) {
                                        console.log("soz")
                                        parametrs.tempLogPopup = logPopupComponent.createObject(parent)
                                    }
                                    parametrs.tempLogPopup.open()
                                }
                            }


                            Behavior on opacity {
                                  NumberAnimation { id: opacityAnim5; duration:  !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                              }
                              Connections {
                                  target: parametrs
                                  function onIs_temp_overrideChanged() {
                                      opacityAnim5.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 :850;
                                  }
                              }


                            Image {
                                source: "assets/images/parametrs/eye.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 350
                                opacity: parametrs.is_temp_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Вывод"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacityAnim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_temp_overrideChanged() {
                                        opacityAnim6.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 950;
                                    }
                                }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 354
                                opacity: parametrs.is_temp_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "логов"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacityAnim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_temp_overrideChanged() {
                                        opacityAnim7.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 1050;
                                    }
                                }
                        }


                            Rectangle {
                                id: binindicator
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 435
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_temp_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.cleanLogPath("tempLog.txt")
                                        logsviewer.loadLogs("tempLog.txt")
                                        addNotification("Лог времменых файлов (Temp)\nуспешно очищен")
                                        // logText.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                    }
                                }

                                Behavior on opacity {
                                    NumberAnimation { id: opacityAnim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_temp_overrideChanged() {
                                        opacityAnim8.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 1150;
                                    }
                                }


                                Image {
                                    source: "assets/images/parametrs/trash.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 487
                                    opacity: parametrs.is_temp_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Очистка"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacityAnim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_temp_overrideChanged() {
                                            opacityAnim9.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 1250;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 498
                                    opacity: parametrs.is_temp_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1
                                    Behavior on opacity {
                                        NumberAnimation { id: opacityAnim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_temp_overrideChanged() {
                                            opacityAnim10.duration = !animationEnabled ? 0 : parametrs.is_temp_override ? 100 : 1350;
                                        }
                                    }

                            }


                RadioButton {
                    id: tempRadio
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 90
                    width: 60
                    height: 60

                    x: 80
                    font.pixelSize: 16
                    font.bold: true
                    scale: 1.1

                    indicator: Rectangle {
                        implicitWidth: 60
                        implicitHeight: 60
                        radius: width / 2
                        border.width: 2
                        border.color: tempRadio.checked ? "#B00102" : "#66E8A3"
                        color: "transparent"

                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width - 17
                            height: parent.height - 17
                            radius: width / 2
                            color: tempRadio.checked ? "#B00102" : "#66E8A3"
                        }
                        Behavior on color {
                            ColorAnimation {
                                duration: !animationEnabled ? 0 : 200
                            }
                        }

                        Behavior on border.color {
                            ColorAnimation {
                                duration: !animationEnabled ? 0 : 180
                            }
                        }
                    }


                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            tempRadio.checked = !tempRadio.checked
                            quanta_settings.parametr_block1_active = !quanta_settings.parametr_block1_active
                            console.log("Состояние:", tempRadio.checked)
                        }
                    }
                }
           }
///////////////////////2 object////////////
                Rectangle {
                    id: second
                    width: parent.width - 30
                    height: parametrs.is_xsx_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: temp_block.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 :  300
                        }
                    }

                    Text {
                        id: p2_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка файлов
WinSxS")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_xsx
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle2
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_xsx_override = !parametrs.is_xsx_override
                                console.log(parametrs.is_xsx_override)
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage2
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation2
                                origin.x: chevronImage2.width / 2
                                origin.y: chevronImage2.height / 2
                                angle: overrideToggle2.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_xsx_overrideChanged() {
                                overrideToggle2.angle = parametrs.is_xsx_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator2
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_xsx_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity2Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer2
                            interval: 100
                            repeat: false
                            onTriggered: {
                                if (!infoindicator2.containsMouse && !info_popup2.containsMouse) {
                                    parametrs.info_block2_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler2
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block2_hover = true
                                } else {
                                    hoverCheckTimer2.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_xsx_overrideChanged() {
                                opacity2Anim1.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_xsx_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity2Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_xsx_overrideChanged() {
                                     opacity2Anim2.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator2.mapToItem(flickable, 0, 0).y

                            id: info_popup2
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block2_hover
                            z: 100
                            width: Math.min(textItem2.implicitWidth + 20, 310)
                            height: textItem2.implicitHeight + 20
                            x: infoindicator2.mapToItem(flickable, 0, 0).x + infoindicator2.width + 35
                            y: baseY + 301 + (parametrs.is_temp_override ? -54 : -100)


                            Text {
                                id: textItem2
                                anchors.centerIn: parent
                                width: Math.min(300, implicitWidth)
                                text: qsTr("Эта функция очищает папку WinSxS, удаляя устаревшие резервные копии компонентов Windows и неиспользуемые обновления.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator2
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_xsx_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    winsxs.cleanWinSXS(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK2; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_xsx_overrideChanged() {
                                     opacityAnimROCK2.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_xsx_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity2Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_xsx_overrideChanged() {
                                         opacity2Anim3.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_xsx_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity2Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_xsx_overrideChanged() {
                                        opacity2Anim4.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator2
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_xsx_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("WinSxSCleaner.txt")
                                        logText2.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        xsxLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity2Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_xsx_overrideChanged() {
                                          opacity2Anim5.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_xsx_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity2Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_xsx_overrideChanged() {
                                            opacity2Anim6.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_xsx_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity2Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_xsx_overrideChanged() {
                                            opacity2Anim7.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator2
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_xsx_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("WinSxSCleaner.txt")
                                            logsviewer.loadLogs("WinSxSCleaner.txt")
                                            addNotification("Лог WinSxS\nуспешно очищен")
                                            logText2.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity2Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_xsx_overrideChanged() {
                                            opacity2Anim8.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_xsx_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity2Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_xsx_overrideChanged() {
                                                opacity2Anim9.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_xsx_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity2Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_xsx_overrideChanged() {
                                                opacity2Anim10.duration = !animationEnabled ? 0 : parametrs.is_xsx_override ? 100 : 1350;
                                            }
                                        }

                                }


                    RadioButton {
                        id: tempRadio2
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 90
                        width: 60
                        height: 60

                        x: 80
                        font.pixelSize: 16
                        font.bold: true
                        scale: 1.1

                        indicator: Rectangle {
                            implicitWidth: 60
                            implicitHeight: 60
                            radius: width / 2
                            border.width: 2
                            border.color: tempRadio2.checked ? "#B00102" : "#66E8A3"
                            color: "transparent"

                            Rectangle {
                                anchors.centerIn: parent
                                width: parent.width - 17
                                height: parent.height - 17
                                radius: width / 2
                                color: tempRadio2.checked ? "#B00102" : "#66E8A3"
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 200
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 180
                                }
                            }
                        }


                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tempRadio2.checked = !tempRadio2.checked
                                quanta_settings.parametr_block2_active = !quanta_settings.parametr_block2_active
                                console.log("Состояние:", tempRadio2.checked)
                            }
                        }
                    }
                }
///////////////////////3 object////////////
                Rectangle {
                    id:  third
                    width: parent.width - 30
                    height: parametrs.is_wintemp_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: second.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }

                    Text {
                        id: p3_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка временных
файлов WinTemp")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_wintemp
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle3
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_wintemp_override = !parametrs.is_wintemp_override
                                console.log(parametrs.is_xsx_override)
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage3
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation3
                                origin.x: chevronImage3.width / 2
                                origin.y: chevronImage3.height / 2
                                angle: overrideToggle3.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_wintemp_overrideChanged() {
                                overrideToggle3.angle = parametrs.is_wintemp_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator3
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_wintemp_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity3Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer3
                            interval: 100
                            repeat: false
                            onTriggered: {
                                if (!infoindicator3.containsMouse && !info_popup3.containsMouse) {
                                    parametrs.info_block3_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler3
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block3_hover = true
                                } else {
                                    hoverCheckTimer3.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_wintemp_overrideChanged() {
                                opacity3Anim1.duration =!animationEnabled ? 0 :  parametrs.is_wintemp_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_wintemp_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity3Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_wintemp_overrideChanged() {
                                     opacity3Anim2.duration =!animationEnabled ? 0 :  parametrs.is_wintemp_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator3.mapToItem(flickable, 0, 0).y

                            id: info_popup3
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block3_hover
                            z: 100
                            width: Math.min(textItem3.implicitWidth + 20, 310)
                            height: textItem3.implicitHeight + 20
                            x: infoindicator3.mapToItem(flickable, 0, 0).x + infoindicator3.width + 35
                            y: baseY + 412 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_xsx_override ? 44 : 0)


                            Text {
                                id: textItem3
                                anchors.centerIn: parent
                                width: Math.min(300, implicitWidth)
                                text: qsTr("Эта функция удаляет временные файлы Windows из системной папки winTemp, включая кэш установок, остатки программ и другие временные данные.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator3
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_wintemp_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    wintemp.cleanWinTemp(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK3; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_wintemp_overrideChanged() {
                                     opacityAnimROCK3.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_wintemp_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity3Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_wintemp_overrideChanged() {
                                         opacity3Anim3.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_wintemp_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity3Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_wintemp_overrideChanged() {
                                        opacity3Anim4.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator3
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                               visible:  opacity > 0
                                opacity: parametrs.is_wintemp_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("winTempClean.txt")
                                        logText3.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        wintempLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity3Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_wintemp_overrideChanged() {
                                          opacity3Anim5.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_wintemp_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity3Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_wintemp_overrideChanged() {
                                            opacity3Anim6.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_wintemp_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity3Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_wintemp_overrideChanged() {
                                            opacity3Anim7.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator3
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_wintemp_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("winTempClean.txt")
                                            logsviewer.loadLogs("winTempClean.txt")
                                            addNotification("Лог временных файлов winTemp\nуспешно очищен")
                                            logText3.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity3Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_wintemp_overrideChanged() {
                                            opacity3Anim8.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_wintemp_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity3Anim9; duration:!animationEnabled ? 0 :  1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_wintemp_overrideChanged() {
                                                opacity3Anim9.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_wintemp_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity3Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_wintemp_overrideChanged() {
                                                opacity3Anim10.duration = !animationEnabled ? 0 : parametrs.is_wintemp_override ? 100 : 1350;
                                            }
                                        }

                                }


                    RadioButton {
                        id: tempRadio3
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 90
                        width: 60
                        height: 60

                        x: 80
                        font.pixelSize: 16
                        font.bold: true
                        scale: 1.1

                        indicator: Rectangle {
                            implicitWidth: 60
                            implicitHeight: 60
                            radius: width / 2
                            border.width: 2
                            border.color: tempRadio3.checked ? "#B00102" : "#66E8A3"
                            color: "transparent"

                            Rectangle {
                                anchors.centerIn: parent
                                width: parent.width - 17
                                height: parent.height - 17
                                radius: width / 2
                                color: tempRadio3.checked ? "#B00102" : "#66E8A3"
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 200
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 180
                                }
                            }
                        }


                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tempRadio3.checked = !tempRadio3.checked
                                quanta_settings.parametr_block3_active = !quanta_settings.parametr_block3_active
                                console.log("Состояние:", tempRadio3.checked)
                            }
                        }
                }
                }
///////////////////////4 object////////////
                Rectangle {
                    id:  four
                    width: parent.width - 30
                    height: parametrs.is_fonts_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top:  third.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }
                    Text {
                        id: p4_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка кеша
шрифтов")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_font
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle4
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_fonts_override = !parametrs.is_fonts_override
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage4
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation4
                                origin.x: chevronImage4.width / 2
                                origin.y: chevronImage4.height / 2
                                angle: overrideToggle4.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_fonts_overrideChanged() {
                                overrideToggle4.angle = parametrs.is_fonts_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator4
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_fonts_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity4Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer4
                            interval: 100
                            repeat: false
                            onTriggered: {
                                if (!infoindicator4.containsMouse && !info_popup4.containsMouse) {
                                    parametrs.info_block4_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler4
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block4_hover = true
                                } else {
                                    hoverCheckTimer4.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_fonts_overrideChanged() {
                                opacity4Anim1.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_fonts_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity4Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_fonts_overrideChanged() {
                                     opacity4Anim2.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator4.mapToItem(flickable, 0, 0).y

                            id: info_popup4
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block4_hover
                            z: 100
                            width: 350
                            height: textItem4.implicitHeight + 20
                            x: infoindicator4.mapToItem(flickable, 0, 0).x + infoindicator4.width + 35
                            y: baseY + 522 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_wintemp_override ? 44 : 0) + (parametrs.is_xsx_override ? 44 : 0)


                            Text {
                                id: textItem4
                                anchors.centerIn: parent
                                width: 350
                                text: qsTr("Эта функция удаляет кэш шрифтов Windows — временные файлы, создаваемые системой для ускорения отображения шрифтов.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator4
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_fonts_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    fontQ.fontCacheClean(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK4; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_fonts_overrideChanged() {
                                     opacityAnimROCK4.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_fonts_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity4Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_fonts_overrideChanged() {
                                         opacity4Anim3.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_fonts_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity4Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_fonts_overrideChanged() {
                                        opacity4Anim4.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator4
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_fonts_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("fontCache.txt")
                                        logText4.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        fontsLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity4Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_fonts_overrideChanged() {
                                          opacity4Anim5.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_fonts_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity4Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_fonts_overrideChanged() {
                                            opacity4Anim6.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_fonts_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity4Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_fonts_overrideChanged() {
                                            opacity4Anim7.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator4
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_fonts_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("fontCache.txt")
                                            logsviewer.loadLogs("fontCache.txt")
                                            addNotification("Лог кеша шрифтов\nуспешно очищен")
                                            logText4.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity4Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_fonts_overrideChanged() {
                                            opacity4Anim8.duration =!animationEnabled ? 0 :  parametrs.is_fonts_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_fonts_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity4Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_fonts_overrideChanged() {
                                                opacity4Anim9.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_fonts_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity4Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_fonts_overrideChanged() {
                                                opacity4Anim10.duration = !animationEnabled ? 0 : parametrs.is_fonts_override ? 100 : 1350;
                                            }
                                        }

                                }


                    RadioButton {
                        id: tempRadio4
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 90
                        width: 60
                        height: 60

                        x: 80
                        font.pixelSize: 16
                        font.bold: true
                        scale: 1.1

                        indicator: Rectangle {
                            implicitWidth: 60
                            implicitHeight: 60
                            radius: width / 2
                            border.width: 2
                            border.color: tempRadio4.checked ? "#B00102" : "#66E8A3"
                            color: "transparent"

                            Rectangle {
                                anchors.centerIn: parent
                                width: parent.width - 17
                                height: parent.height - 17
                                radius: width / 2
                                color: tempRadio4.checked ? "#B00102" : "#66E8A3"
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 200
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 180
                                }
                            }
                        }


                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tempRadio4.checked = !tempRadio4.checked
                                quanta_settings.parametr_block4_active = !quanta_settings.parametr_block4_active
                                console.log("Состояние:", tempRadio4.checked)
                            }
                        }
                }
                }
///////////////////////5 object////////////
                Rectangle {
                    id:  five
                    width: parent.width - 30
                    height: parametrs.is_bin_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: four.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }
                    Text {
                        id: p5_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 30
                        anchors.leftMargin: 15
                        text: qsTr("Очистка корзины")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_bin
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle5
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_bin_override = !parametrs.is_bin_override
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage5
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation5
                                origin.x: chevronImage5.width / 2
                                origin.y: chevronImage5.height / 2
                                angle: overrideToggle5.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_bin_overrideChanged() {
                                overrideToggle5.angle = parametrs.is_bin_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator5
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_bin_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity5Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer5
                            interval: 40
                            repeat: false
                            onTriggered: {
                                if (!infoindicator5.containsMouse && !info_popup5.containsMouse) {
                                    parametrs.info_block5_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler5
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block5_hover = true
                                } else {
                                    hoverCheckTimer5.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_bin_overrideChanged() {
                                opacity5Anim1.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_bin_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity5Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_bin_overrideChanged() {
                                     opacity5Anim2.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator5.mapToItem(flickable, 0, 0).y

                            id: info_popup5
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block5_hover
                            z: 100
                            width: 350
                            height: textItem5.implicitHeight + 20
                            x: infoindicator5.mapToItem(flickable, 0, 0).x + infoindicator5.width + 35
                            y: baseY + 632 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_wintemp_override ? 44 : 0) + (parametrs.is_xsx_override ? 44 : 0) + (parametrs.is_fonts_override ? 44 : 0)


                            Text {
                                id: textItem5
                                anchors.centerIn: parent
                                width: 350
                                text: qsTr("Функция очищает файлы, хранящиеся в корзине. Файлы будут удалены безвозвратно.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator5
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_bin_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    binclear.cleanRecycleBin(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK5; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_bin_overrideChanged() {
                                     opacityAnimROCK5.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_bin_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity5Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_bin_overrideChanged() {
                                         opacity5Anim3.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_bin_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity5Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_bin_overrideChanged() {
                                        opacity5Anim4.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator5
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_bin_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("recycleLog.txt")
                                        logText5.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        binLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity5Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_bin_overrideChanged() {
                                          opacity5Anim5.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_bin_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity5Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_bin_overrideChanged() {
                                            opacity5Anim6.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_bin_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity5Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_bin_overrideChanged() {
                                            opacity5Anim7.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator5
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_bin_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("recycleLog.txt")
                                            logsviewer.loadLogs("recycleLog.txt")
                                            addNotification("Лог корзины\nуспешно очищен")
                                            logText5.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity5Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_bin_overrideChanged() {
                                            opacity5Anim8.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_bin_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity5Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_bin_overrideChanged() {
                                                opacity5Anim9.duration =!animationEnabled ? 0 :  parametrs.is_bin_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_bin_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity5Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_bin_overrideChanged() {
                                                opacity5Anim10.duration = !animationEnabled ? 0 : parametrs.is_bin_override ? 100 : 1350;
                                            }
                                        }

                                }


                    RadioButton {
                        id: tempRadio5
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 90
                        width: 60
                        height: 60

                        x: 80
                        font.pixelSize: 16
                        font.bold: true
                        scale: 1.1

                        indicator: Rectangle {
                            implicitWidth: 60
                            implicitHeight: 60
                            radius: width / 2
                            border.width: 2
                            border.color: tempRadio5.checked ? "#B00102" : "#66E8A3"
                            color: "transparent"

                            Rectangle {
                                anchors.centerIn: parent
                                width: parent.width - 17
                                height: parent.height - 17
                                radius: width / 2
                                color: tempRadio5.checked ? "#B00102" : "#66E8A3"
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 200
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 180
                                }
                            }
                        }


                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tempRadio5.checked = !tempRadio5.checked
                                quanta_settings.parametr_block5_active = !quanta_settings.parametr_block5_active
                                // console.log("Состояние:", tempRadio4.checked)
                            }
                        }
                }
                }
///////////////////////6 object////////////
                Rectangle {
                    id:  six
                    width: parent.width - 30
                    height: parametrs.is_update_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: five.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }
                    Text {
                        id: p6_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка кеша
обновления Windows")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_update
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle6
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_update_override = !parametrs.is_update_override
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage6
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation6
                                origin.x: chevronImage6.width / 2
                                origin.y: chevronImage6.height / 2
                                angle: overrideToggle6.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_update_overrideChanged() {
                                overrideToggle6.angle = parametrs.is_update_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator6
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_update_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity6Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer6
                            interval: 40
                            repeat: false
                            onTriggered: {
                                if (!infoindicator6.containsMouse && !info_popup6.containsMouse) {
                                    parametrs.info_block6_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler6
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block6_hover = true
                                } else {
                                    hoverCheckTimer6.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_update_overrideChanged() {
                                opacity6Anim1.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_update_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity6Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_update_overrideChanged() {
                                     opacity6Anim2.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator6.mapToItem(flickable, 0, 0).y

                            id: info_popup6
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block6_hover
                            z: 100
                            width: 350
                            height: textItem6.implicitHeight + 20
                            x: infoindicator6.mapToItem(flickable, 0, 0).x + infoindicator6.width + 35
                            y: baseY + 742 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_wintemp_override ? 44 : 0) + (parametrs.is_xsx_override ? 44 : 0) + (parametrs.is_fonts_override ? 44 : 0)  + (parametrs.is_bin_override ? 44 : 0)


                            Text {
                                id: textItem6
                                anchors.centerIn: parent
                                width: 350
                                text: qsTr("Функция очищает кэш обновлений Windows. Удаляет загруженные файлы обновлений из системы.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator6
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_update_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    updateQ.updateClean(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK6; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_update_overrideChanged() {
                                     opacityAnimROCK6.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_update_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity6Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_update_overrideChanged() {
                                         opacity6Anim3.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_update_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity6Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_update_overrideChanged() {
                                        opacity6Anim4.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator6
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_update_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("updateWinLog.txt")
                                        logText6.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        updateLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity6Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_update_overrideChanged() {
                                          opacity6Anim5.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_update_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity6Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_update_overrideChanged() {
                                            opacity6Anim6.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_update_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity6Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_update_overrideChanged() {
                                            opacity6Anim7.duration =!animationEnabled ? 0 :  parametrs.is_update_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator6
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_update_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("updateWinLog.txt")
                                            logsviewer.loadLogs("updateWinLog.txt")
                                            addNotification("Лог кеша обновлений\nуспешно очищен")
                                            logText6.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity6Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_update_overrideChanged() {
                                            opacity6Anim8.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_update_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity6Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_update_overrideChanged() {
                                                opacity6Anim9.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_update_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity6Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_update_overrideChanged() {
                                                opacity6Anim10.duration = !animationEnabled ? 0 : parametrs.is_update_override ? 100 : 1350;
                                            }
                                        }

                                }


                    RadioButton {
                        id: tempRadio6
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 90
                        width: 60
                        height: 60

                        x: 80
                        font.pixelSize: 16
                        font.bold: true
                        scale: 1.1

                        indicator: Rectangle {
                            implicitWidth: 60
                            implicitHeight: 60
                            radius: width / 2
                            border.width: 2
                            border.color: tempRadio6.checked ? "#B00102" : "#66E8A3"
                            color: "transparent"

                            Rectangle {
                                anchors.centerIn: parent
                                width: parent.width - 17
                                height: parent.height - 17
                                radius: width / 2
                                color: tempRadio6.checked ? "#B00102" : "#66E8A3"
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 200
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: !animationEnabled ? 0 : 180
                                }
                            }
                        }


                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tempRadio6.checked = !tempRadio6.checked
                                quanta_settings.parametr_block6_active = !quanta_settings.parametr_block6_active
                                // console.log("Состояние:", tempRadio4.checked)
                            }
                        }
                }
                }
///////////////////////7 object////////////
                Rectangle {
                    id:  seven
                    width: parent.width - 30
                    height: parametrs.is_event_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: six.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }
                    Text {
                        id: p7_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка журнала
событий Windows")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_event
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle7
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_event_override = !parametrs.is_event_override
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage7
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation7
                                origin.x: chevronImage7.width / 2
                                origin.y: chevronImage7.height / 2
                                angle: overrideToggle7.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_event_overrideChanged() {
                                overrideToggle7.angle = parametrs.is_event_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator7
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_event_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity7Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer7
                            interval: 40
                            repeat: false
                            onTriggered: {
                                if (!infoindicator7.containsMouse && !info_popup7.containsMouse) {
                                    parametrs.info_block7_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler7
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block7_hover = true
                                } else {
                                    hoverCheckTimer7.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_event_overrideChanged() {
                                opacity7Anim1.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_event_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity7Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_event_overrideChanged() {
                                     opacity7Anim2.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator7.mapToItem(flickable, 0, 0).y

                            id: info_popup7
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block7_hover
                            z: 100
                            width: 350
                            height: textItem7.implicitHeight + 20
                            x: infoindicator7.mapToItem(flickable, 0, 0).x + infoindicator7.width + 35
                            y: baseY + 852 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_wintemp_override ? 44 : 0) + (parametrs.is_xsx_override ? 44 : 0) + (parametrs.is_fonts_override ? 44 : 0)  + (parametrs.is_bin_override ? 44 : 0) + (parametrs.is_update_override ? 44 : 0)


                            Text {
                                id: textItem7
                                anchors.centerIn: parent
                                width: 350
                                text: qsTr("Функция очищает журнал событий Windows. Удаляет накопленные системные логи и записи о событиях.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator7
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_event_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    eventQ.cleanEventLogs(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK7; duration:!animationEnabled ? 0 :  550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_event_overrideChanged() {
                                     opacityAnimROCK7.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_event_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity7Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_event_overrideChanged() {
                                         opacity7Anim3.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_event_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity7Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_event_overrideChanged() {
                                        opacity7Anim4.duration =!animationEnabled ? 0 :  parametrs.is_event_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator7
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_event_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("eventLog.txt")
                                        logText7.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        eventLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity7Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_event_overrideChanged() {
                                          opacity7Anim5.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_event_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity7Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_event_overrideChanged() {
                                            opacity7Anim6.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_event_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity7Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_event_overrideChanged() {
                                            opacity7Anim7.duration =!animationEnabled ? 0 :  parametrs.is_event_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator7
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_event_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("eventLog.txt")
                                            logsviewer.loadLogs("eventLog.txt")
                                            addNotification("Лог журнала событий\nуспешно очищен")
                                            logText7.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity7Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_event_overrideChanged() {
                                            opacity7Anim8.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_event_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity7Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_event_overrideChanged() {
                                                opacity7Anim9.duration = !animationEnabled ? 0 : parametrs.is_event_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_event_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity7Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_event_overrideChanged() {
                                                opacity7Anim10.duration =!animationEnabled ? 0 :  parametrs.is_event_override ? 100 : 1350;
                                            }
                                        }

                                }


                        RadioButton {
                            id: tempRadio7
                            width: 60
                            height: 60
                            x: 80
                            scale: 1.1
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            anchors.right: parent.right
                            anchors.rightMargin: 90
                            font.pixelSize: 16
                            font.bold: true

                            indicator: Rectangle {
                                implicitWidth: 60
                                implicitHeight: 60
                                radius: width / 2
                                color: "transparent"
                                border.width: 2
                                border.color: tempRadio7.checked ? "#B00102" : "#66E8A3"

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.width - 17
                                    height: parent.height - 17
                                    radius: width / 2
                                    color: tempRadio7.checked ? "#B00102" : "#66E8A3"
                                }

                                Behavior on color {
                                    ColorAnimation { duration: !animationEnabled ? 0 : 200 }
                                }

                                Behavior on border.color {
                                    ColorAnimation { duration: !animationEnabled ? 0 : 180 }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    tempRadio7.checked = !tempRadio7.checked
                                    quanta_settings.parametr_block7_active = !quanta_settings.parametr_block7_active
                                }
                            }
                    }
                }
///////////////////////8 object////////////
                Rectangle {
                    id:  eigth
                    width: parent.width - 30
                    height: parametrs.is_dumps_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: seven.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }
                    Text {
                        id: p8_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка дампа
ошибок системы")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_dumps
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle8
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_dumps_override = !parametrs.is_dumps_override
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage8
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation8
                                origin.x: chevronImage8.width / 2
                                origin.y: chevronImage8.height / 2
                                angle: overrideToggle8.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_dumps_overrideChanged() {
                                overrideToggle8.angle = parametrs.is_dumps_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator8
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_dumps_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity8Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer8
                            interval: 40
                            repeat: false
                            onTriggered: {
                                if (!infoindicator8.containsMouse && !info_popup8.containsMouse) {
                                    parametrs.info_block8_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler8
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block8_hover = true
                                } else {
                                    hoverCheckTimer8.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_dumps_overrideChanged() {
                                opacity8Anim1.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_dumps_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity8Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_dumps_overrideChanged() {
                                     opacity8Anim2.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator8.mapToItem(flickable, 0, 0).y

                            id: info_popup8
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block8_hover
                            z: 100
                            width: 350
                            height: textItem8.implicitHeight + 20
                            x: infoindicator8.mapToItem(flickable, 0, 0).x + infoindicator8.width + 35
                            y: baseY + 962 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_wintemp_override ? 44 : 0) + (parametrs.is_xsx_override ? 44 : 0) + (parametrs.is_fonts_override ? 44 : 0)  + (parametrs.is_bin_override ? 44 : 0) + (parametrs.is_update_override ? 44 : 0) + (parametrs.is_event_override ? 44 : 0)


                            Text {
                                id: textItem8
                                anchors.centerIn: parent
                                width: 350
                                text: qsTr("Функция удаляет сохранённые дампы сбоев приложений, освобождая место на диске.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator8
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_dumps_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    dmp.cleanCrashDumps(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK8; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_dumps_overrideChanged() {
                                     opacityAnimROCK8.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_dumps_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity8Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_dumps_overrideChanged() {
                                         opacity8Anim3.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_dumps_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity8Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_dumps_overrideChanged() {
                                        opacity8Anim4.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator8
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_dumps_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("crashDump.txt")
                                        logText8.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        dumpsLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity8Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_dumps_overrideChanged() {
                                          opacity8Anim5.duration =!animationEnabled ? 0 :  parametrs.is_dumps_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_dumps_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity8Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_dumps_overrideChanged() {
                                            opacity8Anim6.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_dumps_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity8Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_dumps_overrideChanged() {
                                            opacity8Anim7.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator8
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_dumps_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("crashDump.txt")
                                            logsviewer.loadLogs("crashDump.txt")
                                            addNotification("Лог дампа ошибок\nуспешно очищен")
                                            logText8.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity8Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_dumps_overrideChanged() {
                                            opacity8Anim8.duration =!animationEnabled ? 0 :  parametrs.is_dumps_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_dumps_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity8Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_dumps_overrideChanged() {
                                                opacity8Anim9.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_dumps_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity8Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_dumps_overrideChanged() {
                                                opacity8Anim10.duration = !animationEnabled ? 0 : parametrs.is_dumps_override ? 100 : 1350;
                                            }
                                        }

                                }


                        RadioButton {
                            id: tempRadio8
                            width: 60
                            height: 60
                            x: 80
                            scale: 1.1
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            anchors.right: parent.right
                            anchors.rightMargin: 90
                            font.pixelSize: 16
                            font.bold: true

                            indicator: Rectangle {
                                implicitWidth: 60
                                implicitHeight: 60
                                radius: width / 2
                                color: "transparent"
                                border.width: 2
                                border.color: tempRadio8.checked ? "#B00102" : "#66E8A3"

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.width - 17
                                    height: parent.height - 17
                                    radius: width / 2
                                    color: tempRadio8.checked ? "#B00102" : "#66E8A3"
                                }

                                Behavior on color {
                                    ColorAnimation { duration: !animationEnabled ? 0 : 200 }
                                }

                                Behavior on border.color {
                                    ColorAnimation { duration: !animationEnabled ? 0 : 180 }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    tempRadio8.checked = !tempRadio8.checked
                                    quanta_settings.parametr_block8_active = !quanta_settings.parametr_block8_active
                                }
                            }
                    }
                }
///////////////////////9 object////////////
                Rectangle {
                    id:  nine
                    width: parent.width - 30
                    height: parametrs.is_point_override ? 145 : 100
                    color: "#382022"
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.top: eigth.bottom
                    anchors.topMargin: 10
                    radius: 10

                    Behavior on height {
                        NumberAnimation {
                            duration: !animationEnabled ? 0 : 300
                        }
                    }
                    Text {
                        id: p9_page_clean
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 15
                        text: qsTr("Очистка точек
восстановления")
                        font.bold: true
                        color: "#66E8A3"
                        font.pixelSize: 33
                        font.family: cleanerFont.name
                        z: 2
                    }

                    Text {
                        id: parametrs_point
                        text: ""
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 25
                        font.pixelSize: 16
                        visible: false
                    }

                    Rectangle {
                        id: overrideToggle9
                        color: "transparent"
                        width: 43
                        height: 43
                        anchors.top: parent.top
                        anchors.topMargin: 28
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        radius: 6

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                parametrs.is_point_override = !parametrs.is_point_override
                            }
                        }

                        property real angle: 0

                        Image {
                            id: chevronImage9
                            source: "assets/images/parametrs/chevron.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent

                            transform: Rotation {
                                id: rotation9
                                origin.x: chevronImage9.width / 2
                                origin.y: chevronImage9.height / 2
                                angle: overrideToggle9.angle
                            }
                        }

                        Behavior on angle {
                            NumberAnimation {
                                duration: !animationEnabled ? 0 : 300
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Connections {
                            target: parametrs
                            function onIs_point_overrideChanged() {
                                overrideToggle8.angle = parametrs.is_point_override ? -90 : 0
                            }
                        }
                    }

                    //4 buttons for interactive
                    Rectangle {
                        id: infoindicator9
                        color: "#6E2F2F"
                        border.width: 2
                        border.color: "#66E8A3"
                        width: 43
                        height: 43
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        radius: 6
                        visible:  opacity > 0
                        opacity: parametrs.is_point_override ? 1 : 0
                        z: 1
                        Behavior on opacity {
                            NumberAnimation { id: opacity9Anim1; duration: !animationEnabled ? 0 : 350; easing.type: Easing.InOutQuad }
                        }
                        Timer {
                            id: hoverCheckTimer9
                            interval: 40
                            repeat: false
                            onTriggered: {
                                if (!infoindicator9.containsMouse && !info_popup9.containsMouse) {
                                    parametrs.info_block9_hover = false
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler9
                            enabled: !parametrs.flicking
                            onHoveredChanged: {
                                if (hovered) {
                                    parametrs.info_block9_hover = true
                                } else {
                                    hoverCheckTimer9.start()
                                }
                            }
                        }



                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                        }

                        Connections {
                            target: parametrs
                            function onIs_point_overrideChanged() {
                                opacity9Anim1.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 350;
                            }
                        }

                        Image {
                            source: "assets/images/parametrs/sign.png"
                            width: 32
                            height: 32
                            anchors.centerIn: parent
                        }
                    }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 18
                            anchors.left: parent.left
                            anchors.leftMargin: 65
                            opacity: parametrs.is_point_override ? 1 : 0
                            z: 1
                            color: "#66E8A3"
                            text: "Инфо"
                            font.pixelSize: 24
                            font.family: cleanerFontRegular.name
                            font.letterSpacing: -1

                            Behavior on opacity {
                                 NumberAnimation { id: opacity9Anim2; duration: !animationEnabled ? 0 : 450; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_point_overrideChanged() {
                                     opacity9Anim2.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 450;
                                 }
                             }
                    }
                        Rectangle {
                            property real baseY: infoindicator9.mapToItem(flickable, 0, 0).y

                            id: info_popup9
                            parent: contentColumn
                            color: "#6E2F2F"
                            radius: 6
                            border.width: 3
                            border.color: "#66E8A3"
                            visible: parametrs.info_block9_hover
                            z: 100
                            width: 350
                            height: textItem9.implicitHeight + 20
                            x: infoindicator9.mapToItem(flickable, 0, 0).x + infoindicator9.width + 35
                            y: baseY + 1042 + (parametrs.is_temp_override ? -54 : -100) + (parametrs.is_wintemp_override ? 44 : 0) + (parametrs.is_xsx_override ? 44 : 0) + (parametrs.is_fonts_override ? 44 : 0)  + (parametrs.is_bin_override ? 44 : 0) + (parametrs.is_update_override ? 44 : 0) + (parametrs.is_event_override ? 44 : 0) + (parametrs.is_dumps_override ? 44 : 0)


                            Text {
                                id: textItem9
                                anchors.centerIn: parent
                                width: 350
                                text: qsTr("Функция удаляет старые точки восстановления системы, освобождая дополнительное пространство на диске.")
                                color: "white"
                                font.pixelSize: 16
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle {
                            id: rocketCleanindicator9
                            color: "#6E2F2F"
                            border.width: 2
                            border.color: "#66E8A3"
                            width: 43
                            height: 43
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 138
                            radius: 6
                            visible:  opacity > 0
                            opacity: parametrs.is_point_override ? 1 : 0
                            z: 1

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    pointQ.cleanRestorePoints(2, true)
                                }
                            }

                            Behavior on opacity {
                                 NumberAnimation { id: opacityAnimROCK9; duration: !animationEnabled ? 0 : 550; easing.type: Easing.InOutQuad }
                             }
                             Connections {
                                 target: parametrs
                                 function onIs_point_overrideChanged() {
                                     opacityAnimROCK9.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 550;
                                 }
                             }


                            Image {
                                source: "assets/images/parametrs/rocket.png"
                                width: 32
                                height: 32
                                anchors.centerIn: parent
                            }
                        }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 29
                                anchors.left: parent.left
                                anchors.leftMargin: 190
                                opacity: parametrs.is_point_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "Точечная"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                     NumberAnimation { id: opacity9Anim3; duration: !animationEnabled ? 0 : 650; easing.type: Easing.InOutQuad }
                                 }
                                 Connections {
                                     target: parametrs
                                     function onIs_point_overrideChanged() {
                                         opacity9Anim3.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 650;
                                     }
                                 }
                        }


                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 9
                                anchors.left: parent.left
                                anchors.leftMargin: 194
                                opacity: parametrs.is_point_override ? 1 : 0
                                z: 1
                                color: "#66E8A3"
                                text: "очистка"
                                font.pixelSize: 24
                                font.family: cleanerFontRegular.name
                                font.letterSpacing: -1

                                Behavior on opacity {
                                    NumberAnimation { id: opacity9Anim4; duration: !animationEnabled ? 0 : 750; easing.type: Easing.InOutQuad }
                                }
                                Connections {
                                    target: parametrs
                                    function onIs_point_overrideChanged() {
                                        opacity9Anim4.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 750;
                                    }
                                }
                        }

                            Rectangle {
                                id: logsViewindicator9
                                color: "#6E2F2F"
                                border.width: 2
                                border.color: "#66E8A3"
                                width: 43
                                height: 43
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 298
                                radius: 6
                                visible:  opacity > 0
                                opacity: parametrs.is_point_override ? 1 : 0
                                z: 1

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        logsviewer.loadLogs("PointCleaner.txt")
                                        logText9.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        pointLogView.open()
                                    }
                                }

                                Behavior on opacity {
                                      NumberAnimation { id: opacity9Anim5; duration: !animationEnabled ? 0 : 850; easing.type: Easing.InOutQuad }
                                  }
                                  Connections {
                                      target: parametrs
                                      function onIs_point_overrideChanged() {
                                          opacity9Anim5.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 :850;
                                      }
                                  }


                                Image {
                                    source: "assets/images/parametrs/eye.png"
                                    width: 32
                                    height: 32
                                    anchors.centerIn: parent
                                }
                            }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 29
                                    anchors.left: parent.left
                                    anchors.leftMargin: 350
                                    opacity: parametrs.is_point_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "Вывод"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity9Anim6; duration: !animationEnabled ? 0 : 950; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_point_overrideChanged() {
                                            opacity9Anim6.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 950;
                                        }
                                    }
                            }


                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 9
                                    anchors.left: parent.left
                                    anchors.leftMargin: 354
                                    opacity: parametrs.is_point_override ? 1 : 0
                                    z: 1
                                    color: "#66E8A3"
                                    text: "логов"
                                    font.pixelSize: 24
                                    font.family: cleanerFontRegular.name
                                    font.letterSpacing: -1

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity9Anim7; duration: !animationEnabled ? 0 : 1050; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_point_overrideChanged() {
                                            opacity9Anim7.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 1050;
                                        }
                                    }
                            }


                                Rectangle {
                                    id: binindicator9
                                    color: "#6E2F2F"
                                    border.width: 2
                                    border.color: "#66E8A3"
                                    width: 43
                                    height: 43
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    anchors.left: parent.left
                                    anchors.leftMargin: 435
                                    radius: 6
                                    visible:  opacity > 0
                                    opacity: parametrs.is_point_override ? 1 : 0
                                    z: 1

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            logsviewer.cleanLogPath("PointCleaner.txt")
                                            logsviewer.loadLogs("PointCleaner.txt")
                                            addNotification("Лог точки восстановления\nуспешно очищен")
                                            logText9.text = (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                                        }
                                    }

                                    Behavior on opacity {
                                        NumberAnimation { id: opacity9Anim8; duration: !animationEnabled ? 0 : 1150; easing.type: Easing.InOutQuad }
                                    }
                                    Connections {
                                        target: parametrs
                                        function onIs_point_overrideChanged() {
                                            opacity9Anim8.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 1150;
                                        }
                                    }


                                    Image {
                                        source: "assets/images/parametrs/trash.png"
                                        width: 32
                                        height: 32
                                        anchors.centerIn: parent
                                    }
                                }

                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 29
                                        anchors.left: parent.left
                                        anchors.leftMargin: 487
                                        opacity: parametrs.is_point_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "Очистка"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1

                                        Behavior on opacity {
                                            NumberAnimation { id: opacity9Anim9; duration: !animationEnabled ? 0 : 1250; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_point_overrideChanged() {
                                                opacity9Anim9.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 1250;
                                            }
                                        }
                                }


                                    Text {
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 9
                                        anchors.left: parent.left
                                        anchors.leftMargin: 498
                                        opacity: parametrs.is_point_override ? 1 : 0
                                        z: 1
                                        color: "#66E8A3"
                                        text: "логов"
                                        font.pixelSize: 24
                                        font.family: cleanerFontRegular.name
                                        font.letterSpacing: -1
                                        Behavior on opacity {
                                            NumberAnimation { id: opacity9Anim10; duration: !animationEnabled ? 0 : 1350; easing.type: Easing.InOutQuad }
                                        }
                                        Connections {
                                            target: parametrs
                                            function onIs_point_overrideChanged() {
                                                opacity9Anim10.duration = !animationEnabled ? 0 : parametrs.is_point_override ? 100 : 1350;
                                            }
                                        }

                                }


                        RadioButton {
                            id: tempRadio9
                            width: 60
                            height: 60
                            x: 80
                            scale: 1.1
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            anchors.right: parent.right
                            anchors.rightMargin: 90
                            font.pixelSize: 16
                            font.bold: true

                            indicator: Rectangle {
                                implicitWidth: 60
                                implicitHeight: 60
                                radius: width / 2
                                color: "transparent"
                                border.width: 2
                                border.color: tempRadio9.checked ? "#B00102" : "#66E8A3"

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.width - 17
                                    height: parent.height - 17
                                    radius: width / 2
                                    color: tempRadio9.checked ? "#B00102" : "#66E8A3"
                                }

                                Behavior on color {
                                    ColorAnimation { duration: !animationEnabled ? 0 : 200 }
                                }

                                Behavior on border.color {
                                    ColorAnimation { duration: !animationEnabled ? 0 : 180 }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    tempRadio9.checked = !tempRadio9.checked
                                    quanta_settings.parametr_block9_active = !quanta_settings.parametr_block9_active
                                }
                            }
                    }
                }
               }
            }
        }
    }











        // temp_logs_viewer
        Component {
            id: logPopupComponent

            Popup {
                id: tempLogView
                focus: true
                // clip: true
                z: 30

                width: parametrs.width - 30
                height: parametrs.height - 20
                x: -333
                y: -160

                exit: Transition { }
                background: Rectangle { color: "transparent" }

                onOpened: {
                    Qt.callLater(gc)
                    console.log("opened")
                    logsviewer.loadLogs("tempLog.txt")
                    logText.text = logsviewer.logs.length > 0 ? logsviewer.logs.join("\n") : "Файл пуст"
                }

                onClosed: {
                    logText.text = ""
                    lineNumbers.text = ""
                    logsviewer.clearLogs()

                    var popup = parametrs.tempLogPopup
                    parametrs.tempLogPopup = null

                    Qt.callLater(function() {
                        if (popup) {
                            popup.destroy()
                            gc()
                        }
                    })
                }

                Rectangle {
                    width: 20
                    height: 20
                    color: "#382022"
                    anchors.right: parent.right
                    anchors.rightMargin: -22
                    anchors.top: parent.top
                    anchors.topMargin: -17
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
                            logText.text = ""
                            lineNumbers.text = ""
                            logsviewer.clearLogs()

                            var popup = parametrs.tempLogPopup
                            parametrs.tempLogPopup = null

                            Qt.callLater(function() {
                                if (popup) {
                                    popup.destroy()
                                    gc()
                                }
                            })
                        }
                    }
                }


                Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    Rectangle {
                        id: contentBackground
                        anchors.fill: parent
                        radius: 15
                        color: "#241415"
                        border.color: "#241415"
                        border.width: 10
                        clip: true

                       onWidthChanged: lineNumbers.text = generateLineNumbers()
                       onHeightChanged: lineNumbers.text = generateLineNumbers()

                        Row {
                            anchors.fill: parent
                            spacing: 5

                            Flickable {
                                id: flickableNumbers
                                width: 40
                                height: parent.height
                                clip: true
                                contentHeight: logText.contentHeight
                                interactive: false

                                Rectangle {
                                    anchors.fill: parent
                                    color: "#240B02"
                                }

                                TextEdit {
                                    id: lineNumbers
                                    text: generateLineNumbers()
                                    color: "gray"
                                    font.pixelSize: 16
                                    readOnly: true
                                    selectByMouse: false
                                    width: parent.width
                                    wrapMode: TextEdit.WrapAnywhere
                                }
                            }

                            Flickable {
                                id: flickableLogs
                                width: parent.width - 45
                                height: parent.height
                                clip: true
                                contentHeight: logText.contentHeight
                                boundsBehavior: Flickable.StopAtBounds

                                onContentYChanged: flickableNumbers.contentY = contentY

                                TextEdit {
                                    id: logText
                                    text: ""
                                    color: "white"
                                    font.pixelSize: 16
                                    readOnly: true
                                    selectByMouse: true
                                    wrapMode: TextEdit.Wrap
                                    width: parent.width - 30

                                    onTextChanged: lineNumbers.text = generateLineNumbers()
                                }

                                ScrollBar.vertical: ScrollBar {
                                    id: customScrollBarVertical
                                    policy: ScrollBar.AlwaysOn
                                    width: 10

                                    background: Rectangle {
                                        color: parametrs.hover_tmp ? "#563A4A" : "#5B2946"
                                        implicitWidth: 10
                                        implicitHeight: customScrollBarVertical.height
                                    }

                                    contentItem: Item {
                                        implicitWidth: 10
                                        Rectangle {
                                            width: 8
                                            anchors.left: parent.left
                                            implicitWidth: 8
                                            height: parent.height
                                            color: parametrs.hover_tmp ? "#66e8a3" : "#57AF80"
                                            radius: 10

                                            Behavior on height {
                                                NumberAnimation {
                                                    duration: 150
                                                    easing.type: Easing.InOutQuad
                                                }
                                            }
                                        }
                                    }

                                    HoverHandler {
                                        id: hover_temp
                                        onHoveredChanged: parametrs.hover_tmp = hovered
                                    }
                                }
                            }
                        }
                    }
                }

                function generateLineNumbers() {
                    if (!logText || logText.lineCount === 0) return "";
                    let result = "";
                    for (let i = 1; i <= logText.lineCount; i++) {
                        result += i + "\n";
                    }
                    return result;
                }
            }
        }





        // winssxs logs view
        Popup {
         id: xsxLogView
         focus: true
         width: parametrs.width - 40
         height: parametrs.height - 45
         x: (parametrs.width - width) / 2
         y: (parametrs.height - height) / 2
         onOpened: {
             console.log("oppend win")
             logsviewer.loadLogs("WinSxSCleaner.txt")
         }
         onClosed: {
             console.log("closed")
             global_close_prm_logs.visible = false
         }
         // clip: true
         z: 30
         exit: Transition { }

         background: Rectangle { color: "transparent" }

         Rectangle {
             width: 20
             height: 20
             color: "#382022"
             anchors.right: parent.right
             anchors.rightMargin: -27
             anchors.top: parent.top
             anchors.topMargin: -29
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
                     xsxLogView.close()
                 }
             }
         }

         Rectangle {
             width: parametrs.width - 50
             height: parametrs.height - 50
             anchors.centerIn: parent
             radius: 15
             color: "transparent"
             border.color: "#241415"
             border.width: 10
         }

         Rectangle {
             anchors.fill: parent
             color: "#241415"
             radius: 15
             clip: true
             onWidthChanged: lineNumbers2.text = generateLineNumbers2()
            onHeightChanged: lineNumbers2.text = generateLineNumbers2()

             Row {
                 anchors.fill: parent
                 spacing: 5

                 Flickable {
                     id: flickableNumbers2
                     width: 40
                     height: parent.height
                     clip: true
                     contentHeight: logText2.contentHeight
                     interactive: false

                     Rectangle {
                         anchors.fill: parent
                         color: "#240B02"

                     TextEdit {
                         z: 1
                         id: lineNumbers2
                         text: generateLineNumbers2()
                         color: "gray"
                         font.pixelSize: 16
                         readOnly: true
                         selectByMouse: false
                         width: parent.width
                         wrapMode: TextEdit.WrapAnywhere

                     }
                     }
                 }

                 Flickable {
                     id: flickableLogs2
                     width: parent.width - 45
                     height: parent.height
                     clip: true
                     contentHeight: logText2.contentHeight
                     boundsBehavior: Flickable.StopAtBounds

                     onContentYChanged: flickableNumbers2.contentY = contentY

                     TextEdit {
                         id: logText2
                         text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                         color: "white"
                         font.pixelSize: 16
                         readOnly: true
                         selectByMouse: true
                         wrapMode: TextEdit.Wrap
                         width: parent.width - 30
                         onTextChanged: lineNumbers2.text = generateLineNumbers2()
                     }
                     ScrollBar.vertical: ScrollBar {
                         id: customScrollBarVertical2
                         policy: ScrollBar.AlwaysOn
                         width: 10


                         background: Rectangle {
                             color: parametrs.hover_tmp ? "#563A4A" :  "#5B2946"
                             implicitWidth: 10
                             implicitHeight: customScrollBarVertical2.height

                         }

                         contentItem: Item {
                             implicitWidth: 10
                             Rectangle {
                                 width: 8
                                 anchors.left: parent.left
                                 implicitWidth: 8
                                 height: parent.height
                                 color: parametrs.hover_sxs ? "#66e8a3" : "#57AF80"
                                 radius: 10
                                 Behavior on height {
                                             NumberAnimation {
                                                 duration: 150
                                                 easing.type: Easing.InOutQuad
                                            }
                                    }
                              }
                         }


                         HoverHandler {
                             id: hoversxs
                             onHoveredChanged: parametrs.hover_sxs = hovered
                         }
                     }
                 }
             }
         }

        }

        function generateLineNumbers2() {
         if (!logText2|| logText2.lineCount === 0) return "";

         let result = "";
         for (let i = 1; i <= logText2.lineCount; i++) {
             result += i + "\n";
         }
         return result;
        }

        //win temp clean
        Popup {
         id: wintempLogView
         focus: true
         width: parametrs.width - 40
         height: parametrs.height - 45
         x: (parametrs.width - width) / 2
         y: (parametrs.height - height) / 2
         onOpened: {
             console.log("oppend wintemp")
             logsviewer.loadLogs("winTempClean.txt")
         }
         onClosed: {
             console.log("closed")
             global_close_prm_logs.visible = false
         }
         clip: true
         z: 30
         exit: Transition { }

         background: Rectangle { color: "transparent" }

         Rectangle {
             width: parametrs.width - 50
             height: parametrs.height - 50
             anchors.centerIn: parent
             radius: 15
             color: "transparent"
             border.color: "#241415"
             border.width: 10
         }

         Rectangle {
             anchors.fill: parent
             color: "#241415"
             radius: 15
             clip: true
             onWidthChanged: lineNumbers3.text = generateLineNumbers3()
            onHeightChanged: lineNumbers3.text = generateLineNumbers3()

             Row {
                 anchors.fill: parent
                 spacing: 5

                 Flickable {
                     id: flickableNumbers3
                     width: 40
                     height: parent.height
                     clip: true
                     contentHeight: logText3.contentHeight
                     interactive: false

                     Rectangle {
                         anchors.fill: parent
                         color: "#240B02"

                     TextEdit {
                         z: 1
                         id: lineNumbers3
                         text: generateLineNumbers3()
                         color: "gray"
                         font.pixelSize: 16
                         readOnly: true
                         selectByMouse: false
                         width: parent.width
                         wrapMode: TextEdit.WrapAnywhere

                     }
                     }
                 }

                 Flickable {
                     id: flickableLogs3
                     width: parent.width - 45
                     height: parent.height
                     clip: true
                     contentHeight: logText3.contentHeight
                     boundsBehavior: Flickable.StopAtBounds

                     onContentYChanged: flickableNumbers3.contentY = contentY

                     TextEdit {
                         id: logText3
                         text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                         color: "white"
                         font.pixelSize: 16
                         readOnly: true
                         selectByMouse: true
                         wrapMode: TextEdit.Wrap
                         width: parent.width - 30
                         onTextChanged: lineNumbers3.text = generateLineNumbers3()
                     }
                     ScrollBar.vertical: ScrollBar {
                         id: customScrollBarVertical3
                         policy: ScrollBar.AlwaysOn
                         width: 10


                         background: Rectangle {
                             color: parametrs.hover_wintemp ? "#563A4A" :  "#5B2946"
                             implicitWidth: 10
                             implicitHeight: customScrollBarVertical3.height

                         }

                         contentItem: Item {
                             implicitWidth: 10
                             Rectangle {
                                 width: 8
                                 anchors.left: parent.left
                                 implicitWidth: 8
                                 height: parent.height
                                 color: parametrs.hover_wintemp ? "#66e8a3" : "#57AF80"
                                 radius: 10
                                 Behavior on height {
                                             NumberAnimation {
                                                 duration: 150
                                                 easing.type: Easing.InOutQuad
                                            }
                                    }
                              }
                         }


                         HoverHandler {
                             id: hoverwintemp
                             onHoveredChanged: parametrs.hover_wintemp = hovered
                         }
                     }
                 }
             }
         }

        }

        function generateLineNumbers3() {
         if (!logText3 || logText3.lineCount === 0) return "";

         let result = "";
         for (let i = 1; i <= logText3.lineCount; i++) {
             result += i + "\n";
         }
         return result;
        }

        //font cache clean
        Popup {
          id: fontsLogView
          focus: true
          width: parametrs.width - 40
          height: parametrs.height - 45
          x: (parametrs.width - width) / 2
          y: (parametrs.height - height) / 2
          onOpened: {
              console.log("oppend font cache")
              logsviewer.loadLogs("fontCache.txt")
          }
          onClosed: {
              console.log("closed")
              global_close_prm_logs.visible = false
          }
          clip: true
          z: 30
          exit: Transition { }

          background: Rectangle { color: "transparent" }

          Rectangle {
              width: parametrs.width - 50
              height: parametrs.height - 50
              anchors.centerIn: parent
              radius: 15
              color: "transparent"
              border.color: "#241415"
              border.width: 10
          }

          Rectangle {
              anchors.fill: parent
              color: "#241415"
              radius: 15
              clip: true
              onWidthChanged: lineNumbers4.text = generateLineNumbers4()
             onHeightChanged: lineNumbers4.text = generateLineNumbers4()

              Row {
                  anchors.fill: parent
                  spacing: 5

                  Flickable {
                      id: flickableNumbers4
                      width: 40
                      height: parent.height
                      clip: true
                      contentHeight: logText4.contentHeight
                      interactive: false

                      Rectangle {
                          anchors.fill: parent
                          color: "#240B02"

                      TextEdit {
                          z: 1
                          id: lineNumbers4
                          text: generateLineNumbers4()
                          color: "gray"
                          font.pixelSize: 16
                          readOnly: true
                          selectByMouse: false
                          width: parent.width
                          wrapMode: TextEdit.WrapAnywhere

                      }
                      }
                  }

                  Flickable {
                      id: flickableLogs4
                      width: parent.width - 45
                      height: parent.height
                      clip: true
                      contentHeight: logText4.contentHeight
                      boundsBehavior: Flickable.StopAtBounds

                      onContentYChanged: flickableNumbers4.contentY = contentY

                      TextEdit {
                          id: logText4
                          text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                          color: "white"
                          font.pixelSize: 16
                          readOnly: true
                          selectByMouse: true
                          wrapMode: TextEdit.Wrap
                          width: parent.width - 30
                          onTextChanged: lineNumbers4.text = generateLineNumbers4()
                      }
                      ScrollBar.vertical: ScrollBar {
                          id: customScrollBarVertical4
                          policy: ScrollBar.AlwaysOn
                          width: 10


                          background: Rectangle {
                              color: parametrs.hover_fonts ? "#563A4A" :  "#5B2946"
                              implicitWidth: 10
                              implicitHeight: customScrollBarVertical4.height

                          }

                          contentItem: Item {
                              implicitWidth: 10
                              Rectangle {
                                  width: 8
                                  anchors.left: parent.left
                                  implicitWidth: 8
                                  height: parent.height
                                  color: parametrs.hover_fonts ? "#66e8a3" : "#57AF80"
                                  radius: 10
                                  Behavior on height {
                                              NumberAnimation {
                                                  duration: 150
                                                  easing.type: Easing.InOutQuad
                                             }
                                     }
                               }
                          }


                          HoverHandler {
                              id: hoverwinfonts
                              onHoveredChanged: parametrs.hover_fonts = hovered
                          }
                      }
                  }
              }
          }

        }

        function generateLineNumbers4() {
          if (!logText4 || logText4.lineCount === 0) return "";

          let result = "";
          for (let i = 1; i <= logText4.lineCount; i++) {
              result += i + "\n";
          }
          return result;
        }

        //bin cache clean
        Popup {
           id: binLogView
           focus: true
           width: parametrs.width - 40
           height: parametrs.height - 45
           x: (parametrs.width - width) / 2
           y: (parametrs.height - height) / 2
           onOpened: {
               logsviewer.loadLogs("recycleLog.txt")
           }
           onClosed: {
               global_close_prm_logs.visible = false
           }
           clip: true
           z: 30
           exit: Transition { }

           background: Rectangle { color: "transparent" }

           Rectangle {
               width: parametrs.width - 50
               height: parametrs.height - 50
               anchors.centerIn: parent
               radius: 15
               color: "transparent"
               border.color: "#241415"
               border.width: 10
           }

           Rectangle {
               anchors.fill: parent
               color: "#241415"
               radius: 15
               clip: true
               onWidthChanged: lineNumbers5.text = generateLineNumbers5()
              onHeightChanged: lineNumbers5.text = generateLineNumbers5()

               Row {
                   anchors.fill: parent
                   spacing: 5

                   Flickable {
                       id: flickableNumbers5
                       width: 40
                       height: parent.height
                       clip: true
                       contentHeight: logText5.contentHeight
                       interactive: false

                       Rectangle {
                           anchors.fill: parent
                           color: "#240B02"

                       TextEdit {
                           z: 1
                           id: lineNumbers5
                           text: generateLineNumbers5()
                           color: "gray"
                           font.pixelSize: 16
                           readOnly: true
                           selectByMouse: false
                           width: parent.width
                           wrapMode: TextEdit.WrapAnywhere

                       }
                       }
                   }

                   Flickable {
                       id: flickableLogs5
                       width: parent.width - 45
                       height: parent.height
                       clip: true
                       contentHeight: logText5.contentHeight
                       boundsBehavior: Flickable.StopAtBounds

                       onContentYChanged: flickableNumbers5.contentY = contentY

                       TextEdit {
                           id: logText5
                           text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                           color: "white"
                           font.pixelSize: 16
                           readOnly: true
                           selectByMouse: true
                           wrapMode: TextEdit.Wrap
                           width: parent.width - 30
                           onTextChanged: lineNumbers5.text = generateLineNumbers5()
                       }
                       ScrollBar.vertical: ScrollBar {
                           id: customScrollBarVertical5
                           policy: ScrollBar.AlwaysOn
                           width: 10


                           background: Rectangle {
                               color: parametrs.hover_bin ? "#563A4A" :  "#5B2946"
                               implicitWidth: 10
                               implicitHeight: customScrollBarVertical5.height

                           }

                           contentItem: Item {
                               implicitWidth: 10
                               Rectangle {
                                   width: 8
                                   anchors.left: parent.left
                                   implicitWidth: 8
                                   height: parent.height
                                   color: parametrs.hover_bin ? "#66e8a3" : "#57AF80"
                                   radius: 10
                                   Behavior on height {
                                               NumberAnimation {
                                                   duration: 150
                                                   easing.type: Easing.InOutQuad
                                              }
                                      }
                                }
                           }


                           HoverHandler {
                               id: hoverbin
                               onHoveredChanged: parametrs.hover_bin = hovered
                           }
                       }
                   }
               }
           }

        }

        function generateLineNumbers5() {
           if (!logText5 || logText5.lineCount === 0) return "";

           let result = "";
           for (let i = 1; i <= logText5.lineCount; i++) {
               result += i + "\n";
           }
           return result;
        }

        //update cache clean
        Popup {
            id: updateLogView
            focus: true
            width: parametrs.width - 40
            height: parametrs.height - 45
            x: (parametrs.width - width) / 2
            y: (parametrs.height - height) / 2
            onOpened: {
                logsviewer.loadLogs("updateWinLog.txt")
            }
            onClosed: {
                global_close_prm_logs.visible = false
            }
            clip: true
            z: 30
            exit: Transition { }

            background: Rectangle { color: "transparent" }

            Rectangle {
                width: parametrs.width - 50
                height: parametrs.height - 50
                anchors.centerIn: parent
                radius: 15
                color: "transparent"
                border.color: "#241415"
                border.width: 10
            }

            Rectangle {
                anchors.fill: parent
                color: "#241415"
                radius: 15
                clip: true
                onWidthChanged: lineNumbers6.text = generateLineNumbers6()
               onHeightChanged: lineNumbers6.text = generateLineNumbers6()

                Row {
                    anchors.fill: parent
                    spacing: 5

                    Flickable {
                        id: flickableNumbers6
                        width: 40
                        height: parent.height
                        clip: true
                        contentHeight: logText6.contentHeight
                        interactive: false

                        Rectangle {
                            anchors.fill: parent
                            color: "#240B02"

                        TextEdit {
                            z: 1
                            id: lineNumbers6
                            text: generateLineNumbers6()
                            color: "gray"
                            font.pixelSize: 16
                            readOnly: true
                            selectByMouse: false
                            width: parent.width
                            wrapMode: TextEdit.WrapAnywhere

                        }
                        }
                    }

                    Flickable {
                        id: flickableLogs6
                        width: parent.width - 45
                        height: parent.height
                        clip: true
                        contentHeight: logText6.contentHeight
                        boundsBehavior: Flickable.StopAtBounds

                        onContentYChanged: flickableNumbers6.contentY = contentY

                        TextEdit {
                            id: logText6
                            text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                            color: "white"
                            font.pixelSize: 16
                            readOnly: true
                            selectByMouse: true
                            wrapMode: TextEdit.Wrap
                            width: parent.width - 30
                            onTextChanged: lineNumbers6.text = generateLineNumbers6()
                        }
                        ScrollBar.vertical: ScrollBar {
                            id: customScrollBarVertical6
                            policy: ScrollBar.AlwaysOn
                            width: 10


                            background: Rectangle {
                                color: parametrs.hover_update ? "#563A4A" :  "#5B2946"
                                implicitWidth: 10
                                implicitHeight: customScrollBarVertical6.height

                            }

                            contentItem: Item {
                                implicitWidth: 10
                                Rectangle {
                                    width: 8
                                    anchors.left: parent.left
                                    implicitWidth: 8
                                    height: parent.height
                                    color: parametrs.hover_update ? "#66e8a3" : "#57AF80"
                                    radius: 10
                                    Behavior on height {
                                                NumberAnimation {
                                                    duration: 150
                                                    easing.type: Easing.InOutQuad
                                               }
                                       }
                                 }
                            }


                            HoverHandler {
                                id: hoverupdate
                                onHoveredChanged: parametrs.hover_update = hovered
                            }
                        }
                    }
                }
            }

        }

        function generateLineNumbers6() {
            if (!logText6 || logText6.lineCount === 0) return "";

            let result = "";
            for (let i = 1; i <= logText6.lineCount; i++) {
                result += i + "\n";
            }
            return result;
        }

        //event cache clean
         Popup {
             id: eventLogView
             focus: true
             width: parametrs.width - 40
             height: parametrs.height - 45
             x: (parametrs.width - width) / 2
             y: (parametrs.height - height) / 2
             onOpened: {
                 logsviewer.loadLogs("eventLog.txt")
             }
             onClosed: {
                 global_close_prm_logs.visible = false
             }
             clip: true
             z: 30
             exit: Transition { }

             background: Rectangle { color: "transparent" }

             Rectangle {
                 width: parametrs.width - 50
                 height: parametrs.height - 50
                 anchors.centerIn: parent
                 radius: 15
                 color: "transparent"
                 border.color: "#241415"
                 border.width: 10
             }

             Rectangle {
                 anchors.fill: parent
                 color: "#241415"
                 radius: 15
                 clip: true
                 onWidthChanged: lineNumbers7.text = generateLineNumbers7()
                onHeightChanged: lineNumbers7.text = generateLineNumbers7()

                 Row {
                     anchors.fill: parent
                     spacing: 5

                     Flickable {
                         id: flickableNumbers7
                         width: 40
                         height: parent.height
                         clip: true
                         contentHeight: logText7.contentHeight
                         interactive: false

                         Rectangle {
                             anchors.fill: parent
                             color: "#240B02"

                         TextEdit {
                             z: 1
                             id: lineNumbers7
                             text: generateLineNumbers7()
                             color: "gray"
                             font.pixelSize: 16
                             readOnly: true
                             selectByMouse: false
                             width: parent.width
                             wrapMode: TextEdit.WrapAnywhere

                         }
                         }
                     }

                     Flickable {
                         id: flickableLogs7
                         width: parent.width - 45
                         height: parent.height
                         clip: true
                         contentHeight: logText7.contentHeight
                         boundsBehavior: Flickable.StopAtBounds

                         onContentYChanged: flickableNumbers7.contentY = contentY

                         TextEdit {
                             id: logText7
                             text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                             color: "white"
                             font.pixelSize: 16
                             readOnly: true
                             selectByMouse: true
                             wrapMode: TextEdit.Wrap
                             width: parent.width - 30
                             onTextChanged: lineNumbers7.text = generateLineNumbers7()
                         }
                         ScrollBar.vertical: ScrollBar {
                             id: customScrollBarVertical7
                             policy: ScrollBar.AlwaysOn
                             width: 10


                             background: Rectangle {
                                 color: parametrs.hover_event ? "#563A4A" :  "#5B2946"
                                 implicitWidth: 10
                                 implicitHeight: customScrollBarVertical7.height

                             }

                             contentItem: Item {
                                 implicitWidth: 10
                                 Rectangle {
                                     width: 8
                                     anchors.left: parent.left
                                     implicitWidth: 8
                                     height: parent.height
                                     color: parametrs.hover_event ? "#66e8a3" : "#57AF80"
                                     radius: 10
                                     Behavior on height {
                                                 NumberAnimation {
                                                     duration: 150
                                                     easing.type: Easing.InOutQuad
                                                }
                                        }
                                  }
                             }


                             HoverHandler {
                                 id: hoverevent
                                 onHoveredChanged: parametrs.hover_event = hovered
                             }
                         }
                     }
                 }
             }

         }

         function generateLineNumbers7() {
             if (!logText7 || logText7.lineCount === 0) return "";

             let result = "";
             for (let i = 1; i <= logText7.lineCount; i++) {
                 result += i + "\n";
             }
             return result;
         }

         //dumps cache clean
          Popup {
              id: dumpsLogView
              focus: true
              width: parametrs.width - 40
              height: parametrs.height - 45
              x: (parametrs.width - width) / 2
              y: (parametrs.height - height) / 2
              onOpened: {
                  logsviewer.loadLogs("crashDump.txt")
              }
              onClosed: {
                  global_close_prm_logs.visible = false
              }
              clip: true
              z: 30
              exit: Transition { }

              background: Rectangle { color: "transparent" }

              Rectangle {
                  width: parametrs.width - 50
                  height: parametrs.height - 50
                  anchors.centerIn: parent
                  radius: 15
                  color: "transparent"
                  border.color: "#241415"
                  border.width: 10
              }

              Rectangle {
                  anchors.fill: parent
                  color: "#241415"
                  radius: 15
                  clip: true
                  onWidthChanged: lineNumbers8.text = generateLineNumbers8()
                 onHeightChanged: lineNumbers8.text = generateLineNumbers8()

                  Row {
                      anchors.fill: parent
                      spacing: 5

                      Flickable {
                          id: flickableNumbers8
                          width: 40
                          height: parent.height
                          clip: true
                          contentHeight: logText8.contentHeight
                          interactive: false

                          Rectangle {
                              anchors.fill: parent
                              color: "#240B02"

                          TextEdit {
                              z: 1
                              id: lineNumbers8
                              text: generateLineNumbers8()
                              color: "gray"
                              font.pixelSize: 16
                              readOnly: true
                              selectByMouse: false
                              width: parent.width
                              wrapMode: TextEdit.WrapAnywhere

                          }
                          }
                      }

                      Flickable {
                          id: flickableLogs8
                          width: parent.width - 45
                          height: parent.height
                          clip: true
                          contentHeight: logText8.contentHeight
                          boundsBehavior: Flickable.StopAtBounds

                          onContentYChanged: flickableNumbers8.contentY = contentY

                          TextEdit {
                              id: logText8
                              text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                              color: "white"
                              font.pixelSize: 16
                              readOnly: true
                              selectByMouse: true
                              wrapMode: TextEdit.Wrap
                              width: parent.width - 30
                              onTextChanged: lineNumbers8.text = generateLineNumbers8()
                          }
                          ScrollBar.vertical: ScrollBar {
                              id: customScrollBarVertical8
                              policy: ScrollBar.AlwaysOn
                              width: 10


                              background: Rectangle {
                                  color: parametrs.hover_dumps ? "#563A4A" :  "#5B2946"
                                  implicitWidth: 10
                                  implicitHeight: customScrollBarVertical8.height

                              }

                              contentItem: Item {
                                  implicitWidth: 10
                                  Rectangle {
                                      width: 8
                                      anchors.left: parent.left
                                      implicitWidth: 8
                                      height: parent.height
                                      color: parametrs.hover_dumps ? "#66e8a3" : "#57AF80"
                                      radius: 10
                                      Behavior on height {
                                                  NumberAnimation {
                                                      duration: 150
                                                      easing.type: Easing.InOutQuad
                                                 }
                                         }
                                   }
                              }


                              HoverHandler {
                                  id: hoverdumps
                                  onHoveredChanged: parametrs.hover_dumps = hovered
                              }
                          }
                      }
                  }
              }

          }

          function generateLineNumbers8() {
              if (!logText8 || logText8.lineCount === 0) return "";

              let result = "";
              for (let i = 1; i <= logText8.lineCount; i++) {
                  result += i + "\n";
              }
              return result;
          }

          //point cache clean
           Popup {
               id: pointLogView
               focus: true
               width: parametrs.width - 40
               height: parametrs.height - 45
               x: (parametrs.width - width) / 2
               y: (parametrs.height - height) / 2
               onOpened: {
                   logsviewer.loadLogs("PointCleaner.txt")
               }
               onClosed: {
                   global_close_prm_logs.visible = false
               }
               clip: true
               z: 30
               exit: Transition { }

               background: Rectangle { color: "transparent" }

               Rectangle {
                   width: parametrs.width - 50
                   height: parametrs.height - 50
                   anchors.centerIn: parent
                   radius: 15
                   color: "transparent"
                   border.color: "#241415"
                   border.width: 10
               }

               Rectangle {
                   anchors.fill: parent
                   color: "#241415"
                   radius: 15
                   clip: true
                   onWidthChanged: lineNumbers9.text = generateLineNumbers9()
                  onHeightChanged: lineNumbers9.text = generateLineNumbers9()

                   Row {
                       anchors.fill: parent
                       spacing: 5

                       Flickable {
                           id: flickableNumbers9
                           width: 40
                           height: parent.height
                           clip: true
                           contentHeight: logText9.contentHeight
                           interactive: false

                           Rectangle {
                               anchors.fill: parent
                               color: "#240B02"

                           TextEdit {
                               z: 1
                               id: lineNumbers9
                               text: generateLineNumbers9()
                               color: "gray"
                               font.pixelSize: 16
                               readOnly: true
                               selectByMouse: false
                               width: parent.width
                               wrapMode: TextEdit.WrapAnywhere

                           }
                           }
                       }

                       Flickable {
                           id: flickableLogs9
                           width: parent.width - 45
                           height: parent.height
                           clip: true
                           contentHeight: logText9.contentHeight
                           boundsBehavior: Flickable.StopAtBounds

                           onContentYChanged: flickableNumbers9.contentY = contentY

                           TextEdit {
                               id: logText9
                               text: (logsviewer && logsviewer.logs.length > 0) ? logsviewer.logs.join("\n") : "Файл пуст"
                               color: "white"
                               font.pixelSize: 16
                               readOnly: true
                               selectByMouse: true
                               wrapMode: TextEdit.Wrap
                               width: parent.width - 30
                               onTextChanged: lineNumbers9.text = generateLineNumbers9()
                           }
                           ScrollBar.vertical: ScrollBar {
                               id: customScrollBarVertical9
                               policy: ScrollBar.AlwaysOn
                               width: 10


                               background: Rectangle {
                                   color: parametrs.hover_point ? "#563A4A" :  "#5B2946"
                                   implicitWidth: 10
                                   implicitHeight: customScrollBarVertical9.height

                               }

                               contentItem: Item {
                                   implicitWidth: 10
                                   Rectangle {
                                       width: 8
                                       anchors.left: parent.left
                                       implicitWidth: 8
                                       height: parent.height
                                       color: parametrs.hover_point ? "#66e8a3" : "#57AF80"
                                       radius: 10
                                       Behavior on height {
                                                   NumberAnimation {
                                                       duration: 150
                                                       easing.type: Easing.InOutQuad
                                                  }
                                          }
                                    }
                               }


                               HoverHandler {
                                   id: hoveredPoint
                                   onHoveredChanged: parametrs.hover_point = hovered
                               }
                           }
                       }
                   }
               }

           }

           function generateLineNumbers9() {
               if (!logText9 || logText9.lineCount === 0) return "";

               let result = "";
               for (let i = 1; i <= logText9.lineCount; i++) {
                   result += i + "\n";
               }
               return result;
           }



}

