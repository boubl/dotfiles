import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Fusion

Image {
    id: root
    required property Context context

    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
    source: "bg.png"

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "It's not working, LET ME OUT!!!"
        onClicked: root.context.unlocked()
    }

    Column {
        anchors.centerIn: parent
        Rectangle {
            id: inputRect
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            implicitWidth: 160
            implicitHeight: 30
            color: "white"
            radius: 10
            TextInput {
                id: passwordInput

                anchors.centerIn: parent
                width: parent.width

                echoMode: TextInput.Password
                focus: true
                enabled: !root.context.unlockInProgress

                onTextChanged: root.context.currentText = this.text
                onAccepted: root.context.tryUnlock()

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
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Unlock"
            focusPolicy: Qt.NoFocus
            enabled: !root.context.unlockInProgress && root.context.currentText !== ""
            onClicked: root.context.tryUnlock()
        }

        Label {
            visible: root.context.showFailure
            text: "Incorrect password"
        }
    }
}
