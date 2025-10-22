import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.utils

PopupWindow {
    id: root

    property int cellWidth: 50
    property int cellHeight: 50
    required property bool active
    visible: rectRoot.opacity > 0

    anchor {
        rect.x: parentWindow.width - 10
        rect.y: parentWindow.height + 10
        gravity: Edges.Bottom | Edges.Left
    }
    implicitWidth: cellWidth * grid.columns + (grid.columns - 1) * grid.columnSpacing + 2 * grid.anchors.margins
    implicitHeight: grid.implicitHeight + 2 * grid.anchors.margins
    color: "transparent"

    Rectangle {
        id: rectRoot
        anchors.fill: parent
        color: Colors.dark_medium.bg0
        border {
            color: Colors.dark_medium.grey1
            width: 1
        }
        radius: 20
        opacity: root.active

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutExpo
            }
        }

        GridLayout {
            id: grid
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
            }
            columns: 6
            columnSpacing: 5
            uniformCellWidths: false
            uniformCellHeights: false

            CCSwitch {
                Layout.columnSpan: 3
                Layout.rowSpan: 1
                Layout.preferredWidth: Layout.columnSpan * root.cellWidth + (Layout.columnSpan - 1) * grid.columnSpacing
                Layout.preferredHeight: root.cellHeight
                icon: ""
                text: "Do not disturb"
                checked: ShellContext.dndMode
                onClicked: ShellContext.dndMode = checked
            }
            CCButton {
                Layout.columnSpan: 1
                Layout.preferredWidth: Layout.columnSpan * root.cellWidth + (Layout.columnSpan - 1) * grid.columnSpacing
                Layout.preferredHeight: root.cellHeight
                icon: ""

                Process {
                    id: lockCommand
                    command: ["loginctl", "lock-session"]
                }

                onClicked: lockCommand.startDetached()
            }
            CCButton {
                Layout.columnSpan: 1
                Layout.preferredWidth: Layout.columnSpan * root.cellWidth + (Layout.columnSpan - 1) * grid.columnSpacing
                Layout.preferredHeight: root.cellHeight
                icon: ""

                Process {
                    id: restartCommand
                    command: ["reboot"]
                }

                onClicked: restartCommand.startDetached()
            }
            CCButton {
                Layout.columnSpan: 1
                Layout.preferredWidth: Layout.columnSpan * root.cellWidth + (Layout.columnSpan - 1) * grid.columnSpacing
                Layout.preferredHeight: root.cellHeight
                icon: ""

                Process {
                    id: poweroffCommand
                    command: ["poweroff"]
                }

                onClicked: poweroffCommand.startDetached()
            }
            CCPlayer {
                Layout.columnSpan: 6
                Layout.rowSpan: 3
                implicitHeight: 50 * 3 + parent.rowSpacing
            }
        }
    }
}
