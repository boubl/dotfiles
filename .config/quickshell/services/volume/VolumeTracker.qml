pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    readonly property double volume: Pipewire.defaultAudioSink?.audio.volume ?? 0
    readonly property double muted: Pipewire.defaultAudioSink?.audio.muted ?? true

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}
