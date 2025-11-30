pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.utils
import qs.utils.debug
import qs.services.matugen
import qs.services.volume
import qs.services

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
    implicitWidth: 350//grid.implicitWidth + grid.Layout.margins * 2
    implicitHeight: grid.implicitHeight + grid.Layout.margins * 2

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

            CCSwitch {
                Layout.fillWidth: true
                Layout.columnSpan: 3
                icon: Lucide.moon
                text: "Do not disturb"
                checked: ShellContext.dndMode
                onClicked: checked => ShellContext.dndMode = checked
            }
            CCButton {
                Layout.fillWidth: true
                icon: Lucide.lock
                Process {
                    id: lockCommand
                    command: ["loginctl", "lock-session"]
                }
                onClicked: lockCommand.startDetached()
            }
            CCButton {
                Layout.fillWidth: true
                icon: Lucide.rotate_ccw
                Process {
                    id: restartCommand
                    command: ["reboot"]
                }
                onClicked: restartCommand.startDetached()
            }
            CCButton {
                Layout.fillWidth: true
                icon: Lucide.power
                Process {
                    id: poweroffCommand
                    command: ["poweroff"]
                }
                onClicked: poweroffCommand.startDetached()
            }
            CCSwitch {
                Layout.fillWidth: true
                Layout.columnSpan: 3
                icon: Lucide.sun_moon
                text: "Dark mode"
                checked: ShellContext.darkMode
                onClicked: checked => ShellContext.darkMode = checked
            }
            CCSwitch {
                Layout.fillWidth: true
                Layout.columnSpan: 3
                icon: Lucide.coffee
                text: "Keep me awake"
                checked: ShellContext.caffeinated
                onClicked: checked => ShellContext.caffeinated = checked
            }
            CCSlider {
                Layout.fillWidth: true
                Layout.columnSpan: 3
                icon: VolumeTracker.muted ? Lucide.volume_x : Lucide.volume_2
                value: VolumeTracker.volume
                disabled: VolumeTracker.muted
            }
            CCSlider {
                Layout.fillWidth: true
                Layout.columnSpan: 3
                icon: Lucide.sun
                value: Brightness.natural
            }
            CCSlider {
                Layout.fillWidth: true
                Layout.columnSpan: 3
                icon: Lucide.battery
                value: UPower.displayDevice.percentage
            }
            CCButton {
                Layout.fillWidth: true
                icon: Lucide.wallpaper
                onClicked: ShellContext.wallpaper = true
            }
            CCButton {
                Layout.fillWidth: true
                icon: Lucide.refrigerator
                onClicked: Matugen.updateColors()
            }
            CCPlayer {
                Layout.fillWidth: true
                Layout.columnSpan: 6
            }
        }
    }
}
