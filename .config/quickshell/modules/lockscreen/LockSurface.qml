import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Controls.Fusion

import qs.modules.bar
import qs.utils

Item {
    id: root

    required property LockContext context

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "../../bg.png"
    }
    MultiEffect {
        source: background
        anchors.fill: background
        blurEnabled: true
        blurMax: 45
        blur: 1
        autoPaddingEnabled: false
    }

    // Button {
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     text: "It's not working, LET ME OUT!!!"
    //     onClicked: root.context.unlocked()
    // }

    Text {
        text: Time.time

        anchors.centerIn: parent

        font.family: "Bricolage Grotesque"
        font.pointSize: 92
        font.bold: true
        color: "#c0caf5"

        renderType: Text.CurveRendering
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        bottomPadding: 40
        spacing: 2
        Label {
            // visible: root.context.showFailure
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.context.showFailure ? "Incorrect password" : "Enter password"
            font.family: "Bricolage Grotesque"
            font.pointSize: 16
            color: root.context.showFailure ? "#ff9e64" : "#c0caf5"
        }
        Rectangle {
            id: inputRect

            color: "#1a1b26"
            implicitWidth: 160
            implicitHeight: 50
            radius: height * 0.3
            clip: true

            anchors.horizontalCenter: parent.horizontalCenter

            border {
                color: "#292e42"
                width: 4
            }

            TextInput {
                id: passwordInput

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: width > parent.width ? -width / 2 + parent.width / 2 : 0
                clip: true
                padding: parent.radius / 2
                width: Math.min(contentWidth + padding * 2, parent.width - parent.border.width * 2)

                font.family: "Bricolage Grotesque"
                font.pointSize: 16
                color: "#c0caf5"

                echoMode: TextInput.Password
                focus: true
                enabled: !root.context.unlockInProgress

                onTextChanged: root.context.currentText = this.text
                onAccepted: root.context.tryUnlock()
                Keys.onEscapePressed: this.text = ""

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
    // Button {
    //     text: "Unlock"
    //     focusPolicy: Qt.NoFocus
    //     enabled: !root.context.unlockInProgress && root.context.currentText !== ""
    //     onClicked: root.context.tryUnlock()
    // }
}
