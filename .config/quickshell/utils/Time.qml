pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm");
    }
    readonly property string timeWithSeconds: {
        Qt.formatDateTime(clock.date, "hh:mm:ss");
    }
    readonly property string date: {
        Qt.formatDateTime(clock.date, "ddd d MMM");
    }
    readonly property string dateLong: {
        Qt.formatDateTime(clock.date, "dddd d MMMM yyyy");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
