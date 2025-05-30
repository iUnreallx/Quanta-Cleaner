import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Particles 2.15

Rectangle {
    id: mainpage
    anchors.fill: parent
    color: "#000000"

    property bool isHovered: false
    property bool isOverrideMain: quanta_settings.radioMainMenuBlock
    property bool animationEnabled: quanta_settings.settings_animation
    property bool initialLoadComplete: false

    property var quantaText: "Quanta"
    property var cleanedText: ""
    property var cleanFunctions: qsTr("WaitingTask") + (app.languageVersion ? "" : "")
    property var deleteText: qsTr("CleaningAnalysis") + (app.languageVersion ? "" : "")

    property bool fastRespawnProgressBar: false
    property bool resizeAnimationProgressBar: false

    onQuantaTextChanged: quanta_text.text = quantaText

    onWidthChanged: handleResize()
    onHeightChanged: handleResize()

    Timer {
        id: resizeTimer
        interval: 300
        repeat: false
        onTriggered: resizeAnimationProgressBar = false
    }

    function handleResize() {
        resizeAnimationProgressBar = true
        resizeTimer.restart()
    }

    Component.onCompleted: {
        Qt.callLater(() => initialLoadComplete = true)
    }

    Rectangle {
        id: myCheck
        anchors.top: parent.top
        anchors.topMargin: 12
        width: parent.width - 242
        height: mainpage.isOverrideMain ? 75 : 45
        color:  quanta_settings.settings_theme === 2 ? "#111111" : "#F0F0F0"
        radius: 10
        border.color: quanta_settings.settings_theme === 2 ? "#322825" : "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 227
        z: 5

        Behavior on height {
            NumberAnimation {
                duration: (!animationEnabled || !initialLoadComplete) ? 0 : 300
            }
        }

        Rectangle {
            id: progressBackground
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width - 120
            height: 25
            color: "#29211E"
            radius: 10
            border.color: quanta_settings.settings_theme === 2 ? "#5C3833" : "transparent"

            Rectangle {
                id: progressBar
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                height: parent.height
                radius: 10
                color: "#66E8A3"
                width: (quanta_settings.global_functions > 0)
                    ? ((main_window.taskCompleted / quanta_settings.global_functions) * (progressBackground.width - 10)) + 10
                    : 0

                Behavior on width {
                    NumberAnimation {
                        duration: !animationEnabled ? 0 : fastRespawnProgressBar ? 0 : (resizeAnimationProgressBar ? 0 : 300)
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        Text {
            id:  dltText
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.right: parent.right
            anchors.rightMargin: 14
            text: deleteText
            color: theme.text
            font.family: cleanerFontRegular.name
            font.pixelSize: 16
            font.bold: true
            opacity: parent.width < 460 ? 0 : (mainpage.isOverrideMain ? 0.9: 0)

            Behavior on opacity {
                NumberAnimation {
                    duration: (!animationEnabled || !initialLoadComplete) ? 0 : ( mainpage.isOverrideMain  ? (resizeAnimationProgressBar ? 0: 130) : (resizeAnimationProgressBar ? 0:320));
                    easing.type: Easing.InOutQuad }
            }
        }


        Text {
            id: progressText
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 65
            text: cleanedText
            color: theme.text
            font.family: cleanerFontRegular.name
            font.pixelSize: 18
            font.bold: true
            font.letterSpacing: -2
        }

        Text {
            id: progressFunction
            anchors.top: parent.top
            anchors.topMargin: 45
            anchors.left: parent.left
            anchors.leftMargin: 14
            text: cleanFunctions
            color: theme.text
            font.family: cleanerFontRegular.name
            font.pixelSize: 16
            font.bold: true
            opacity: mainpage.isOverrideMain ? 0.9: 0

            Behavior on opacity {
                NumberAnimation {
                    duration: (!animationEnabled || !initialLoadComplete) ? 0 : ( mainpage.isOverrideMain  ? 130 : 320);
                    easing.type: Easing.InOutQuad }
            }
        }

        Rectangle {
            id: overrideToggleMain
            color: "transparent"
            width: 43
            height: 43
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 14
            radius: 6

            property real angle: mainpage.isOverrideMain ? 0 : -90

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    quanta_settings.radioMainMenuBlock = !quanta_settings.radioMainMenuBlock
                    overrideToggleMain.angle = mainpage.isOverrideMain ? 0 : -90
                }
            }

            Image {
                id: chevronImageMain
                source: quanta_settings.settings_theme === 2 ? "assets/images/parametrs/chevron.png" : "assets/images/parametrs/chevron_black.png"
                width: 32
                height: 32
                anchors.centerIn: parent

                transform: Rotation {
                    id: rotationMain
                    origin.x: chevronImageMain.width / 2
                    origin.y: chevronImageMain.height / 2
                    angle: overrideToggleMain.angle
                }
            }

            Behavior on angle {
                NumberAnimation {
                    duration: (!animationEnabled || !initialLoadComplete) ? 0 : 300
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }


    function getActiveBlockCount() {
        let count = 0;
        for (let i = 1; i <= 9; i++) {
            if (quanta_settings["parametr_block" + i + "_active"] === false) {
                count++;
            }
        }
        return count;
    }

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: quanta_settings.settings_theme === 2 ? "#000000" : "#ffffff"
            }
            GradientStop {
                position: quanta_settings.settings_theme === 2 ? 0.8 : 0.6
                color: quanta_settings.settings_theme === 2 ? "#010a2a" : "#ffffff"
            }
            GradientStop {
                position: 1.0
                color: quanta_settings.settings_theme === 2 ? "#010a2a" : "#ffffff"
            }
        }
    }



    ParticleSystem {
        id: particleSystem
        anchors.fill: parent
        z: -1
        visible: quanta_settings.settings_animation
        running: quanta_settings.settings_animation
    }

    Emitter {
        system: particleSystem
        visible: quanta_settings.settings_animation
        emitRate: 20
        lifeSpan: 70000
        size: 8
        sizeVariation: 4
        width: 2
        height: 2
        z: -1
        startTime: 70000
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        velocity: AngleDirection {
            angle: -45
            angleVariation: 100
            magnitude: 35
            magnitudeVariation: 15
        }
    }

    ImageParticle {
        system: particleSystem
        visible: quanta_settings.settings_animation
        anchors.fill: parent
        source: "assets/images/circle.png"
        color: "#0052DF"
        colorVariation: 0.25
        z: 2
        entryEffect: ImageParticle.None

        opacity: 0.9
        alphaVariation: 0.25
    }

    Rectangle {
        id: button
        width: Math.min(Math.max(Window.width * 0.3, 200), 285)
        height: width
        radius: 80
        anchors.centerIn: parent
        anchors.verticalCenterOffset: mainpage.isOverrideMain ? 45 : 25
        anchors.horizontalCenterOffset: 105
        z : 5

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation {
                duration: (!animationEnabled || !initialLoadComplete) ? 0 : 300
                easing.type: Easing.InOutQuad
            }
        }

        gradient: Gradient {
            GradientStop {
                color: mainpage.isHovered ? "#0f2364" : "#060064"
                position: 0.0
            }
            GradientStop {
                color: mainpage.isHovered ? "#7d2319" : "#641400"
                position: 0.5
            }
            GradientStop {
                color: mainpage.isHovered ? "#ff2323" : "#ff0000"
                position: 1.0
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            // 0 - Fast mode, 1 - Normal mode (without time menegment), 2 - Debug Mode - with time menegment
            onClicked: (mouse) => {
                if (isInsideRoundedRect(mouse.x, mouse.y)) {
                    if (!quanta_settings.running_clean) {
                        var settings_count = getActiveBlockCount();
                        quanta_settings.global_functions = settings_count;
                        quanta_settings.running_clean = true;

                        mainpage.fastRespawnProgressBar = true
                        progressBar.width = 0
                        quanta_settings.cleanTextCome = true
                        mainpage.fastRespawnProgressBar = false

                        main_window.clearTotalSize();

                        if (quanta_settings.debugMode) {
                            if (!quanta_settings.parametr_block1_active) {
                                tmp.clearTempFolder(2, false);
                            }
                           if (!quanta_settings.parametr_block2_active) {
                               winsxs.cleanWinSXS(2, false);
                           }
                           if (!quanta_settings.parametr_block3_active) {
                               wintemp.cleanWinTemp(2, false);
                           }
                           if (!quanta_settings.parametr_block4_active) {
                               fontQ.fontCacheClean(2, false);
                           }
                           if (!quanta_settings.parametr_block5_active) {
                               binclear.cleanRecycleBin(2, false);
                           }

                           if (!quanta_settings.parametr_block6_active) {
                               updateQ.updateClean(2, false);
                           }
                           if (!quanta_settings.parametr_block7_active) {
                               eventQ.cleanEventLogs(2, false);
                           }
                           if (!quanta_settings.parametr_block8_active) {
                               dmp.cleanCrashDumps(2, false);
                           }
                           if (!quanta_settings.parametr_block9_active) {
                               pointQ.cleanRestorePoints(2, false);
                           }

                           if (settings_count === 0) {
                               quanta_settings.running_clean = false;
                           }

                               } else {
                                  if (!quanta_settings.parametr_block1_active) {
                                      tmp.clearTempFolder(0, false);
                                  }
                                  if (!quanta_settings.parametr_block2_active) {
                                      winsxs.cleanWinSXS(0, false);
                                  }
                                  if (!quanta_settings.parametr_block3_active) {
                                      wintemp.cleanWinTemp(0, false);
                                  }
                                  if (!quanta_settings.parametr_block4_active) {
                                      fontQ.fontCacheClean(0, false);
                                  }
                                  if (!quanta_settings.parametr_block5_active) {
                                      binclear.cleanRecycleBin(0, false);
                                  }
                                  if (!quanta_settings.parametr_block6_active) {
                                      updateQ.updateClean(0, false);
                                  }
                                  if (!quanta_settings.parametr_block7_active) {
                                      eventQ.cleanEventLogs(0, false);
                                  }
                                  if (!quanta_settings.parametr_block8_active) {
                                      dmp.cleanCrashDumps(0, false);
                                  }
                                  if (!quanta_settings.parametr_block9_active) {
                                      pointQ.cleanRestorePoints(0, false);
                                }
                             }
                         }
                     }
            }

            onPositionChanged: (mouse) => {
                var inside = isInsideRoundedRect(mouse.x, mouse.y);
                cursorShape = inside ? Qt.PointingHandCursor : Qt.ArrowCursor;
                mainpage.isHovered = inside;
            }

            onExited: {
                mainpage.isHovered = false;
                cursorShape = Qt.ArrowCursor;
            }

            function isInsideRoundedRect(x, y) {
                var rw = button.width;
                var rh = button.height;
                var cr = button.radius;
                var sx = 0;
                var sy = 0;

                if (x >= sx + cr && x <= sx + rw - cr && y >= sy && y <= sy + rh) return true;
                if (x >= sx && x <= sx + rw && y >= sy + cr && y <= sy + rh - cr) return true;

                var corners = [
                    { cx: sx + cr, cy: sy + cr },
                    { cx: sx + rw - cr, cy: sy + cr },
                    { cx: sx + cr, cy: sy + rh - cr },
                    { cx: sx + rw - cr, cy: sy + rh - cr }
                ];

                for (var i = 0; i < corners.length; i++) {
                    var dx = x - corners[i].cx;
                    var dy = y - corners[i].cy;
                    if (dx * dx + dy * dy <= cr * cr)
                        return true;
                }

                return false;
            }
        }

        Label {
            id: quanta_text
            text: "Quanta"
            font.pixelSize: 40
            font.bold: true
            color: "white"
            anchors.centerIn: parent
        }
    }
}
