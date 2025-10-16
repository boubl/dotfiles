import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Services.Mpris
import QtQuick

import qs.modules.controlcenter
import qs.utils.river
import qs.utils

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData
            screen: modelData
            exclusiveZone: 30

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 35

            CCWindow {
                anchor.window: root
                visible: ShellContext.isControlCenterOpen
            }

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#FF1a1b26"
                    }
                    GradientStop {
                        position: 0.8
                        color: "#B01a1b26"
                    }
                    GradientStop {
                        position: 1.0
                        color: "#001a1b26"
                    }
                }
            }

            Item {
                implicitWidth: parent.width
                implicitHeight: 30
                // Left
                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: 10

                    StylizedText {
                        text: Time.time
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    StylizedText {
                        text: Time.date
                        anchors.verticalCenter: parent.verticalCenter
                    }

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

                    BatteryWidget {
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                ShellContext.isControlCenterOpen = !ShellContext.isControlCenterOpen;
                            }
                        }
                    }
                }

                // Center
                Row {
                    anchors.centerIn: parent
                    StylizedText {
                        text: Bedload.focusedViewTitle
                    }
                }
            }
        }
    }
}
