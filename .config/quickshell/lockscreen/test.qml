import QtQuick
import Quickshell

ShellRoot {
    Context {
        id: lockContext
        onUnlocked: Qt.quit()
    }

    FloatingWindow {
        LockSurface {
            anchors.fill: parent
            context: lockContext
        }
    }

    // exit the example if the window closes
    Connections {
        target: Quickshell

        function onLastWindowClosed() {
            Qt.quit();
        }
    }
}
