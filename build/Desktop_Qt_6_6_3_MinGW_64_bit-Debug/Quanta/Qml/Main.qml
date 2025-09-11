import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.LocalStorage 2.0
import QtCore

ApplicationWindow {
    id: main_window
    Material.theme: Material.DeepOrange
    title: "Quanta"
    visible: true
    color: "black"
    width: 930
    height: 554
    minimumWidth: 500
    minimumHeight: 400
    font.family: cleanerFont.name

    property bool isOverlayVisible: false
    property bool tmphover_close: false

    Settings {
        id: quanta_settings

        property bool parametr_block1_active: false
        property bool parametr_block2_active: false
        property bool parametr_block3_active: false
        property bool parametr_block4_active: false
        property bool parametr_block5_active: true
        property bool parametr_block6_active: false
        property bool parametr_block7_active: false
        property bool parametr_block8_active: false
        property bool parametr_block9_active: true

        property bool settings_animation: true
        property bool settings_reload: false
        property bool settings_notify: false
        property bool debugMode: false

        property bool running_clean: false
        property int global_functions: 0
        property bool cleanTextCome: false
        property bool radioMainMenuBlock: true
    }

    Component.onCompleted: {
        quanta_settings.cleanTextCome = false
        quanta_settings.running_clean = false
        quanta_settings.global_functions = 0
        cleanFuncGlobal = `${main_window.taskCompleted} / ${getActiveBlockCount()}`
        pageLoader.item.cleanedText = cleanFuncGlobal
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


    ListModel {
        id: notificationModel
    }

    property var timers: []
    property int notificationCounter: 0

    function addNotification(message) {
        if (notificationModel.count >= 3) {
            notificationModel.remove(0);
            if (timers.length > 0) {
                var oldTimer = timers.shift();
                if (oldTimer && !oldTimer.destroyed) {
                    oldTimer.stop();
                    oldTimer.destroy();
                }
            }
        }

        notificationCounter++;
        let notifId = notificationCounter;

        notificationModel.append({ "message": message, "id": notifId });

        var timer = Qt.createQmlObject(
            'import QtQuick 2.15; Timer { interval: 5000; running: true; repeat: false; }',
            main_window
        );

        timer.triggered.connect((function(idCopy, t) {
            return function () {
                for (let i = 0; i < notificationsRepeater.count; i++) {
                    let item = notificationsRepeater.itemAt(i);
                    if (item && item.notifId === idCopy) {
                        item.animateExitAndRemove();
                        break;
                    }
                }

                let index = timers.indexOf(t);
                if (index !== -1) {
                    timers.splice(index, 1);
                }

                if (t && !t.destroyed) {
                    t.destroy();
                }
            }
        })(notifId, timer));

        timers.push(timer);
    }

    Popup {
        id: notificationsPopup
        modal: false
        focus: false
        background: null
        z: 100
        visible: notificationModel.count > 0
        closePolicy: Popup.NoAutoClose
        width: 270
        height: notificationsColumn.implicitHeight

        Binding {
            target: notificationsPopup
            property: "x"
            value: quanta_settings.settings_notify ? main_window.width - notificationsPopup.width - 25 : 10
        }

        Binding {
            target: notificationsPopup
            property: "y"
            value: main_window.height - notificationsPopup.height - 30
        }

        Column {
            id: notificationsColumn
            spacing: 10

            Repeater {
                id: notificationsRepeater
                model: notificationModel

                delegate: Item {
                    id: delegateItem
                    width: 270
                    height: 85
                    property int notifId: model.id
                    property bool isExiting: false

                    Rectangle {
                        id: notificationRect
                        width: parent.width
                        height: parent.height
                        radius: 15
                        color: "#32BC32"
                        x: quanta_settings.settings_notify ? parent.width + 10 : -width
                        opacity: 0

                        Text {
                            anchors.centerIn: parent
                            text: model.message
                            color: "white"
                            font.pixelSize: 17
                            wrapMode: Text.Wrap
                            font.family: cleanerFont.name
                            horizontalAlignment: Text.AlignHCenter
                            font.letterSpacing: -1
                        }
                    }

                    ParallelAnimation {
                        id: enterAnimation
                        NumberAnimation {
                            target: notificationRect
                            property: "x"
                            to: 0
                            duration: 300
                            easing.type: Easing.OutCubic
                        }
                        NumberAnimation {
                            target: notificationRect
                            property: "opacity"
                            to: 1
                            duration: 300
                        }
                    }

                    ParallelAnimation {
                        id: exitAnimation
                        running: false
                        NumberAnimation {
                            target: notificationRect
                            property: "x"
                            to: quanta_settings.settings_notify ? parent.width + 10 : -parent.width
                            duration: 300
                            easing.type: Easing.OutCubic
                        }
                        NumberAnimation {
                            target: notificationRect
                            property: "opacity"
                            to: 0
                            duration: 300
                        }

                        onStopped: {
                            if (isExiting) {
                                for (let i = 0; i < notificationModel.count; ++i) {
                                    if (notificationModel.get(i).id === notifId) {
                                        notificationModel.remove(i);
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    Component.onCompleted: {
                        enterAnimation.start();
                    }

                    function animateExitAndRemove() {
                        if (isExiting) return;
                        isExiting = true;
                        exitAnimation.start();
                    }
                }
            }
        }
    }


    Text {
        text: "text loader"
        font.family: cleanerFont.name
        visible: false
    }



    FontLoader {
        id: cleanerFont
        source: "assets/fonts/Ubuntu-Bold.ttf"
    }

    FontLoader {
        id: cleanerFontRegular
        source: "assets/fonts/Ubuntu-Regular.ttf"
    }


    Connections {
        target: tmp
        function onTempCleanResult(result) {
            addNotification("Очищено временных файлов на\n" + Number(result) + " МБ")
            console.log("Temp", result)

        }
        function onTempCleanResultTap(result) {
            main_window.tempSize = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "tempcleaner.cpp"
            console.log("Temp", result)
        }
    }

    Connections {
        target: winsxs
        function onCleanupWinSXSPoint(result) {
            if (result === "notAdmin") {
                addNotification("Запустите от имени\nадминистратора")
                return
            }
            addNotification("Очищено в winSxS на\n" + Number(result) + " МБ")
            console.log("WinSxS", result)
        }

        function onCleanupWinSXSPointTap(result) {
            main_window.winSxsSize = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "winsxscleaner.cpp"
            console.log("WinSxS", result)
        }
    }

    Connections {
        target: wintemp
        function onWinTempCleaned(result) {
            pageLoader.item.taskComplete += 1
            addNotification("Очищено в WinTemp на\n" + Number(result) + " МБ")
            console.log("WinTemp", result)
        }
        function onWinTempCleanedTap(result) {
            main_window.wintemp_ = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "wintempclean.cpp"
            console.log("WinTemp", result)
        }
    }

    Connections {
        target: fontQ
        function onFontCacheCleaned(result) {
            addNotification("Очищено FontCache файлов на\n" + Number(result) + " МБ")
            console.log("FONT CACHE", result)
        }
        function onFontCacheCleanedTap(result) {
            main_window.fontcache = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "fontcacheclean.cpp"
            console.log("FONT CACHE", result)
        }
    }


    Connections {
        target: binclear
        function onRecycleBinCleaned(result) {
            addNotification("Очищена корзина на\n" + Number(result) + " МБ")
            console.log("bin", result)
        }
        function onRecycleBinCleanedTap(result) {
            main_window.binSize = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "recyclebincleaner.cpp"
            console.log("bin", result)
        }
    }


    Connections {
        target: updateQ
        function onGetterClean(result) {
            addNotification("Очищено кеша обновлений на\n" + Number(result) + " МБ")
            console.log("update", result)
        }
        function onGetterCleanTap(result) {
            main_window.updateSize = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "winupdatecache.cpp"
            console.log("update", result)
        }
    }


    Connections {
        target: eventQ
        function onEventLogsCleaned(result) {
            addNotification("Очищено журнала событий на\n" + Number(result) + " МБ")
            console.log("event", result)
        }
        function onEventLogsCleanedTap(result) {
            main_window.eventLog = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "eventlog.cpp"
            console.log("event", result)
        }
    }

    Connections {
        target: dmp
        function onCrashDumpsCleaned(result) {
            addNotification("Очищено дампа ошибок\n" + Number(result) + " МБ")
            console.log("dump", result)
        }
        function onCrashDumpsCleanedTap(result) {
            main_window.crashdump = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "crashdump.cpp"
            console.log("dump", result)
        }
    }

    Connections {
        target: pointQ
        function onRestorePointsCleaned(result) {
            addNotification("Очищено мусора с\nточек восстановления на\n" + Number(result) + " МБ")
            console.log("point", result)

        }
        function onRestorePointsCleanedTap(result) {
            main_window.pointclean = Number(result)
            main_window.taskCompleted += 1
            pageLoader.item.cleanFunctions = "pointclean.cpp"
            console.log("point", result)
        }
    }

    property int taskCompleted: 0
    property double tempSize: 0
    property double winSxsSize: 0
    property double binSize: 0
    property double updateSize: 0
    property double eventLog: 0
    property double crashdump: 0
    property double fontcache: 0
    property double wintemp_: 0
    property double pointclean: 0

    property string quantaTextGlobal: "Quanta"
    property string cleanFuncGlobal: ""



    onTaskCompletedChanged: {
         cleanFuncGlobal = `${main_window.taskCompleted} / ${quanta_settings.global_functions}`
        updateTotalSize()
    }




    function updateTotalSize() {
        var total = (main_window.tempSize || 0) + (main_window.winSxsSize || 0) +
                    (main_window.binSize || 0) + (main_window.updateSize || 0) +
                    (main_window.eventLog || 0) + (main_window.crashdump || 0) + (main_window.fontcache || 0)
                    + (main_window.wintemp_ || 0) + (main_window.pointclean || 0);
        pageLoader.item.cleanedText = cleanFuncGlobal

        if (main_window.taskCompleted === quanta_settings.global_functions) {
           total = total.toFixed(1);
           var cleaned = total + " MB.";
           main_window.quantaTextGlobal = cleaned
            addNotification("Очищено " + cleaned)
            if (pageLoader.item && pageLoader.item.hasOwnProperty("quantaText")) {
                       pageLoader.item.quantaText = main_window.quantaTextGlobal
            }
            quanta_settings.running_clean = false
            return cleaned

        } else {
            return quantaTextGlobal
        }
    }

    function clearTotalSize() {
        tempSize = 0
        winSxsSize = 0
        binSize = 0
        updateSize = 0
        eventLog = 0
        crashdump = 0
        fontcache = 0
        wintemp_ = 0
        pointclean = 0
        taskCompleted = 0
    }



    Rectangle {
            id: globalOverlay
            anchors.fill: parent
            color: "black"
            opacity: isOverlayVisible ? 0.5 : 0.0
            visible: isOverlayVisible
            z: 20
            MouseArea {
                anchors.fill: parent
                onClicked: main_window.isOverlayVisible = false
            }
        }


    Rectangle {
        id: global_close_prm_logs
        width: 20
        height: 20
        color: "transparent"
        // radius: 30
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 4
        visible: false

        z: 100

        Text {
            text: "×"
            anchors.centerIn: parent
            color: "red"
            font.bold: true
            font.pixelSize: 30
            z: 2
        }
        Rectangle {
            height: 25
            width:  25
            radius: 30
            color:  tmphover_close ? "#471F1F":"transparent"
            anchors.top: parent.top
            anchors.topMargin: 1
            anchors.left: parent.left
            anchors.leftMargin: -3
            z: 1
        }

        HoverHandler {
            onHoveredChanged: {
                 tmphover_close = hovered
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                tempLogView.visible = false
                global_close_prm_logs.visible = false
        }
        }
    }



    Popup {
        id: languageDialog
        focus: true
        width: 300
        height: 400
        z: 22
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        onClosed: main_window.isOverlayVisible = false
        background: Rectangle {
            color: "transparent"
        }

        Rectangle {
            width: 20
            height: 20
            color: "transparent"
            radius: 3
            anchors.right: parent.right
            anchors.rightMargin: 17
            anchors.top: parent.top
            anchors.topMargin: 12
            z: 2

            Text {
                text: "×"
                anchors.centerIn: parent
                color: "red"
                font.pixelSize: 35
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
            color: "#241415"
            radius: 30

            Column {
                anchors.fill: parent
                spacing: 20

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Выберите язык")
                    color: "white"
                    font.pixelSize: 20
                    font.bold: true
                }

                ButtonGroup {
                    id: buttonGroup
                }

                RadioButton {
                    id: russianButton
                    anchors.top: parent.top
                    anchors.topMargin: 75
                    x: 80
                    text: "Русский"
                    font.pixelSize: 16
                    font.bold: true
                    scale: 1.1
                    checked: true

                    MouseArea {

                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked:
                        {
                            console.log('rus')
                            russianButton.checked = true
                        }
                    }
                }

                RadioButton {
                    id: englishButton
                    anchors.top: parent.top
                    anchors.topMargin: 125
                    x: 80
                    text: "English"
                    font.pixelSize: 16
                    font.bold: true
                    scale: 1.1

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            console.log('en')
                            englishButton.checked = true
                        }
                    }
                }


                Component.onCompleted: {
                    buttonGroup.addButton(russianButton)
                    buttonGroup.addButton(englishButton)
                }
            }
        }
    }




    Rectangle {
        id: sidebar
        anchors.left: parent.left
        height: parent.height
        width: 215
        color: "#111"

        Column {
            anchors.fill: parent
            topPadding: 20
            spacing: Math.min(14, Math.max(1, 0 + (height * 0.02)))

            HoverButton {
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                id: mainButton
                text: qsTr("Главная")
                isActive: true
                onClicked: {
                    pageLoader.active = false
                    pageLoader.source = "MainPage.qml"
                    pageLoader.active = true
                    setActiveButton(mainButton)
                }
            }

            HoverButton {
                id: settingsButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Настройки")
                onClicked: {
                    pageLoader.active = false
                    pageLoader.source = "SettingsPage.qml"
                    pageLoader.active = true
                    setActiveButton(settingsButton)
                }
            }
            HoverButton {
                id: parametersButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Параметры")
                onClicked: {
                    pageLoader.active = false
                    pageLoader.source = "ParametersPage.qml"
                    pageLoader.active = true
                    setActiveButton(parametersButton)
                }
            }
            HoverButton {
                id: aboutButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Об Авторе")
                onClicked: {
                    pageLoader.active = false
                    pageLoader.source = "AboutAppPage.qml"
                    pageLoader.active = true
                    setActiveButton(aboutButton)
                }
            }
        }

        Image {
            id: bottomLeftImage
            source: "assets/images/git_last.png"
            width: 35
            height: 35
            anchors.left: parent.left
            anchors.leftMargin: 37
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    Qt.openUrlExternally("https://github.com/iUnreallx")
                }
            }
        }


        Text {
               id: label_github
               text: "GitHub"
               font.pixelSize: 26
               font.bold: true
               color: "gray"
               anchors.right: parent.right
               anchors.bottom: parent.bottom
               anchors.bottomMargin: 25
               anchors.rightMargin: 35
               MouseArea {
                   anchors.fill: parent
                   cursorShape: Qt.PointingHandCursor
                   onClicked: { Qt.openUrlExternally("https://github.com/iUnreallx")
                   }
               }
           }
    }

    Loader {
            id: pageLoader
            anchors.fill: parent
            source: "MainPage.qml"
            z: -1

            onLoaded: {
                   if (pageLoader.item && pageLoader.item.hasOwnProperty("quantaText")) {
                       pageLoader.item.quantaText = main_window.quantaTextGlobal
                        pageLoader.item.cleanedText = cleanFuncGlobal
                   }
               }
        }



    function setActiveButton(button) {
        mainButton.isActive = false;
        settingsButton.isActive = false;
        parametersButton.isActive = false;
        aboutButton.isActive = false;

        button.isActive = true;

        if (button === mainButton) {
            main_window.minimumHeight = 400
            main_window.minimumWidth = 500
            if (main_window.width === 695)
            {
                main_window.width = 500
            }

        } else {
            main_window.minimumHeight = 400
            main_window.minimumWidth = 695
        }
    }
}



