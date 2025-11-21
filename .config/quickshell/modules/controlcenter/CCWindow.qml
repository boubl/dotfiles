pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.utils
import qs.services.matugen
import qs.services.volume

PanelWindow {
    id: root

    required property bool active
    visible: rectRoot.opacity > 0

    margins {
        top: 5
        right: 5
    }
    anchors {
        top: true
        right: true
    }
    color: "transparent"
    implicitWidth: grid.width + grid.Layout.margins * 2
    implicitHeight: grid.height + grid.Layout.margins * 2

    Rectangle {
        id: rectRoot
        anchors.fill: parent
        color: Matugen.system.surface
        radius: 4
        opacity: root.active

        border {
            pixelAligned: false
            color: Matugen.system.outline_variant
        }
    }
    ColumnLayout {
        anchors.fill: parent
        GridLayout {
            id: grid
            Layout.margins: 8
            columns: 6
            columnSpacing: 5
            uniformCellWidths: true
            uniformCellHeights: false

            CCSwitch {
                Layout.columnSpan: 3
                icon: Lucide.moon
                text: "Do not disturb"
                checked: ShellContext.dndMode
                onClicked: checked => ShellContext.dndMode = checked
            }
            CCButton {
                icon: Lucide.lock
                Process {
                    id: lockCommand
                    command: ["loginctl", "lock-session"]
                }
                onClicked: lockCommand.startDetached()
            }
            CCButton {
                icon: Lucide.rotate_ccw
                Process {
                    id: restartCommand
                    command: ["reboot"]
                }
                onClicked: restartCommand.startDetached()
            }
            CCButton {
                icon: Lucide.power
                Process {
                    id: poweroffCommand
                    command: ["poweroff"]
                }
                onClicked: poweroffCommand.startDetached()
            }
            CCSwitch {
                Layout.columnSpan: 3
                icon: Lucide.sun_moon
                text: "Dark mode"
                checked: ShellContext.darkMode
                onClicked: checked => ShellContext.darkMode = checked
            }
            CCSwitch {
                Layout.columnSpan: 3
                icon: Lucide.coffee
                text: "Keep me awake"
                checked: ShellContext.caffeinated
                onClicked: checked => ShellContext.caffeinated = checked
            }
            CCSlider {
                Layout.columnSpan: 3
                icon: VolumeTracker.muted ? Lucide.volume_x : Lucide.volume_2
                value: VolumeTracker.volume
                disabled: VolumeTracker.muted
            }
            CCSlider {
                Layout.columnSpan: 3
                icon: Lucide.sun
                value: VolumeTracker.volume
            }
            CCButton {
                icon: Lucide.wallpaper
                onClicked: ShellContext.wallpaper = true
            }
            CCButton {
                icon: Lucide.refrigerator
                onClicked: Matugen.updateColors()
            }
            CCPlayer {
                Layout.columnSpan: 6
            }
        }
    }
}
