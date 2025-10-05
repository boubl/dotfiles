import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import Quickshell.Wayland
import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Effects
import QtQuick.Layouts

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

                Item {
                    id: sine
                    width: 25
                    height: 25

                    anchors.verticalCenter: parent.verticalCenter

                    property real volume: VolumeTracker.volume
                    property real muted: VolumeTracker.muted

                    Canvas {
                        id: canvas
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);
                            ctx.lineWidth = 3;
                            ctx.lineCap = "round";

                            var radius = Math.min(width, height) / 2 - ctx.lineWidth;
                            var start = -Math.PI / 2;
                            var end = (2 * Math.PI) * sine.volume + start + 0.01;
                            var spacing = 0.5;

                            if (sine.volume < 0.89) {
                                ctx.strokeStyle = "#565f89";
                                ctx.beginPath();
                                ctx.arc(width / 2, height / 2, radius, start - spacing, end + spacing, true);
                                ctx.stroke();
                            }

                            var color = sine.muted ? "#565f89" : "#c0caf5";
                            ctx.strokeStyle = color;
                            ctx.beginPath();
                            ctx.arc(width / 2, height / 2, radius, start, end);
                            ctx.stroke();

                            ctx.fillStyle = "#c0caf5";
                            ctx.font = "10pt Giphurs";
                            ctx.textAlign = "center";
                            ctx.textBaseline = "middle";
                            var text = sine.muted ? "󰝟" : "󰕾";
                            ctx.fillText(text, width / 2 - 0.7, height / 2 + 1.7);
                        }
                    }
                    onVolumeChanged: canvas.requestPaint()
                    onMutedChanged: canvas.requestPaint()
                }
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
