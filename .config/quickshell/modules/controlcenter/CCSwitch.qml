import QtQuick
import QtQuick.Layouts

import qs.services.matugen
import qs.utils

Rectangle {
    id: root
    required property bool checked
    required property string text
    required property string icon

    signal clicked(bool checked)

    radius: checked ? height / 3 : height / 2
    color: checked ? Matugen.system.secondary : Matugen.system.secondary_container

    Row {
        padding: 15
        spacing: 10
        anchors.verticalCenter: parent.verticalCenter
        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            font.family: "Symbols Nerd Font"
            font.pointSize: 16
            color: checked ? Matugen.system.on_secondary : Matugen.system.on_secondary_container
            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.OutExpo
                }
            }
        }
        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: -2
            StylizedText {
                color: checked ? Matugen.system.on_secondary : Matugen.system.on_secondary_container
                text: root.text
                font.pointSize: 12
                font.weight: 650
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                        easing.type: Easing.OutExpo
                    }
                }
            }
            StylizedText {
                color: checked ? Matugen.system.on_secondary : Matugen.system.on_secondary_container
                text: checked ? "On" : "Off"
                font.pointSize: 12
                font.weight: 350
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                        easing.type: Easing.OutExpo
                    }
                }
            }
        }
    }

    Behavior on radius {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutExpo
        }
    }
    Behavior on color {
        ColorAnimation {
            duration: 200
            easing.type: Easing.OutExpo
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked(!root.checked)
    }
}
