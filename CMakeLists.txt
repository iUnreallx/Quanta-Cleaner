cmake_minimum_required(VERSION 3.16)

project(QuantaCleaner VERSION 1.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Concurrent Core)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appQuantaCleaner
    main.cpp
    app.rc
)

qt_add_qml_module(appQuantaCleaner
    URI QuantaCleaner
    VERSION 1.0

    QML_FILES
        Qml/AboutAppPage.qml
        Qml/BentoCard.qml
        Qml/CategorySheet.qml
        Qml/CtaButton.qml
        Qml/DockBar.qml
        Qml/DoneBadge.qml
        Qml/GlassCard.qml
        Qml/Ico.qml
        Qml/LogViewer.qml
        Qml/Main.qml
        Qml/MainPage.qml
        Qml/NotificationBanner.qml
        Qml/Odometer.qml
        Qml/ParametersPage.qml
        Qml/PillButton.qml
        Qml/PillToggle.qml
        Qml/QuantaLogo.qml
        Qml/RadialFill.qml
        Qml/Reveal.qml
        Qml/RingView.qml
        Qml/SegControl.qml
        Qml/SettingsPage.qml
        Qml/SwapText.qml
        Qml/TintImage.qml
        Qml/Txt.qml

    SOURCES
        main.cpp
        Src/Header/crashdump.h
        Src/Header/eventlog.h
        Src/Header/fontcache.h
        Src/Header/IsAdminChecked.h
        Src/Header/LogsViewer.h
        Src/Header/recyclebincleaner.h
        Src/Header/tempcleaner.h
        Src/Header/winsxscleaner.h
        Src/Header/wintempclean.h
        Src/Header/winupdatecache.h
        Src/Header/appcontroller.h
        Src/logs/loghelper.h
        Src/Header/point.h
        Src/Header/ClipboardHelper.h
        Src/Header/openFolder.h
        Src/logs/loghelper.cpp
        Src/Source/point.cpp
        Src/Source/crashdump.cpp
        Src/Source/eventlog.cpp
        Src/Source/fontcache.cpp
        Src/Source/IsAdminChecked.cpp
        Src/Source/LogsViewer.cpp
        Src/Source/recyclebincleaner.cpp
        Src/Source/tempcleaner.cpp
        Src/Source/winsxscleaner.cpp
        Src/Source/wintempclean.cpp
        Src/Source/winupdatecache.cpp
        Src/Source/appcontroller.cpp

    RESOURCES
        Qml/assets/ico/quanta.ico
        Qml/assets/fonts/Onest-Variable.ttf
        Qml/assets/fonts/JetBrainsMono-Medium.ttf
        Qml/assets/images/github_white.png
        Qml/assets/images/min/temp.png
        Qml/assets/images/min/winsxs.png
        Qml/assets/images/min/wintemp.png
        Qml/assets/images/min/font.png
        Qml/assets/images/min/bin.png
        Qml/assets/images/min/update.png
        Qml/assets/images/min/logs.png
        Qml/assets/images/min/dump.png
        Qml/assets/images/min/point.png
)


set_target_properties(appQuantaCleaner PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQuantaCleaner
    PRIVATE Qt6::Quick Qt6::Concurrent Qt6::Core
)

include(GNUInstallDirs)
install(TARGETS appQuantaCleaner
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
