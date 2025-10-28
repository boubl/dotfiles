pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property bool isControlCenterOpen: false
    property bool dndMode: false
    property bool darkMode: true

    Process {
        id: darkmanSet
        command: ["darkman", "set", "dark"]
    }
    Process {
        id: darkmanGet
        running: true
        command: ["darkman", "get"]
        stdout: StdioCollector {
            onStreamFinished: root.darkMode = this.text == "dark\n"
        }
    }
    onDarkModeChanged: {
        darkmanSet.command[2] = root.darkMode ? "dark" : "light"
        darkmanSet.startDetached();
    }
}
