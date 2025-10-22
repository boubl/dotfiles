import Quickshell.Wayland
import Quickshell.Io
import Quickshell
import QtQuick

Scope {
    id: root
    IdleMonitor {
        id: idle
        timeout: 5
        onIsIdleChanged: {
            console.log("Idle changed");
            if (isIdle) {
                console.log("Locking...");
                lock.startDetached();
            }
        }
    }
    Process {
        id: lock
        command: ["loginctl", "lock-session"]
    }
}
