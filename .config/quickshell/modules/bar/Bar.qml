import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import qs.modules.controlcenter
import qs.services.river
import qs.services.matugen
import qs.utils

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData
            screen: modelData
            exclusiveZone: 20

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 60

            CCWindow {
                anchor.window: root
                active: ShellContext.isControlCenterOpen
            }

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: Qt.alpha(Colors.dark_medium.bg_dim, 0.8)
                    }
                    GradientStop {
                        position: root.exclusiveZone / root.implicitHeight
                        color: Qt.alpha(Colors.dark_medium.bg_dim, 0.4)
                    }
                    GradientStop {
                        position: 1.0
                        color: Qt.alpha(Colors.dark_medium.bg_dim, 0)
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
                        screen: root.screen.name
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
                        id: titleText
                        text: Bedload.focusedViewTitle
                    }
                }
            }
        }
    }
}
