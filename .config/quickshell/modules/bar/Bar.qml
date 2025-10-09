import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import qs.utils.river

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            color: "#1a1b26"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            // Left
            Row {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                spacing: 10

                ClockWidget {}

                TagsView {
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Right
            Row {
                spacing: 4
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 5

                Repeater {
                    model: SystemTray.items.values

                    IconImage {
                        anchors.verticalCenter: parent.verticalCenter
                        source: modelData.icon
                        implicitSize: 20
                    }
                }

                VolumeWidget {}
                // MaterialIcon {
                //     color: "#c0caf5"
                //     text: "wifi"
                // }
                BatteryWidget {}
            }

            // Center
            Row {
                anchors.centerIn: parent
                Text {
                    text: Bedload.focusedViewTitle
                    color: "#c0caf5"
                    font.family: "Giphurs"
                    font.pointSize: 14
                }
            }
        }
    }
}
