//@ pragma UseQApplication

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import qs.modules.bar
import qs.services.notifications
import qs.utils

Scope {
    Bar {
        id: bar
    }
    WallpaperSelector {
        visible: ShellContext.wallpaper
    }

    property list<NotificationBanner> notifs: []

    NotificationServer {
        id: nserver
        imageSupported: true
        onNotification: notif => notif.tracked = true
    }

    PanelWindow {
        // Since the panel's screen is unset, it will be picked by the compositor
        // when the window is created. Most compositors pick the current active monitor.

        anchors.top: true
        margins.top: 20
        exclusiveZone: 0

        implicitWidth: col.childrenRect.width
        implicitHeight: col.childrenRect.height
        color: "transparent"

        ColumnLayout {
            id: col
            Repeater {
                model: nserver.trackedNotifications
                NotificationBanner {
                    id: banner
                    notif: modelData
                }
            }
        }
    }
}
