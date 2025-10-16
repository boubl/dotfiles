import QtQuick

import qs.utils

Rectangle {
    id: root
    property string text: ""
    required property string icon

    signal clicked

    radius: Math.min(height, width) / 2
    color: mouseArea.containsMouse ? mouseArea.pressed ? Colors.fg_gutter : Colors.orange : Colors.fg

    Row {
        padding: 10
        spacing: 5
        anchors.centerIn: parent
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
            visible: root.text.length > 0
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
