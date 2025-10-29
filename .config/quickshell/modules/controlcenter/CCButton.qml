import QtQuick
import QtQuick.Effects

import qs.services.matugen
import qs.utils

Item {
    id: root
    property string text: ""
    required property string icon

    signal clicked

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

        radius: mouseArea.pressed ? height / 3 : height / 2
        color: mouseArea.pressed ? Qt.darker(Matugen.system.secondary_container, 1.2) : Matugen.system.secondary_container

        Row {
            padding: 10
            spacing: 5
            anchors.centerIn: parent
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.icon
                font.family: "lucide"
                font.pointSize: 16
                color: Matugen.system.on_secondary_container
            }
            StylizedText {
                anchors.verticalCenter: parent.verticalCenter
                text: root.text
                font.pointSize: 12
                visible: root.text.length > 0
                color: Matugen.system.on_secondary_container
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
            onClicked: root.clicked()
        }
    }
}
