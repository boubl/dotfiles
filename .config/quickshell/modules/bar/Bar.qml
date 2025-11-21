pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

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
                // anchor.window: root
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
                RowLayout {
                    spacing: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    height: parent.height

                    StylizedText {
                        text: Time.time
                    }
                    StylizedText {
                        text: Time.date
                    }

                    TagsView {
                        screen: root.screen.name
                    }
                }

                // Right
                RowLayout {
                    spacing: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    height: parent.height

                    Repeater {
                        model: SystemTray.items.values

                        Item {
                            id: sysTrayIconRoot
                            required property SystemTrayItem modelData
                            Layout.preferredWidth: 20
                            Layout.preferredHeight: 20
                            IconImage {
                                id: trayImage
                                anchors.fill: parent
                                anchors.verticalCenter: parent.verticalCenter
                                source: sysTrayIconRoot.modelData.icon
                                asynchronous: true
                            }
                            MouseArea {
                                anchors.fill: trayImage
                                acceptedButtons: Qt.AllButtons
                                onClicked: e => {
                                    switch (e.button) {
                                    case Qt.LeftButton:
                                        sysTrayIconRoot.modelData.activate();
                                        break;
                                    case Qt.MiddleButton:
                                        sysTrayIconRoot.modelData.secondaryActivate();
                                        break;
                                    case Qt.RightButton:
                                        if (sysTrayIconRoot.modelData.hasMenu) {
                                            var coords = this.mapToGlobal(mouseX, mouseY);
                                            sysTrayIconRoot.modelData.display(root, coords.x, coords.y);
                                        }
                                        break;
                                    }
                                }
                            }
                        }
                    }

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
                Rectangle {
                    anchors.centerIn: parent
                    height: childrenRect.height
                    width: childrenRect.width
                    radius: 4
                    color: "transparent"
                    border {
                        color: Matugen.system.outline_variant
                    }
                    RowLayout {
                        StylizedText {
                            id: titleText
                            color: Matugen.system.on_surface_variant
                            text: Bedload.focusedViewTitle
                            elide: Text.ElideMiddle
                            Layout.maximumWidth: root.width / 3
                            Layout.rightMargin: 10
                            Layout.leftMargin: 10
                            Layout.topMargin: 2
                            Layout.bottomMargin: 2
                        }
                    }
                }
            }
        }
    }
}
