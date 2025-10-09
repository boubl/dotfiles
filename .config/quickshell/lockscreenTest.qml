import QtQuick
import Quickshell

import qs.modules.lockscreen

ShellRoot {
    LockContext {
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
