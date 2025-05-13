cmake_minimum_required(VERSION 3.16)

project(QuantaCleaner VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Concurrent Core ShaderTools)

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
        Qml/HoverButton.qml
        Qml/Main.qml
        Qml/MainPage.qml
        Qml/ParametersPage.qml
        Qml/SettingsPage.qml

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
        Qml/assets/fonts/ScadaBold.ttf
        Qml/assets/fonts/ScadaBoldItalic.ttf
        Qml/assets/fonts/ScadaItalic.ttf
        Qml/assets/fonts/ScadaRegular.ttf
        Qml/assets/fonts/Ubuntu-Bold.ttf
        Qml/assets/fonts/Ubuntu-Medium.ttf
        Qml/assets/fonts/Ubuntu-Regular.ttf
        Qml/assets/icons/my_ico.png
        Qml/assets/icons/myapp.ico
        Qml/assets/images/bug_black.png
        Qml/assets/images/bug_white.png
        Qml/assets/images/cpu_black.png
        Qml/assets/images/cpu_white.png
        Qml/assets/images/exchange_black.png
        Qml/assets/images/exchange_white.png
        Qml/assets/images/fire_black.png
        Qml/assets/images/fire_white.png
        Qml/assets/images/git_last.png
        Qml/assets/images/lang_black.png
        Qml/assets/images/lang_white.png
        Qml/assets/images/moon_black.png
        Qml/assets/images/moon_white.png
        Qml/assets/images/par_black.png
        Qml/assets/images/par_black2.png
        Qml/assets/images/par_white.png
        Qml/assets/images/star_white.png
        Qml/assets/images/star_black.png
        Qml/assets/images/circle.png
        Qml/assets/images/clipboard_black.png
        Qml/assets/images/clipboard_white.png
        Qml/assets/images/browser_black.png
        Qml/assets/images/browser_white.png
        Qml/assets/images/parametrs/chevron.png
        Qml/assets/images/parametrs/cross.png
        Qml/assets/images/parametrs/eye.png
        Qml/assets/images/parametrs/geer.png
        Qml/assets/images/parametrs/rocket.png
        Qml/assets/images/parametrs/sign.png
        Qml/assets/images/parametrs/trash.png
        Qml/assets/images/parametrs/notes_black.png
        Qml/assets/images/parametrs/notes_white.png
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appQuantaCleaner PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appQuanta
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQuantaCleaner
    PRIVATE Qt6::Quick Qt6::Concurrent Qt6::Core Qt6::ShaderTools
)

include(GNUInstallDirs)
install(TARGETS appQuantaCleaner
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
