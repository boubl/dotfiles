pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    readonly property real current: brightnessFile.text()
    readonly property real max: maxBrightness.text.split("\n")[0]
    readonly property real natural: Math.max(0, Math.pow(Brightness.current / Brightness.max, 1 / 4) - Math.pow(1 / Brightness.max, 1 / 4)) / (1 - Math.pow(1 / Brightness.max, 1 / 4))
    FileView {
        id: brightnessFile
        path: brightnessPath.text.split("\n")[0]
        watchChanges: true
        onFileChanged: reload()
    }
    Process {
        command: ["bash", "-c", "echo /sys/class/backlight/*/brightness"]
        running: true
        stdout: StdioCollector {
            id: brightnessPath
        }
    }
    Process {
        command: ["bash", "-c", "cat /sys/class/backlight/*/max_brightness"]
        running: true
        stdout: StdioCollector {
            id: maxBrightness
        }
    }
}
