pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.controlcenter
import qs.services.volume
import qs.utils

Scope {
    id: root

    Connections {
        target: VolumeTracker

        function onMutedChanged() {
            root.shouldShowOsd = true && !ShellContext.isControlCenterOpen;
            hideTimer.restart();
        }
        function onVolumeChanged() {
            root.shouldShowOsd = true && !ShellContext.isControlCenterOpen;
            hideTimer.restart();
        }
    }

    property bool shouldShowOsd: false
    property bool actuallyShown: false

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    // The OSD window will be created and destroyed based on shouldShowOsd.
    // PanelWindow.visible could be set instead of using a loader, but using
    // a loader will reduce the memory overhead when the window isn't open.
    LazyLoader {
        active: root.shouldShowOsd || root.actuallyShown

        PanelWindow {
            id: windowRoot

            anchors.top: true
            anchors.right: true
            margins.top: 10
            margins.right: 10
            exclusiveZone: 0

            implicitWidth: 300
            implicitHeight: mainLayout.height
            color: "transparent"

            // An empty click mask prevents the window from blocking mouse events.
            mask: Region {}

            ColumnLayout {
                id: mainLayout
                width: parent.width
                opacity: 0
                layer.enabled: true
                layer.smooth: true

                CCSlider {
                    icon: VolumeTracker.muted ? Lucide.volume_x : Lucide.volume_2
                    value: VolumeTracker.volume
                    disabled: VolumeTracker.muted
                }
                SequentialAnimation on opacity {
                    id: opacityAnim
                    running: !root.shouldShowOsd || mainLayout.opacity != 1
                    ScriptAction {
                        script: root.actuallyShown = true
                    }
                    NumberAnimation {
                        to: 1
                        duration: 30
                    }
                    NumberAnimation {
                        to: 0
                        duration: 75
                    }
                    ScriptAction {
                        script: root.actuallyShown = false
                    }
                }
                Connections {
                    target: root

                    function onShouldShowOsdChanged() {
                        if (root.shouldShowOsd && mainLayout.opacity != 0) {
                            if (mainLayout.opacity == 1) // dirty workaround
                                mainLayout.opacity = 0.98;
                            opacityAnim.restart();
                        }
                    }
                }
            }
        }
    }
}
