import Quickshell
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            color: "#000000"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                // Left
                ClockWidget {
                    color: "#c0caf5"
                    font.family: "Google Sans Flex"
                    font.pointSize: 14
                    font.variableAxes: ({
                            GRAD: 0,
                            opsz: 18,
                            wght: 700,
                            ROND: 100
                        })
                }
            }
            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 5
                MaterialIcon {
                    color: "#c0caf5"
                    text: volume()

                    function volume(): string {
                        const vol = Math.round(VolumeTracker.volume * 100);
                        if (vol == 0)
                            return "volume_off";
                        else if (vol < (100.0 / 3))
                            return "volume_mute";
                        else if (vol < (200.0 / 3))
                            return "volume_down";
                        else
                            return "volume_up";
                    }
                }
                MaterialIcon {
                    color: "#c0caf5"
                    text: "wifi"
                }
                MaterialIcon {
                    color: "#c0caf5"
                    text: battery()
                    font.pointSize: 19

                    function battery(): string {
                        var step = Math.floor(UPower.displayDevice.percentage * 8);
                        var text = "battery_android_";
                        if (step >= 7) {
                            text += "full";
                        } else {
                            text += step.toString();
                        }
                        return text;
                    }
                }
            }

            RowLayout {
                anchors.centerIn: parent
                Text {
                    text: ToplevelManager.activeToplevel.appId
                    color: "#c0caf5"
                    font.family: "Google Sans Flex"
                    font.pointSize: 14
                    font.variableAxes: ({
                            GRAD: 0,
                            opsz: 18,
                            wght: 400,
                            ROND: 0
                        })
                }
            }
        }
    }
}
