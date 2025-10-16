import QtQuick
import QtQuick.Layouts

import qs.utils

Rectangle {
    id: root
    required property bool checked
    required property string text
    required property string icon

    signal clicked(bool checked)

    radius: checked ? height / 2 : 15
    color: checked ? Colors.orange : Colors.fg

    Row {
        padding: 10
        spacing: 5
        anchors.verticalCenter: parent.verticalCenter
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            font.family: "Symbols Nerd Font"
            font.pointSize: 16
            color: Colors.bg
        }
        StylizedText {
            anchors.verticalCenter: parent.verticalCenter
            text: root.text
            color: Colors.bg
            font.pointSize: 12
        }
    }

    Behavior on radius {
        NumberAnimation {
            duration: 75
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked(!root.checked)
    }
}
