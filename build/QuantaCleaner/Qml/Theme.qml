    // Theme.qml
    pragma Singleton
    import QtQuick 2.0

    QtObject {
        property var colors: [
            { // Индекс 0, соответствует теме 1 (светлая)
                background: "white",
                text: "black",
                buttonBackground: "#E0E0E0",
                buttonHover: "#C0C0C0"
            },
            { // Индекс 1, соответствует теме 2 (темная)
                background: "#241415",
                text: "white",
                buttonBackground: "#4B2022",
                buttonHover: "#60292C"
            }
        ]
    }
