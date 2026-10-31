import QtQuick
import QtQuick.Controls
import QtCore

ApplicationWindow {
    id: main_window
    title: "Quanta"
    visible: true
    width: 1040
    height: 700
    minimumWidth: 640
    minimumHeight: 600
    color: theme.bg
    flags: Qt.Window | Qt.FramelessWindowHint

    readonly property int catCount: 9
    readonly property var catIcons: ["temp", "winsxs", "wintemp", "font", "bin", "update", "logs", "dump", "point"]
    readonly property var logFiles: ["tempLog.txt", "WinSxSCleaner.txt", "winTempClean.txt", "fontCache.txt", "recycleLog.txt",
                                     "updateWinLog.txt", "eventLog.txt", "crashDump.txt", "PointCleaner.txt"]
    readonly property var catNames: [str.cTemp, str.cWinSxS, str.cWinTemp, str.cFont, str.cBin, str.cUpdate, str.cEvent, str.cDump, str.cPoint]
    readonly property var catInfo: [str.iTemp, str.iWinSxS, str.iWinTemp, str.iFont, str.iBin, str.iUpdate, str.iEvent, str.iDump, str.iPoint]
    readonly property var logDeleted: [str.lTemp, str.lWinSxS, str.lWinTemp, str.lFont, str.lBin, str.lUpdate, str.lEvent, str.lDump, str.lPoint]

    readonly property var accentDefs: [
        { c: "#3D8BFF", k: "#FFFFFF" }, { c: "#8B6CFF", k: "#FFFFFF" },
        { c: "#FF4F8B", k: "#FFFFFF" }, { c: "#FF5547", k: "#FFFFFF" },
        { c: "#FF9A0A", k: "#1B1000" }, { c: "#FFD60A", k: "#1B1500" },
        { c: "#2FD566", k: "#03200E" }, { c: "#12D6C0", k: "#021F1B" }
    ]
    readonly property var accentNames: [str.accBlue, str.accViolet, str.accPink, str.accRed, str.accOrange, str.accYellow, str.accGreen, str.accTeal]
    readonly property int accentIndex: Math.max(0, Math.min(accentDefs.length - 1, quanta_settings.settings_accent))

    property string pageTarget: "main"     // куда идём (подсветка дока, режим кольца)
    property string shownPage: "main"      // какая страница показана сейчас

    property var avail: [0, 0, 0, 0, 0, 0, 0, 0, 0]
    property var cleaned: [0, 0, 0, 0, 0, 0, 0, 0, 0]
    property var doneFlags: [false, false, false, false, false, false, false, false, false]
    property var runOn: [false, false, false, false, false, false, false, false, false]
    property var runWeights: [1, 1, 1, 1, 1, 1, 1, 1, 1]

    readonly property var catOn: [
        !quanta_settings.parametr_block1_active, !quanta_settings.parametr_block2_active, !quanta_settings.parametr_block3_active,
        !quanta_settings.parametr_block4_active, !quanta_settings.parametr_block5_active, !quanta_settings.parametr_block6_active,
        !quanta_settings.parametr_block7_active, !quanta_settings.parametr_block8_active, !quanta_settings.parametr_block9_active
    ]
    readonly property int activeCount: {
        var n = 0
        for (var i = 0; i < catOn.length; ++i)
            if (catOn[i])
                n++
        return n
    }
    readonly property double totalMb: {
        var t = 0
        for (var i = 0; i < catCount; ++i)
            if (catOn[i])
                t += avail[i]
        return t
    }
    readonly property double sumAll: {
        var t = 0
        for (var i = 0; i < catCount; ++i)
            t += avail[i]
        return t
    }
    readonly property double maxMb: {
        var m = 0.001
        for (var i = 0; i < catCount; ++i)
            m = Math.max(m, avail[i])
        return m
    }
    readonly property var weights: computeWeights(avail)
    readonly property var bands: computeBands(weights, catOn)

    property string phase: "idle"          // idle | run | done
    property real prog: 0
    property int taskCompleted: 0
    property int globalFunctions: 0
    property real cleanElapsed: 0
    property real cleanSeconds: 0
    property double startTotal: 0
    property double freedLast: 0
    property bool finVisible: false
    readonly property real minDuration: 6.2
    property double lastRefresh: 0

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
        property int settings_accent: 0
        property double stat_freed: 0
        property int stat_runs: 0
    }

    QtObject {
        id: theme
        readonly property bool dark: quanta_settings.settings_theme === 2
        readonly property string fontFamily: fontOnest.status === FontLoader.Ready ? fontOnest.name : "Segoe UI"
        readonly property string monoFamily: fontMono.status === FontLoader.Ready ? fontMono.name : "Consolas"

        property color acc: main_window.accentDefs[main_window.accentIndex].c
        property color ink: main_window.accentDefs[main_window.accentIndex].k
        property color bg: dark ? "#08080b" : "#f4f4f7"
        property color surface: dark ? "#131318" : "#ffffff"
        property color raise: dark ? "#1b1b21" : "#ececf1"
        property color card: dark ? Qt.rgba(0.075, 0.075, 0.094, 0.86) : Qt.rgba(1, 1, 1, 0.82)
        property color line: dark ? Qt.rgba(1, 1, 1, 0.07) : Qt.rgba(0, 0, 0, 0.08)
        property color line2: dark ? Qt.rgba(1, 1, 1, 0.13) : Qt.rgba(0, 0, 0, 0.14)
        property color txt: dark ? "#fafafc" : "#0b0b0e"
        property color txt2: dark ? Qt.rgba(0.98, 0.98, 0.99, 0.6) : Qt.rgba(0.043, 0.043, 0.055, 0.6)
        property color txt3: dark ? Qt.rgba(0.98, 0.98, 0.99, 0.34) : Qt.rgba(0.043, 0.043, 0.055, 0.36)
        property color dot: dark ? "#e9e9f0" : "#2a2a30"

        Behavior on acc { ColorAnimation { duration: quanta_settings.settings_animation ? 800 : 0; easing.type: Easing.OutCubic } }
        Behavior on ink { ColorAnimation { duration: quanta_settings.settings_animation ? 500 : 0 } }
        Behavior on bg { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on surface { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on raise { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on card { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on line { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on line2 { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on txt { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on txt2 { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on txt3 { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
        Behavior on dot { ColorAnimation { duration: quanta_settings.settings_animation ? 450 : 0 } }
    }

    FontLoader { id: fontOnest; source: "assets/fonts/Onest-Variable.ttf" }
    FontLoader { id: fontMono; source: "assets/fonts/JetBrainsMono-Medium.ttf" }

    QtObject {
        id: str

        readonly property string navOverview: qsTr("Overview")
        readonly property string navClean: qsTr("What to clean")
        readonly property string navSettings: qsTr("Settings")
        readonly property string navAbout: qsTr("About app")

        readonly property string canBeCleaned: qsTr("Can be cleaned")
        readonly property string clean: qsTr("Clean")
        readonly property string cleaning: qsTr("Cleaning")
        readonly property string allClean: qsTr("All clean")
        readonly property string hintOn: qsTr("Click to enable")
        readonly property string hintOff: qsTr("Click to disable")
        readonly property string hintGo: qsTr("Click to clean")
        readonly property string categories: qsTr("categories")
        readonly property string done: qsTr("Cleaning complete")
        readonly property string freed: qsTr("Freed")
        readonly property string now: qsTr("now")
        readonly property string secShort: qsTr("s")
        readonly property string nothingSelected: qsTr("Nothing selected")

        readonly property string cTemp: qsTr("Temp files")
        readonly property string cWinSxS: qsTr("WinSxS")
        readonly property string cWinTemp: qsTr("Windows Temp")
        readonly property string cFont: qsTr("Font cache")
        readonly property string cBin: qsTr("Recycle Bin")
        readonly property string cUpdate: qsTr("Windows Update")
        readonly property string cEvent: qsTr("Event logs")
        readonly property string cDump: qsTr("Crash dumps")
        readonly property string cPoint: qsTr("Restore points")

        readonly property string iTemp: qsTr("InfoTemp")
        readonly property string iWinSxS: qsTr("InfoWinSxS")
        readonly property string iWinTemp: qsTr("InfoWinTemp")
        readonly property string iFont: qsTr("InfoFont")
        readonly property string iBin: qsTr("InfoBin")
        readonly property string iUpdate: qsTr("InfoUpdate")
        readonly property string iEvent: qsTr("InfoEvent")
        readonly property string iDump: qsTr("InfoDump")
        readonly property string iPoint: qsTr("InfoPoint")

        readonly property string pSub: qsTr("Pick the categories to clean")
        readonly property string toClean: qsTr("To clean")
        readonly property string spotClean: qsTr("Spot clean")
        readonly property string openLog: qsTr("Open log")
        readonly property string clearLog: qsTr("Clear log")
        readonly property string includeIt: qsTr("Include in cleaning")
        readonly property string logEmpty: qsTr("Log is empty")
        readonly property string logsTitle: qsTr("Logs")
        readonly property string openLogsFolder: qsTr("Open logs folder")
        readonly property string deleteAllLogs: qsTr("Delete all logs")
        readonly property string deleteSuccess: qsTr("DeleteSucess")
        readonly property string lTemp: qsTr("TempLogDelete")
        readonly property string lWinSxS: qsTr("WinSxSLogDelete")
        readonly property string lWinTemp: qsTr("WinTempLogDelete")
        readonly property string lFont: qsTr("FontLogDelete")
        readonly property string lBin: qsTr("BinLogDelete")
        readonly property string lUpdate: qsTr("UpdateLogDelete")
        readonly property string lEvent: qsTr("EventLogDelete")
        readonly property string lDump: qsTr("DumpLogDelete")
        readonly property string lPoint: qsTr("PointLogDelete")

        readonly property string sSub: qsTr("Make Quanta yours")
        readonly property string accentColor: qsTr("Accent color")
        readonly property string accBlue: qsTr("Blue")
        readonly property string accViolet: qsTr("Violet")
        readonly property string accPink: qsTr("Pink")
        readonly property string accRed: qsTr("Red")
        readonly property string accOrange: qsTr("Orange")
        readonly property string accYellow: qsTr("Yellow")
        readonly property string accGreen: qsTr("Green")
        readonly property string accTeal: qsTr("Teal")
        readonly property string theme: qsTr("Theme")
        readonly property string dark: qsTr("Dark")
        readonly property string light: qsTr("Light")
        readonly property string behavior: qsTr("Behavior")
        readonly property string language: qsTr("Language")
        readonly property string animations: qsTr("Animations")
        readonly property string startup: qsTr("Launch at startup")
        readonly property string notifications: qsTr("Notifications")
        readonly property string debugMode: qsTr("Debug mode")
        readonly property string reportError: qsTr("Report an error")
        readonly property string copy: qsTr("Copy")
        readonly property string open: qsTr("Open")
        readonly property string copied: qsTr("Copied")

        readonly property string aboutShort: qsTr("Cleans temp files, caches and Windows junk in one click.")
        readonly property string mbFreed: qsTr("MB freed")
        readonly property string cleanups: qsTr("cleanups")
    }

    function computeWeights(a) {
        var mx = 0
        var i
        for (i = 0; i < a.length; ++i)
            mx = Math.max(mx, a[i])
        var floorW = Math.max(mx * 0.03, 0.5)
        var w = []
        for (i = 0; i < a.length; ++i)
            w.push(Math.max(a[i], floorW))
        return w
    }

    function computeBands(w, on) {
        var tot = 0
        var i
        for (i = 0; i < w.length; ++i)
            if (on[i])
                tot += w[i]
        var res = []
        var a = 0
        for (i = 0; i < w.length; ++i) {
            if (on[i] && tot > 0) {
                res.push([a / tot, (a + w[i]) / tot])
                a += w[i]
            } else {
                res.push(null)
            }
        }
        return res
    }

    function setAvail(i, v) {
        if (phase !== "idle")
            return
        var a = avail.slice()
        a[i] = isFinite(v) ? v : 0
        avail = a
    }

    function go(p) {
        if (p === pageTarget)
            return
        pageTarget = p
        shownPage = ""
        pageTimer.restart()
        if (p === "main" && Date.now() - lastRefresh > 20000)
            refreshSizes()
    }

    function chooseAccent(i, x, y) {
        if (i === accentIndex)
            return
        wipe.fire(x, y)
        quanta_settings.settings_accent = i
    }

    function setLanguage(lang) {
        app.setLanguage(lang)
        quanta_settings.settings_language = lang
    }

    function setOn(i, v) {
        if (phase !== "idle")
            return
        quanta_settings["parametr_block" + (i + 1) + "_active"] = !v
    }

    function toggleCat(i) {
        setOn(i, !catOn[i])
    }

    function openSheet(i) {
        catSheet.cat = i
        catSheet.open()
    }

    function openLog(i) {
        logViewer.cat = i
        logViewer.open()
    }

    function clearLog(i) {
        logsviewer.cleanLogPath(logFiles[i])
        logsviewer.loadLogs(logFiles[i])
        addNotification(logDeleted[i])
    }

    function addNotification(message) {
        var parts = String(message).split("\n")
        banner.present(parts[0], parts.slice(1).join("\n"), false, "", "", [])
    }

    function refreshSizes() {
        lastRefresh = Date.now()
        tmp.calculateTempRemovableSize()
        wintemp.calculateWinTempRemovableSize()
        fontQ.calculateFontCacheRemovableSize()
        binclear.calculateRecycleBinRemovableSize()
        updateQ.calculateUpdateCacheRemovableSize()
        eventQ.calculateEventLogRemovableSize()
        dmp.calculateCrashDumpRemovableSize()
        pointQ.calculateRestorePointRemovableSize()
    }

    function runCleaner(i, mode, notTap) {
        switch (i) {
        case 0: tmp.clearTempFolder(mode, notTap); break
        case 1: winsxs.cleanWinSXS(mode, notTap); break
        case 2: wintemp.cleanWinTemp(mode, notTap); break
        case 3: fontQ.fontCacheClean(mode, notTap); break
        case 4: binclear.cleanRecycleBin(mode, notTap); break
        case 5: updateQ.updateClean(mode, notTap); break
        case 6: eventQ.cleanEventLogs(mode, notTap); break
        case 7: dmp.cleanCrashDumps(mode, notTap); break
        case 8: pointQ.cleanRestorePoints(mode, notTap); break
        }
    }

    function spotClean(i) {
        if (phase !== "idle")
            return
        runCleaner(i, 2, true)
    }

    function startClean() {
        if (phase !== "idle")
            return
        if (activeCount === 0) {
            addNotification(str.nothingSelected)
            return
        }
        if (pageTarget !== "main")
            go("main")

        var n = activeCount
        var i
        var flags = []
        var df = []
        var cl = []
        for (i = 0; i < catCount; ++i) {
            flags.push(catOn[i])
            df.push(false)
            cl.push(0)
        }
        runOn = flags
        runWeights = weights.slice()
        doneFlags = df
        cleaned = cl
        taskCompleted = 0
        globalFunctions = n
        startTotal = totalMb
        freedLast = 0
        cleanElapsed = 0
        prog = 0
        finVisible = false
        phase = "run"

        var mode = quanta_settings.debugMode ? 2 : 0
        for (i = 0; i < catCount; ++i)
            if (flags[i])
                runCleaner(i, mode, false)
    }

    function taskDone(i, result) {
        if (phase !== "run" || doneFlags[i])
            return
        var v = Number(result)
        var c = cleaned.slice()
        c[i] = isFinite(v) ? v : 0
        cleaned = c
        var d = doneFlags.slice()
        d[i] = true
        doneFlags = d
        taskCompleted += 1
    }

    function stepClean(dt) {
        cleanElapsed += dt
        var tg = Math.min(1, cleanElapsed / minDuration)
        var eased = tg < 0.5 ? 4 * tg * tg * tg : 1 - Math.pow(-2 * tg + 2, 3) / 2
        var cap = 1
        for (var i = 0; i < catCount; ++i) {
            if (runOn[i] && !doneFlags[i] && bands[i]) {
                cap = bands[i][0] + (bands[i][1] - bands[i][0]) * 0.9
                break
            }
        }
        var want = Math.min(eased, cap)
        if (want > prog)
            prog = Math.min(want, prog + dt * 1.2)

        var allDone = taskCompleted >= globalFunctions
        if (allDone && tg >= 1 && prog >= 0.999) {
            finishClean()
        } else if (cleanElapsed > 120) {
            var d = doneFlags.slice()
            for (var j = 0; j < catCount; ++j)
                d[j] = true
            doneFlags = d
            taskCompleted = globalFunctions
        }
    }

    function finishClean() {
        prog = 1
        var freed = 0
        for (var i = 0; i < catCount; ++i)
            freed += cleaned[i]
        freedLast = freed
        cleanSeconds = cleanElapsed
        quanta_settings.stat_freed = quanta_settings.stat_freed + freed
        quanta_settings.stat_runs = quanta_settings.stat_runs + 1
        phase = "done"
        finVisible = true
        flashAnim.restart()
        finTimer.restart()
        notifyTimer.restart()
        resetTimer.restart()
    }

    function notifyDone() {
        if (!quanta_settings.settings_notify)
            return
        var sumC = 0
        var i
        for (i = 0; i < catCount; ++i)
            sumC += cleaned[i]
        var segs = []
        var n = 0
        for (i = 0; i < catCount; ++i) {
            if (!runOn[i])
                continue
            var g = sumC > 0 ? Math.max(cleaned[i], sumC * 0.02) : Math.max(runWeights[i], 0.1)
            segs.push({ g: g, o: Math.max(0.3, 1 - n * 0.1) })
            n++
        }
        banner.present(
            str.done,
            str.freed + " " + freedLast.toFixed(1) + " MB",
            true,
            n + " / " + catCount + " " + str.categories + " · " + cleanSeconds.toFixed(1) + " " + str.secShort,
            "−" + Math.round(freedLast) + " MB",
            segs)
    }

    Timer {
        id: pageTimer
        interval: 160
        onTriggered: main_window.shownPage = main_window.pageTarget
    }
    Timer {
        id: finTimer
        interval: 4300
        onTriggered: main_window.finVisible = false
    }
    Timer {
        id: notifyTimer
        interval: 900
        onTriggered: main_window.notifyDone()
    }
    Timer {
        id: resetTimer
        interval: 8200
        onTriggered: {
            var next = main_window.avail.slice()
            for (var i = 0; i < main_window.catCount; ++i)
                if (main_window.runOn[i])
                    next[i] = 0
            main_window.avail = next
            main_window.phase = "idle"
            main_window.prog = 0
            main_window.finVisible = false
            main_window.refreshSizes()
        }
    }
    Timer {
        id: refreshSoon
        interval: 800
        onTriggered: main_window.refreshSizes()
    }
    FrameAnimation {
        running: main_window.phase === "run"
        onTriggered: main_window.stepClean(frameTime)
    }

    RadialFill {
        anchors.fill: parent
        cx: 0.5
        cy: 0.46
        rx: 0.67
        ry: 0.78
        stops: [
            { p: 0, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.14) },
            { p: 1, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0) }
        ]
    }

    RadialFill {
        anchors.fill: parent
        z: 2
        cx: 0.5
        cy: 0.46
        rx: 0.85
        ry: 0.85
        opacity: main_window.phase === "run" ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 1200; easing.type: Easing.InOutCubic } }
        stops: [
            { p: 0, c: Qt.rgba(0, 0, 0, 0) },
            { p: 0.45, c: Qt.rgba(0, 0, 0, 0) },
            { p: 1, c: Qt.rgba(0, 0, 0, 0.5) }
        ]
    }

    RingView {
        id: ringView
        anchors.fill: parent
        z: 1
        mainMode: main_window.pageTarget === "main"
        animOn: quanta_settings.settings_animation
        phase: main_window.phase
        prog: main_window.prog
        weights: main_window.weights
        catOn: main_window.catOn
        bands: main_window.bands
        onCategoryClicked: function (idx) { main_window.toggleCat(idx) }
        onCenterClicked: main_window.startClean()
    }

    MainPage {
        z: 5
        ring: ringView
        shown: main_window.shownPage === "main"
    }
    ParametersPage {
        z: 5
        shown: main_window.shownPage === "params"
    }
    SettingsPage {
        z: 5
        shown: main_window.shownPage === "settings"
    }
    AboutAppPage {
        z: 5
        shown: main_window.shownPage === "about"
    }

    MouseArea {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 56
        z: 28
        onPressed: function (mouse) { main_window.startSystemMove() }
        onDoubleClicked: main_window.visibility === Window.Maximized ? main_window.showNormal() : main_window.showMaximized()
    }

    Row {
        id: winBtns
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 12
        anchors.rightMargin: 14
        spacing: 6
        z: 31

        Rectangle {
            width: 36; height: 30; radius: 15
            color: minMa.containsMouse ? theme.line2 : theme.line
            Rectangle { anchors.centerIn: parent; width: 12; height: 1.6; radius: 1; color: theme.txt }
            MouseArea { id: minMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: main_window.showMinimized() }
        }
        Rectangle {
            width: 36; height: 30; radius: 15
            color: clMa.containsMouse ? "#ff453a" : theme.line
            Ico { anchors.centerIn: parent; width: 14; height: 14; kind: "x"; color: clMa.containsMouse ? "#ffffff" : theme.txt }
            MouseArea { id: clMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: Qt.quit() }
        }
    }

    MouseArea {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 18; height: 18
        z: 31
        cursorShape: Qt.SizeFDiagCursor
        onPressed: main_window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
    }

    Row {
        x: 20
        y: 15
        spacing: 11
        z: 30

        QuantaLogo {
            width: 26
            height: 26
            tile: false
        }
        Txt {
            anchors.verticalCenter: parent.verticalCenter
            text: "Quanta"
            font.pixelSize: 15
            font.weight: Font.DemiBold
            font.letterSpacing: -0.3
        }
    }

    DockBar {
        z: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        current: main_window.pageTarget
        onGo: function (page) { main_window.go(page) }
    }

    RadialFill {
        id: flash
        anchors.fill: parent
        z: 70
        opacity: 0
        cx: 0.5
        cy: 0.46
        rx: 0.65
        ry: 0.65
        stops: [
            { p: 0, c: Qt.tint(theme.acc, Qt.rgba(1, 1, 1, 0.6)) },
            { p: 0.35, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0.3) },
            { p: 1, c: Qt.rgba(theme.acc.r, theme.acc.g, theme.acc.b, 0) }
        ]
    }
    NumberAnimation {
        id: flashAnim
        target: flash
        property: "opacity"
        from: 0.85
        to: 0
        duration: 1100
        easing.type: Easing.OutQuad
    }

    Rectangle {
        id: wipe
        z: 85
        property real px: 0
        property real py: 0
        property real d: 0
        property real maxD: 2000
        x: px - d / 2
        y: py - d / 2
        width: d
        height: d
        radius: d / 2
        color: theme.acc
        opacity: 0
        visible: opacity > 0.001

        function fire(x, y) {
            if (!quanta_settings.settings_animation)
                return
            px = x
            py = y
            maxD = Math.sqrt(main_window.width * main_window.width + main_window.height * main_window.height) * 2.2
            wipeAnim.restart()
        }

        ParallelAnimation {
            id: wipeAnim
            NumberAnimation { target: wipe; property: "d"; from: 0; to: wipe.maxD; duration: 1000; easing.type: Easing.OutQuart }
            NumberAnimation { target: wipe; property: "opacity"; from: 0.34; to: 0; duration: 1000; easing.type: Easing.OutQuad }
        }
    }

    NotificationBanner {
        id: banner
    }

    CategorySheet { id: catSheet }
    LogViewer { id: logViewer }

    Shortcut { sequence: "1"; onActivated: main_window.go("main") }
    Shortcut { sequence: "2"; onActivated: main_window.go("params") }
    Shortcut { sequence: "3"; onActivated: main_window.go("settings") }
    Shortcut { sequence: "4"; onActivated: main_window.go("about") }
    Shortcut { sequence: "Space"; onActivated: main_window.startClean() }
    Shortcut {
        sequence: "T"
        onActivated: quanta_settings.settings_theme = quanta_settings.settings_theme === 2 ? 1 : 2
    }

    Connections {
        target: tmp
        function onTempCleanResult(result) {
            main_window.addNotification(qsTr("ClearedTemporary") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onTempCleanResultTap(result) { main_window.taskDone(0, result) }
        function onSizeDelete(result) { main_window.setAvail(0, Number(result)) }
    }

    Connections {
        target: winsxs
        function onCleanupWinSXSPoint(result) {
            if (result === "notAdmin") {
                main_window.addNotification(qsTr("AdminWarning"))
                return
            }
            main_window.addNotification(qsTr("WinSXS") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onCleanupWinSXSPointTap(result) { main_window.taskDone(1, result) }
    }

    Connections {
        target: wintemp
        function onWinTempCleaned(result) {
            main_window.addNotification(qsTr("ClearedWinTemp") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onWinTempCleanedTap(result) { main_window.taskDone(2, result) }
        function onSizeDelete(result) { main_window.setAvail(2, Number(result)) }
    }

    Connections {
        target: fontQ
        function onFontCacheCleaned(result) {
            main_window.addNotification(qsTr("ClearedFontCache") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onFontCacheCleanedTap(result) { main_window.taskDone(3, result) }
        function onSizeDelete(result) { main_window.setAvail(3, Number(result)) }
    }

    Connections {
        target: binclear
        function onRecycleBinCleaned(result) {
            main_window.addNotification(qsTr("ClearedBin") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onRecycleBinCleanedTap(result) { main_window.taskDone(4, result) }
        function onSizeDelete(result) { main_window.setAvail(4, Number(result)) }
    }

    Connections {
        target: updateQ
        function onGetterClean(result) {
            main_window.addNotification(qsTr("ClearedUpdate") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onGetterCleanTap(result) { main_window.taskDone(5, result) }
        function onSizeDelete(result) { main_window.setAvail(5, Number(result)) }
    }

    Connections {
        target: eventQ
        function onEventLogsCleaned(result) {
            main_window.addNotification(qsTr("ClearedEvent") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onEventLogsCleanedTap(result) { main_window.taskDone(6, result) }
        function onSizeDelete(result) { main_window.setAvail(6, Number(result)) }
    }

    Connections {
        target: dmp
        function onCrashDumpsCleaned(result) {
            main_window.addNotification(qsTr("ClearedDump") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onCrashDumpsCleanedTap(result) { main_window.taskDone(7, result) }
        function onSizeDelete(result) { main_window.setAvail(7, Number(result)) }
    }

    Connections {
        target: pointQ
        function onRestorePointsCleaned(result) {
            main_window.addNotification(qsTr("ClearedPoint") + "\n" + Number(result) + " MB")
            refreshSoon.restart()
        }
        function onRestorePointsCleanedTap(result) { main_window.taskDone(8, result) }
        function onSizeDelete(result) { main_window.setAvail(8, Number(result)) }
    }

    Component.onCompleted: {
        x = Math.max(0, (Screen.desktopAvailableWidth - width) / 2)
        y = Math.max(0, (Screen.desktopAvailableHeight - height) / 2)
        refreshSizes()
    }
}
