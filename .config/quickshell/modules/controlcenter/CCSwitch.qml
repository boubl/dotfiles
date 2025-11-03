import QtQuick
import QtQuick.Effects

import qs.services.matugen
import qs.utils

Item {
    id: root
    required property bool checked
    required property string text
    required property string icon

    signal clicked(bool checked)

    RectangularShadow {
        anchors.fill: bg
        offset.y: mouseArea.containsMouse ? 3 : 0
        radius: bg.radius
        blur: mouseArea.containsMouse ? 5 : 0
        spread: 0
        color: Qt.darker(bg.color, 1.6)

        Behavior on blur {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
        Behavior on offset.y {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    Rectangle {
        id: bg
        anchors.fill: parent

        radius: 8
        color: checked ? Matugen.system.secondary : Matugen.system.secondary_container

        Row {
            padding: 15
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                font.family: "lucide"
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
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked(!root.checked)
        }
    }
}
