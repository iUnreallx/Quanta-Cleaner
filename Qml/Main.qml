// Main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.LocalStorage 2.0
import QtCore

ApplicationWindow {
    id: main_window
    title: "Quanta"
    visible: true
    color: "black"
    width: 930
    height: 554
    minimumWidth: 500
    minimumHeight: 400
    font.family: cleanerFont.name
    Material.theme: Material.Dark

    // Properties
    property bool isOverlayVisible: false
    property bool tmphover_close: false
    property string currentPage: "MainPage.qml"
    property string last_symbol_of_functions: ""
    property string quantaTextGlobal: "Quanta"
    property string cleanFuncGlobal: ""
    property var clearedNotify: qsTr("ClearedNotify") + (app.languageVersion ? "" : "")
    property var cleanFree: qsTr("Cleared") + (app.languageVersion ? "" : "")
    property var waitTask: qsTr("WaitingTask") + (app.languageVersion ? "" : "")

    property int goResultDelete: 0
    property int taskCompleted: 0
    property int notificationCounter: 0
    property double tempSize: 0
    property double winSxsSize: 0
    property double binSize: 0
    property double updateSize: 0
    property double eventLog: 0
    property double crashdump: 0
    property double fontcache: 0
    property double wintemp_: 0
    property double pointclean: 0
    property double tempToDelete: 0
    property double winTempToDelete: 0
    property double fontCacheToDelete: 0
    property double binToDelete: 0
    property double updateToDelete: 0
    property double eventToDelete: 0
    property double dumpToDelete: 0
    property double pointToDelete: 0
    property bool first_start: true
    property var timerMap: ({})

    // Settings
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
        property bool settings_notify: true
        property int settings_theme: 2
        property var settings_language: "eng"
        property bool debugMode: false
        property bool running_clean: false
        property int global_functions: 0
        property bool cleanTextCome: false
        property bool radioMainMenuBlock: false
    }

    // Theme
    QtObject {
        id: theme
        property color background
        property color text
        property color button
        property color hover
        property color backOver
        property color backOverHover
        property color backOverRipple
        property color sidebar
        property color parametrsPageBackground
    }

    // Font Loaders
    FontLoader {
        id: cleanerFont
        source: "assets/fonts/Ubuntu-Bold.ttf"
    }

    FontLoader {
        id: cleanerFontRegular
        source: "assets/fonts/Ubuntu-Regular.ttf"
    }

    // Functions
    function applyTheme() {
        if (quanta_settings.settings_theme === 2) {
            theme.parametrsPageBackground = "#000"
            theme.background = "#241415"
            theme.text = "white"
            theme.button = "#4B2022"
            theme.hover = "#60292C"
            theme.backOver = "#000000"
            theme.backOverRipple = "#caeceb"
            theme.backOverHover = "#111111"
            theme.sidebar = "#111"
        } else {
            theme.parametrsPageBackground = "#FFFFFF"
            theme.background = "white"
            theme.text = "black"
            theme.button = "#E0E0E0"
            theme.hover = "#CCCCCC"
            theme.backOver = "#caeceb"
            theme.backOverRipple = "#000000"
            theme.backOverHover = "#CCCCCC"
            theme.sidebar = "#F0F0F0"
        }
    }

    function calculateAllDeleteCache() {
        if (goResultDelete === 8) {
            var result = tempToDelete + winTempToDelete + fontCacheToDelete + binToDelete +
                         updateToDelete + eventToDelete + dumpToDelete + pointToDelete
            var total = result.toFixed(2)
            if (pageLoader.item && pageLoader.item.hasOwnProperty("quantaText")) {
                pageLoader.item.deleteText = cleanFree + total + " МB."
            }
            goResultDelete = 0
            tempToDelete = 0
            winTempToDelete = 0
            fontCacheToDelete = 0
            binToDelete = 0
            updateToDelete = 0
            eventToDelete = 0
            dumpToDelete = 0
            pointToDelete = 0
        }
    }

    function clFuncText() {
        var blocks = getActiveBlockCount()
        cleanFuncGlobal = (taskCompleted > blocks) ? `${blocks} / ${blocks}` : `${taskCompleted} / ${blocks}`
        pageLoader.item.cleanedText = cleanFuncGlobal
    }

    function calculateAllCachesClean() {
        tmp.calculateTempRemovableSize()
        wintemp.calculateWinTempRemovableSize()
        fontQ.calculateFontCacheRemovableSize()
        binclear.calculateRecycleBinRemovableSize()
        updateQ.calculateUpdateCacheRemovableSize()
        eventQ.calculateEventLogRemovableSize()
        dmp.calculateCrashDumpRemovableSize()
        pointQ.calculateRestorePointRemovableSize()
    }

    function getActiveBlockCount() {
        let count = 0
        for (let i = 1; i <= 9; i++) {
            if (quanta_settings["parametr_block" + i + "_active"] === false) {
                count++
            }
        }
        return count
    }

    function updateTotalSize() {
        var total = (tempSize || 0) + (winSxsSize || 0) + (binSize || 0) + (updateSize || 0) +
                    (eventLog || 0) + (crashdump || 0) + (fontcache || 0) + (wintemp_ || 0) +
                    (pointclean || 0)
        if (pageLoader.item && pageLoader.item.hasOwnProperty("quantaText")) {
            pageLoader.item.cleanedText = cleanFuncGlobal
        }

        if (taskCompleted === quanta_settings.global_functions) {
            total = total.toFixed(1)
            var cleaned = total + " MB"
            quantaTextGlobal = cleaned
            addNotification(clearedNotify + " " + cleaned)
            if (pageLoader.item && pageLoader.item.hasOwnProperty("quantaText")) {
                pageLoader.item.quantaText = quantaTextGlobal
            }
            quanta_settings.running_clean = false
            calculateAllCachesClean()
            return cleaned
        }
        return quantaTextGlobal
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

    function addNotification(message) {
        if (notificationModel.count >= 3) {
            const oldId = notificationModel.get(0).id
            notificationModel.remove(0)
            if (timerMap[oldId]) {
                const oldTimer = timerMap[oldId]
                if (oldTimer && !oldTimer.destroyed) {
                    oldTimer.stop()
                    oldTimer.destroy()
                }
                delete timerMap[oldId]
            }
        }

        notificationCounter++
        const notifId = notificationCounter
        let side = (notificationModel.count > 0) ? notificationModel.get(0).side : quanta_settings.settings_notify
        notificationModel.append({ "message": message, "id": notifId, "side": side })

        const timer = Qt.createQmlObject(
            'import QtQuick 2.15; Timer { interval: 5000; running: true; repeat: false; }',
            main_window
        )

        timer.triggered.connect(() => {
            for (let i = 0; i < notificationsRepeater.count; i++) {
                const item = notificationsRepeater.itemAt(i)
                if (item && item.notifId === notifId) {
                    item.animateExitAndRemove()
                    break
                }
            }
            if (timer && !timer.destroyed) {
                timer.stop()
                timer.destroy()
            }
            delete timerMap[notifId]
        })

        timerMap[notifId] = timer
    }

    onGoResultDeleteChanged: calculateAllDeleteCache()
    onTaskCompletedChanged: {
        cleanFuncGlobal = `${taskCompleted} / ${quanta_settings.global_functions}`
        updateTotalSize()
    }

    Text {
        text: "text loader"
        font.family: cleanerFont.name
        visible: false
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
            hoverEnabled: true
            acceptedButtons: Qt.AllButtons
            propagateComposedEvents: false
            preventStealing: true
            onClicked: main_window.isOverlayVisible = false
        }
    }

    Rectangle {
        id: global_close_prm_logs
        width: 20
        height: 20
        color: "transparent"
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
            width: 25
            radius: 30
            color: tmphover_close ? "#471F1F" : "transparent"
            anchors.top: parent.top
            anchors.topMargin: 1
            anchors.left: parent.left
            anchors.leftMargin: -3
            z: 1
        }

        HoverHandler {
            onHoveredChanged: tmphover_close = hovered
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

    Rectangle {
        id: sidebar
        anchors.left: parent.left
        height: parent.height
        width: 215
        color: theme.sidebar

        Column {
            anchors.fill: parent
            topPadding: 20
            spacing: Math.min(14, Math.max(1, 0 + (height * 0.02)))

            HoverButton {
                id: mainButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Main") + (app.languageVersion ? "" : "")
                isActive: true
                onClicked: {
                    if (currentPage !== "MainPage.qml") {
                        currentPage = "MainPage.qml"
                        pageLoader.source = currentPage
                        setActiveButton(mainButton)
                    }
                }
            }

            HoverButton {
                id: settingsButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Settings") + (app.languageVersion ? "" : "")
                onClicked: {
                    if (currentPage !== "SettingsPage.qml") {
                        currentPage = "SettingsPage.qml"
                        pageLoader.source = currentPage
                        setActiveButton(settingsButton)
                    }
                }
            }

            HoverButton {
                id: parametersButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Parameters") + (app.languageVersion ? "" : "")
                onClicked: {
                    if (currentPage !== "ParametersPage.qml") {
                        currentPage = "ParametersPage.qml"
                        pageLoader.source = currentPage
                        setActiveButton(parametersButton)
                    }
                }
            }

            HoverButton {
                id: aboutButton
                height: 60
                width: 170
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("About") + (app.languageVersion ? "" : "")
                onClicked: {
                    if (currentPage !== "AboutAppPage.qml") {
                        currentPage = "AboutAppPage.qml"
                        pageLoader.source = currentPage
                        setActiveButton(aboutButton)
                    }
                }
            }
        }

        Image {
            id: bottomLeftImage
            source: quanta_settings.settings_theme === 2 ? "assets/images/git_last.png" : "assets/images/git_black.png"
            width: 45
            height: 45
            anchors.left: parent.left
            anchors.leftMargin: 35
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 18

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://github.com/iUnreallx")
            }
        }

        Text {
            id: label_github
            text: "GitHub"
            font.pixelSize: 26
            font.bold: true
            color: quanta_settings.settings_theme === 2 ? "gray" : "black"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 25
            anchors.rightMargin: 35

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://github.com/iUnreallx")
            }
        }
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        source: currentPage
        z: -1

        onLoaded: {
            if (pageLoader.item && pageLoader.item.hasOwnProperty("quantaText")) {
                pageLoader.item.quantaText = quantaTextGlobal
                pageLoader.item.cleanedText = cleanFuncGlobal
                pageLoader.item.cleanFunctions = (last_symbol_of_functions === ("Waiting for tasks...") ||
                                                 last_symbol_of_functions === ("Ожидание задач..."))
                                                ? waitTask
                                                : last_symbol_of_functions
                if (!first_start) {
                    calculateAllCachesClean()
                }
                clFuncText()
            }
        }
    }

    ListModel {
        id: notificationModel
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
            value: notificationModel.count > 0 ? (notificationModel.get(0).side ? main_window.width - notificationsPopup.width - 25 : 10) : 0
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
                    property int modelIndex: index

                    Rectangle {
                        id: notificationRect
                        width: parent.width
                        height: parent.height
                        radius: 15
                        color: "#32BC32"
                        x: model.side ? parent.width + 10 : -width
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
                            to: model.side ? parent.width + 10 : -parent.width
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
                            if (isExiting && modelIndex >= 0 && modelIndex < notificationModel.count) {
                                notificationModel.remove(modelIndex)
                            }
                        }
                    }

                    Component.onCompleted: enterAnimation.start()

                    function animateExitAndRemove() {
                        if (isExiting) return
                        isExiting = true
                        exitAnimation.start()
                    }
                }
            }
        }
    }

    // Connections clean functions
    Connections {
        target: tmp
        function onTempCleanResult(result) {
            addNotification(qsTr("ClearedTemporary") + "\n" + Number(result) + " МB")
        }
        function onTempCleanResultTap(result) {
            tempSize = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "tempcleaner.cpp"
            last_symbol_of_functions = "tempcleaner.cpp"
        }
        function onSizeDelete(result) {
            tempToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: winsxs
        function onCleanupWinSXSPoint(result) {
            if (result === "notAdmin") {
                addNotification(qsTr("AdminWarning"))
                return
            }
            addNotification(qsTr("WinSXS") + "\n" + Number(result) + " МB")
        }
        function onCleanupWinSXSPointTap(result) {
            winSxsSize = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "winsxscleaner.cpp"
            last_symbol_of_functions = "winsxscleaner.cpp"
        }
    }

    Connections {
        target: wintemp
        function onWinTempCleaned(result) {
            pageLoader.item.taskComplete += 1
            addNotification(qsTr("ClearedWinTemp") + "\n" + Number(result) + " МB")
        }
        function onWinTempCleanedTap(result) {
            wintemp_ = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "wintempclean.cpp"
            last_symbol_of_functions = "wintempclean.cpp"
        }
        function onSizeDelete(result) {
            winTempToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: fontQ
        function onFontCacheCleaned(result) {
            addNotification(qsTr("ClearedFontCache") + "\n" + Number(result) + " МB")
        }
        function onFontCacheCleanedTap(result) {
            fontcache = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "fontcacheclean.cpp"
            last_symbol_of_functions = "fontcacheclean.cpp"
        }
        function onSizeDelete(result) {
            fontCacheToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: binclear
        function onRecycleBinCleaned(result) {
            addNotification(qsTr("ClearedBin") + "\n" + Number(result) + " МB")
        }
        function onRecycleBinCleanedTap(result) {
            binSize = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "recyclebincleaner.cpp"
            last_symbol_of_functions = "recyclebincleaner.cpp"
        }
        function onSizeDelete(result) {
            binToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: updateQ
        function onGetterClean(result) {
            addNotification(qsTr("ClearedUpdate") + "\n" + Number(result) + " МB")
        }
        function onGetterCleanTap(result) {
            updateSize = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "winupdatecache.cpp"
            last_symbol_of_functions = "winupdatecache.cpp"
        }
        function onSizeDelete(result) {
            updateToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: eventQ
        function onEventLogsCleaned(result) {
            addNotification(qsTr("ClearedEvent") + "\n" + Number(result) + " МB")
        }
        function onEventLogsCleanedTap(result) {
            eventLog = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "eventlog.cpp"
            last_symbol_of_functions = "eventlog.cpp"
        }
        function onSizeDelete(result) {
            eventToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: dmp
        function onCrashDumpsCleaned(result) {
            addNotification(qsTr("ClearedDump") + "\n" + Number(result) + " МB")
        }
        function onCrashDumpsCleanedTap(result) {
            crashdump = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "crashdump.cpp"
            last_symbol_of_functions = "crashdump.cpp"
        }
        function onSizeDelete(result) {
            dumpToDelete = Number(result)
            goResultDelete += 1
        }
    }

    Connections {
        target: pointQ
        function onRestorePointsCleaned(result) {
            addNotification(qsTr("ClearedPoint") + "\n" + Number(result) + " МB")
        }
        function onRestorePointsCleanedTap(result) {
            pointclean = Number(result)
            taskCompleted += 1
            pageLoader.item.cleanFunctions = "pointclean.cpp"
            last_symbol_of_functions = "pointclean.cpp"
        }
        function onSizeDelete(result) {
            pointToDelete = Number(result)
            goResultDelete += 1
        }
    }

    // Initialization
    Component.onCompleted: {
        applyTheme()
        quanta_settings.cleanTextCome = false
        quanta_settings.running_clean = false
        quanta_settings.global_functions = 0
        cleanFuncGlobal = `${taskCompleted} / ${getActiveBlockCount()}`
        pageLoader.item.cleanedText = cleanFuncGlobal
        last_symbol_of_functions = waitTask
        pageLoader.item.cleanFunctions = last_symbol_of_functions
        calculateAllCachesClean()
        first_start = false
    }

    function setActiveButton(button) {
        mainButton.isActive = false
        settingsButton.isActive = false
        parametersButton.isActive = false
        aboutButton.isActive = false
        button.isActive = true

        if (button === mainButton) {
            minimumHeight = 400
            minimumWidth = 500
            if (width === 695) {
                width = 500
            }
        } else {
            minimumHeight = 400
            minimumWidth = 695
        }
    }
}
