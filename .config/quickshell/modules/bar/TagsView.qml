import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.utils.river

Row {
    spacing: 2
    Repeater {
        model: ScriptModel {
            values: Bedload.tags.slice(0, 9)
        }

        Rectangle {
            color: modelData.focused ? "#c0caf5" : "#565f89"
            radius: 10
            implicitHeight: 20
            implicitWidth: modelData.active ? modelData.focused ? 20 : 10 : 0
            visible: width >= 10

            Text {
                text: modelData.id
                anchors.centerIn: parent
                font.family: "Giphurs"
                font.bold: true
                color: "#1a1b26"
            }

            Behavior on color {
                ColorAnimation {
                    duration: 250
                    easing.type: Easing.OutExpo
                }
            }
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutExpo
                }
            }
        }
    }
}
