import Quickshell
import Quickshell.Wayland

import qs.modules.bar
import qs.services.idle

Scope {
    Bar {
        id: bar
    }
    // Idle {}
    IdleInhibitor {
        enabled: ShellContext.caffeinated
        window: bar
    }
}
