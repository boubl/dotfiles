import Quickshell
import Quickshell.Services.UPower
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            Row {
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }
                spacing: 5
                layoutDirection: Qt.RightToLeft

                ClockWidget {
                    font.family: "MapleMono"
                    font.pointSize: 14
                }
                Text {
                    font.family: "MapleMono"
                    font.pointSize: 14
                    text: "-"
                }
                Rectangle {
                    color: "#00AAAA"
                    radius: 10
                    Row {
                        anchors {
                            centerIn: parent
                        }
                        spacing: 10
                        MaterialIcon {
                            text: "battery_android_0"
                        }
                        Text {
                            font.family: "MapleMono"
                            font.pointSize: 14
                            text: Math.round(UPower.displayDevice.percentage * 100).toString() + "%"
                        }
                    }
                    width: childrenRect.width + 10
                    height: childrenRect.height + 2
                }
            }
        }
    }
}
