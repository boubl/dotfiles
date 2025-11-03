import Quickshell
import Quickshell.Wayland
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
            exclusiveZone: 30

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            IdleInhibitor {
                enabled: ShellContext.caffeinated
                window: root
            }

            CCWindow {
                anchor.window: root
                active: ShellContext.isControlCenterOpen
            }

            Rectangle {
                anchors.fill: parent
                color: Matugen.system.surface
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

                        Item {
                            anchors.verticalCenter: parent.verticalCenter
                            implicitWidth: 20
                            implicitHeight: 20
                            IconImage {
                                id: trayImage
                                anchors.fill: parent
                                anchors.verticalCenter: parent.verticalCenter
                                source: modelData.icon
                                asynchronous: true
                            }
                            MouseArea {
                                anchors.fill: trayImage
                                acceptedButtons: Qt.AllButtons
                                onClicked: e => {
                                    switch (e.button) {
                                    case Qt.LeftButton:
                                        modelData.activate();
                                        break;
                                    case Qt.MiddleButton:
                                        modelData.secondaryActivate();
                                        break;
                                    case Qt.RightButton:
                                        if (modelData.hasMenu) {
                                            var coords = this.mapToGlobal(mouseX, mouseY);
                                            modelData.display(root, coords.x, coords.y);
                                        }
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    VolumeWidget {}

                    BatteryWidget {
                        anchors.verticalCenter: parent.verticalCenter
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
