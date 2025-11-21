import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Fusion
import Quickshell

import qs.services.matugen
import qs.utils
import qs.utils.debug
import qs.modules.bar
import qs.modules.controlcenter

Item {
    id: root

    required property LockContext context

    property string user: Quickshell.env("USER")

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: Matugen.backgroundImage
    }
    MultiEffect {
        source: background
        anchors.fill: background
        blurEnabled: true
        blurMax: 60
        blur: 1
        autoPaddingEnabled: false
    }

    Item {
        anchors {
            top: root.top
            left: root.left
            right: root.right
        }

        implicitHeight: 30

        BatteryWidget {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 5
        }
    }

    // Button {
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     text: "It's not working, LET ME OUT!!!"
    //     onClicked: root.context.unlocked()
    // }

    ColumnLayout {
        anchors.fill: parent
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.topMargin: 30
            spacing: 15
            StylizedText {
                Layout.alignment: Qt.AlignHCenter
                text: Time.date
                font.pointSize: 30
                font.bold: true
            }
            StylizedText {
                id: timeText
                Layout.alignment: Qt.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.preferredHeight: metrics.tightBoundingRect.height
                text: Time.time
                font.pointSize: 120
                font.bold: true
                TextMetrics {
                    id: metrics
                    font: timeText.font
                    text: timeText.text
                }
            }
            CCPlayer {
                Layout.topMargin: 30
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 400
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: 40
            spacing: 2
            Label {
                // visible: root.context.showFailure
                Layout.alignment: Qt.AlignHCenter
                text: root.context.showFailure ? "Please try again" : `Welcome ${root.user}`
                font.family: "Host Grotesk"
                font.pointSize: 12
                color: !root.context.showFailure ? Matugen.system.on_background : Matugen.system.error
            }
            Rectangle {
                id: inputRect

                Layout.alignment: Qt.AlignHCenter
                color: Matugen.system.surface_container
                implicitWidth: 160
                implicitHeight: 30
                radius: 4
                clip: true

                border {
                    color: Matugen.system.outline_variant
                    width: 1
                }

                TextInput {
                    id: passwordInput

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: width > parent.width ? -width / 2 + parent.width / 2 : 0
                    clip: true
                    padding: parent.radius / 2
                    width: Math.min(contentWidth + padding * 2, parent.width - parent.border.width * 2)

                    font.family: "Host Grotesk"
                    // font.pointSize: 12
                    font.pointSize: 10
                    color: Matugen.system.on_surface

                    echoMode: TextInput.Password
                    focus: true
                    enabled: !root.context.unlockInProgress

                    onTextChanged: {
                        root.context.currentText = passwordInput.text;
                    }
                    onAccepted: root.context.tryUnlock()
                    Keys.onEscapePressed: {
                        passwordInput.text = "";
                        passwordInput.displayedText = "";
                    }

                    // Update the text in the box to match the text in the context.
                    // This makes sure multiple monitors have the same text.
                    Connections {
                        target: root.context

                        function onCurrentTextChanged() {
                            passwordInput.text = root.context.currentText;
                        }
                    }
                }
            }
        }
    }
}
